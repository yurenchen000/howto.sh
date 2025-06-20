howto.sh
========

the bash version of
https://github.com/antonmedv/howto


[![asciicast demo1](https://asciinema.org/a/721054.svg)](https://asciinema.org/a/721054)

[![asciicast demo2](https://asciinema.org/a/721064.svg)](https://asciinema.org/a/721064)

## usage
in bash

### 1. setup
```bash
$ source deepseek.sh  bind1
$ HOWTO_APIKEY='your deepseek apikey'
```

<br>

### 2. usage demo

```console
$ howto find files modified today
== cmd is: find / -type f -mtime 0
$ find / -type f -mtime 0      <### this line auto-inputed by howto.sh, omitted in later

$ howto git clone use ssh:// for 'ssh android@localhost -p 4022' /tmp/test1
$                              <### sometime i forget the git url scheme
== cmd is: git clone ssh://android@localhost:4022/tmp/test1

$ howto convert demo2.gif to demo2.mp4, frame rate 30, twitter compatible  
$                              <### i guess no one remember all the parameters
== cmd is: ffmpeg -i demo2.gif -vf "fps=30,scale=trunc(iw/2)*2:trunc(ih/2)*2" -c:v libx264 -pix_fmt yuv420p demo2.mp4
```

<br>

note1:
AI may make mistakes, check before pressing Enter

note2:
deepseek query is slow (about 4 seconds)

<br>


> TIPS: `Ctrl + G` will prepend `howto` cmd and query

<br>

### 3. use ctrl+g completion

```bash
bind -x '"\C-g": "c_howto"'
```  
//this will show howto in cli & history

OR

```bash
bind -x '"\C-g": "c_howto2"'
```
//this not show howto in cli & history

then input the search string, for example:

$ find files modified today

then press `Ctrl+G` to trigger completion

<br>

## Other Bash Script

[![other bash repos](https://res.ez2.fun/svg/repos-bash_script.svg)](https://github.com/yurenchen000/yurenchen000/blob/main/repos.md#bash-scripts)

