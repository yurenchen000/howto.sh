#!/bin/bash

# Do not run, just
#   source this script into your current interactive bash
# And
#   export DEEPSEEK_APIKEY='your deepseek apikey'
# Run demo
#   howto 'find files modified today'


prompt(){
	local CMD=$1
	local OS=${2:-linux}
	cat <<EOF
You are a command line assistant that can help users with their tasks.
User want assistance with the following command:

$CMD

Assistant should respond with a command that can be used to achieve the desired result.
Command shoud be suitable for $OS OS.
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
	w=`prompt "$w"`
	w="${w//$'\n'/\\n}"

	## send request
	curl https://api.deepseek.com/v1/chat/completions  -H "Content-Type: application/json"   -H "Authorization: Bearer $DEEPSEEK_APIKEY"   -d \
 '{
    "model": "deepseek-chat",
    "messages": [
      {"role": "user", "content": "'"$w"'"}
    ],
    "temperature": 0.3, "max_tokens": 50
  }' | tee /tmp/deepseek.out

	## parse result
	echo
	echo
	local o
	o=`cat /tmp/deepseek.out | jq -r '.choices[].message.content'`
	echo "== cmd is: $o"
	o="${o//$'\n'/}"
	o="${o//\"/\\\"}"
	input_to_bash "$o"
}

howto(){
	deepseek "$@"
}

