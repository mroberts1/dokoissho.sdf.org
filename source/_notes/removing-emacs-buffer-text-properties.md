---
title: Removing text properties from an Emacs buffer
date: 2018-03-29

---

I wanted to write tests for [blitzmax-mode](/projects/blitzmax-mode/)
indentation to make sure everything worked correctly. The approach was something
like this:

  1. Load a properly-formatted file into a buffer
  2. Enable the major mode for the buffer
  3. Indent the entire file
  4. Compare the indented buffer with the original file and fail the test if
     they don't match

The problem with the above approach is that `buffer-string` also returns
formatting information for the buffer. This causes all comparisons to fail as
the indented buffer contains highlight information.

Luckily the solution is quite simple:

```emacs-lisp
(defun cleaned-buffer-string ()
  "Get \"buffer-string\" without any fontification data."
  (let ((buffer (buffer-string)))
    (set-text-properties 0 (length buffer) nil buffer)
    buffer))
```

This returns the entire contents of the buffer as a clean string.
