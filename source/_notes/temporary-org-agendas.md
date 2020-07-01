---
title: Temporary org-agendas
date:  2020-06-30
---

This is a really simple way to run org-agenda commands on just a single
file:

```lisp

(defun sodaware/agenda-for-my-file ()
  "Run org-agenda on a single file."
  (interactive)
  (let ((org-agenda-files '("/full/path/to/my.org")))
    (org-agenda)))
```

The following version also creates an agenda for a single file, but prompts for
the file name first:

```lisp
(defun sodaware/agenda-for-single-file (file)
  "Run org-agenda on FILE."
  (interactive "FEnter a file name: ")
  (let ((org-agenda-files (list file)))
    (org-agenda)))
```
