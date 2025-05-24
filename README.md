howto.sh
========

the bash version of
https://github.com/antonmedv/howto

[![asciicast](https://asciinema.org/a/B43e3pPcFEqYt3QdnAhGB6TTN.svg)](https://asciinema.org/a/B43e3pPcFEqYt3QdnAhGB6TTN)

## usage
in bash

### 1. setup
```bash
$ source deepseek.sh
$ DEEPSEEK_APIKEY='your deepseek apikey'
```

### 2. usage demo
```bash
$ howto 'find files modified today'
== cmd is: find / -type f -mtime 0
$ find / -type f -mtime 0      <=== this line input by script
```

deepseek query is slow (about 4 seconds)


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

