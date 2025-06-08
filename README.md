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
```bash
$ howto find files modified today
== cmd is: find / -type f -mtime 0
$ find / -type f -mtime 0      <=== this line input by script
```

deepseek query is slow (about 4 seconds)

<br>


> TIPS: `Ctrl + G` will prepend `howto` cmd and run

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

