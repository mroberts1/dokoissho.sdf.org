---
title: Adding a homepage to Zetteldeft
date:  2020-07-14
---

This is a really simple tweak to add a homepage file to [zetteldeft](https://github.com/EFLS/zetteldeft). Although I
usually use the main search page, adding a homepage makes zetteldeft act more
like a wiki.

Once this code is added to the Emacs init, running `C-c z h` will open the home
file. The `home.org` file can be any file in your deft notes directory. It
should be the local filename within the deft directory, not the full path.

```lisp
(defun sodaware/zd-homepage ()
  "Open Zetteldeft home file."
  (interactive)
  (zetteldeft-find-file "home.org"))
(global-set-key (kbd "C-c z h") #'sodaware/zd-homepage)
```
