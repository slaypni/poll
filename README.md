poll
===

**poll** is a polling utility for [fish shell](https://fishshell.com).

**poll** executes the command passed as its first argument repetedly. When the output changes, **poll** executes the command passed as its second argument.

Usage
---

```sh
poll [-n COUNTS] [-s SECONDS] IN OUT
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

- [fish](https://github.com/fishshell) 2.7+
