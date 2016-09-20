---
title: 'Common Lisp: Convert a list into an alist'
date: 2016-09-19
---

This function converts a list of values into an association list
(alist).

```common-lisp
(defun list->alist (items)
  "Convert a list into an alist."
  (loop for item from 0 to (1- (length items)) by 2
     for key = (nth item items)
     for data = (nth (1+ item) items)
     nconc (acons key data nil)))
```

## Basic example

Running `list->alist` on this input:

```common-lisp
(list :key1 "value1" :key2 "value2" :key3 "value3")
```

produces the following output:

```common-lisp
((:key1 . "value1")
 (:key2 . "value2")
 (:key3 . "value3"))
```

