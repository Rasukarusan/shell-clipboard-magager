# shell-clipboard-manager

Clipboard manager by ShellScript

![Demo](https://rasukarusan.github.io/blog-assets/shell_clipboard/demo1.gif)


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


