poll
===

**poll** is a polling utility for [fish shell](https://fishshell.com).

**poll** executes the command passed as its first argument repetedly. When the output changes, **poll** executes the command passed as its second argument.

Usage
---

```sh
poll [-e] [-n COUNTS] [-s SECONDS] [-h] IN OUT
```

### Args
```
<IN>                     Command to be run for polling
<OUT>                    Command to be run when the output of the polling was changed
```

### Options
```
-e, --exit               Quit after triggering OUT command
-n, --num <COUNTS>       Max number of attempts for polling
-s, --sleep <SECONDS>    Interval between polling
-h, --help               Print help
```

Example
---

Check if a file at `/path/to/watch` is changed every 60 seconds.

```sh
poll -s 60 'cat /path/to/watch' 'beep -f 100 -l 500'
```

Installation
---

[fisher](https://github.com/jorgebucaran/fisher) is recommended to install **poll**.

```sh
fisher add slaypni/poll
```

System Requirements
---

- [fish](https://github.com/fish-shell/fish-shell) 2.7+
