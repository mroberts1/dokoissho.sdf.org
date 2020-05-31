---
title: Filtering org-projectile files
date: 2020-03-07
---

[org-projectile](https://github.com/IvanMalison/org-projectile/) is a small
Emacs package that makes it easy to associate org-mode TODO items with
projectile projects. 

Each projectile project can have its own `TODO.org`, but sometimes projects
don't have one (or don't need one) and these empty files are still added to the
agenda.

The following function filters the `org-projectile` list of TODO files and
removes any file that doesn't actually exist.

```lisp
(defun sodaware/org-projectile-todo-files () 
  "Fetch a list of org TODO files for projects that actually exist."
  (seq-filter #'file-exists-p (org-projectile-todo-files)))

;; Add org-projectile files to org.
(setq org-agenda-files (append org-agenda-files (sodaware/org-projectile-todo-files)))
```
