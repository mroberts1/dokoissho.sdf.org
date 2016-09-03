---
title: 'Common Lisp: Read a file into a string'
date: 2016-09-02
---

There's a couple of ways to do this. `with-open-file` takes care of opening and
closing the stream:

```common-lisp
(defun file-get-contents (filename)
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      contents)))
```

To return the file as a list of lines instead, the `loop` macro can be used:

```common-lisp
(defun file-get-lines (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))
```
