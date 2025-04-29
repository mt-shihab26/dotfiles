# Grep

```sh
grep [options] pattern [file...]
```

```sh
grep Port /etc/ssh/ssh_config # search for word
grep -i port /etc/ssh/ssh_config # case insensitive search for word
grep -n port /etc/ssh/ssh_config # show number line search for word
grep -r Port /etc/ssh # search recursively in directories
grep -r Po.t /etc/ssh/ssh_config # search with regular expression (dot match any character)
grep -v Port /etc/ssh/ssh_config # invert search (show lines that don't match "Port")
grep -c Port /etc/ssh/ssh_config # count matches
grep -w Port /etc/ssh/ssh_config # match whole word match
grep -E "Port|no" /etc/ssh/ssh_config # multiple pattern (or logic)
```
