# shell-clipboard-manager

Clipboard manager by ShellScript

![Demo]()

# Requirement

- OS X
- fzf

# Setting

Register clipObserver.sh in crontab。

```sh
$ crontab -e
* * * * * for i in `seq 0 5 59`;do (sleep ${i}; sh ~/clipObserver.sh) & done;
```

# Usage

It's easy running to register in the alias.

```sh
alias cl='sh ~/clipboard.sh'
```

*Run*
```sh
$ cl

# or

$ sh clipboard.sh
```


