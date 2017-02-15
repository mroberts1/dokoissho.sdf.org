---
title: Marking all items as read in elfeed
date: 2017-02-15
---

[Elfeed](https://github.com/skeeto/elfeed) is an excellent RSS reader for
Emacs. Recently
[this issue on GitHub](https://github.com/skeeto/elfeed/issues/197) asked how to
add a yes/no prompt before marking all items as read.

Here's a simple function that marks all RSS items as read before fetching new
posts:

```elisp
(defun sodaware/elfeed-all-read-refresh ()
  (interactive)
  (when (y-or-n-p "Really mark all items as read?")
    (elfeed-mark-all-as-read)
    (elfeed-search-fetch nil)))
```

