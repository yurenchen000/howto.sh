#!/bin/bash

# Do not run, just
#   source this script into your current interactive bash
# And
#   export HOWTO_APIKEY='your deepseek apikey'
# Run demo
#   howto 'find files modified today'

## for OpenAI
# HOWTO_APIURL='https://api.openai.com/v1/chat/completions'
# HOWTO_APIKEY='YOUR OPENAI APIKEY'
# HOWTO_MODEL='gpt-4o'

## for DeepSeek
HOWTO_APIURL='https://api.deepseek.com/v1/chat/completions'
HOWTO_APIKEY=${HOWTO_APIKEY:-'YOUR DEEPSEEK APIKEY'}
HOWTO_MODEL=${HOWTO_MODEL:-'deepseek-chat'}

HOWTO_OS=${HOWTO_OS:-linux}

howto_prompt(){
	local CMD=$1
	cat <<EOF
You are a command line assistant that can help users with their tasks.
User want assistance with the following command:

$CMD

Assistant should respond with a command that can be used to achieve the desired result.
Command shoud be suitable for $HOWTO_OS OS.
Output only the command, do not include any additional text. 
Do not include any quotes or backticks in the output.
EOF
}

## input to bash
input_to_bash(){
	local cmd="$1"
	bind '"\e[0n": "'"$cmd"'"'
	printf "\e[5n"
}

## query deepseek
deepseek(){
	local w=$1
	w="${w//\"/\\\"}"
	w=`howto_prompt "$w"`
	w="${w//$'\n'/\\n}"

	echo -n 'running..'
	## send request
	local o
	o=`curl "$HOWTO_APIURL" --silent \
		-H "Content-Type: application/json"  -H "Authorization: Bearer $HOWTO_APIKEY"   -d \
 '{
    "model": "'"$HOWTO_MODEL"'",
    "messages": [
      {"role": "user", "content": "'"$w"'"}
    ],
    "temperature": 0.2, "max_tokens": 100
  }'`

	[ -n "$HOWTO_DEBUG" ] && echo "$o" >/tmp/deepseek.out
	## parse result
	#echo
	o=`echo "$o" | jq -r '.choices[].message.content'`
	echo -e "\r== cmd is: \e[32m$o\e[0m"
	HOWTO_RESULT="$o"
}

howto(){
	local o
	echo -e "== howto: \e[33m$*\e[0m"
	deepseek "$*"
	o="$HOWTO_RESULT"
	o="${o//$'\n'/}"
	o="${o//\"/\\\"}"
	input_to_bash "$o"
}

## show howto cmd in cli
c_howto(){
	local o
	#echo "== howto: $READLINE_LINE"
	#deepseek "$READLINE_LINE"
	READLINE_LINE='howto '"$READLINE_LINE"
	READLINE_POINT=${#READLINE_LINE}
	#input_to_bash 'howto '"$READLINE_LINE"
	input_to_bash $'\n'
	return
}

## not show howto cmd in cli
c_howto2(){
	local o
	echo -e "== howto: \e[33m$READLINE_LINE\e[0m"
	deepseek "$READLINE_LINE"

	o="$HOWTO_RESULT"
	o="${o//$'\n'/}"
	o="${o//\"/\\\"}"
	READLINE_LINE="$o"
	READLINE_POINT=${#READLINE_LINE}
}


## check if sourced
is_sourced(){
    [ "$0" != "$BASH_SOURCE" ]
}

is_sourced || {
  echo -e "  Usage: \e[033m source $0\e[0m"
  echo -e "  Usage: \e[033m source $0 bind1\e[0m"
  echo -e "  Usage: \e[033m source $0 bind2\e[0m"
  exit 1
}

# use one of:
#  bind -x '"\C-g": "c_howto"'
#  bind -x '"\C-g": "c_howto2"'

## Ctrl+G to completion
#echo "\$1: $1"
[ "$1" == "bind1" ] && bind -x '"\C-g": "c_howto"'
[ "$1" == "bind2" ] && bind -x '"\C-g": "c_howto2"'


