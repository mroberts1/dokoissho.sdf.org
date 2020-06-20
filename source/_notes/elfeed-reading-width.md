---
title: Limiting the elfeed read buffer to 80 columns
date:  20-06-2020
---

[elfeed](https://github.com/skeeto/elfeed) is a really neat RSS reader for
Emacs. By default, the reading buffer uses the full width of the window. This
can make articles difficult to read on a large, widescreen monitor.

Adding the following to the Emacs config limits the reading with to 80 columns:

```lisp
(setq shr-width 80)
```
