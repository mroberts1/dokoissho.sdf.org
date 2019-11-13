---
title: Showing Emacs dashboard on launch
date:  2019-11-13
---

[Emacs dashboard](https://github.com/emacs-dashboard/emacs-dashboard) creates a
startup page for Emacs that gives quick access to projects, recent files and
even org-mode agenda items.

The following code configures Emacs to show the `*dashboard*` buffer after
launch. It works with `emacsclient` as well.

```lisp
(setq initial-buffer-choice #'(lambda () (get-buffer-create "*dashboard*")))
```
