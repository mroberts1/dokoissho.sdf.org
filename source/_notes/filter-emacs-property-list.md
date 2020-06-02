---
title: Filtering an Emacs Lisp property list
date:  2020-06-02
---

In Emacs Lisp, a property list (`plist`) looks like this:

```lisp
(list :property1 "value1" :property2 "value2)
```

I'm currently working on [beeminder.el](/projects/beeminder.el/) and wanted to
add some optional parameters to a function. Emacs Lisp doesn't support `&key`
named parameters, so normally there isn't a way to do something like this:

```lisp
(my-function "required" "also-required" :optional "value")
```

I settled on passing a `plist`, but wanted a way to whitelist keys. The
following function will filter the `options` list to only include keys that are
in `allowed`.

It will probably re-order the list, but for a property list that usually isn't
an issue.

```lisp
(defun filter-plist (options allowed)
  "Filter a symbol and values list OPTIONS to online include ALLOWED symbols.

For example, filtering (:key value :other-key value) with allowed
list of (:key) will return (:key value)."
  (let ((filtered-list))
    (dolist (key allowed)
      (when (plist-member options key)
        (setq filtered-list
              (plist-put filtered-list key (plist-get options key)))))
    filtered-list))
```

This allows us to do this:

```lisp
;; List of parameters. Only want the :valid key/value pair.
(setq test-list (list :valid "value" :invalid "bad"))

(filter-plist test-list (list :valid))
;; => (:valid "value")
```
