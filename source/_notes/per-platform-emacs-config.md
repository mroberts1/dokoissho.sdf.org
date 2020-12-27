---
title: Per-platform Emacs configuration
date: 2018-05-03
---

Synchronising Emacs configuration files between machines usually works well, but
sometimes there need to be different settings for different operating system.

Thankfully, Emacs lisp provides the variable `system-type`.

For example, it can be used to set a different font depending on the os:

```emacs-lisp
;; Windows only font
(when (string= "windows-nt" system-type)
  (set-face-font 'default "Consolas"))

;; Mac OS only font
(when (string= "darwin" system-type)
  (set-face-font 'default "Monaco"))
  
;; Linux only font
(when (string= "gnu/linux" system-type)
  (set-face-font 'default "Ubuntu"))
```

**More info**:
[Gnu Emacs: Operating System Environment](https://www.gnu.org/software/emacs/manual/html%5Fnode/elisp/System-Environment.html)
