howto.sh
========

the bash version of
https://github.com/antonmedv/howto


## usage
in bash

1.setup
```bash
$ source deepseek.sh
$ DEEPSEEK_APIKEY='your deepseek apikey'
```

2.usage demo
```bash
$ howto 'find files modified today'
== cmd is: find / -type f -mtime 0
$ find / -type f -mtime 0      <=== this line input by script
```

deepseek query is slow (about 4 seconds)

