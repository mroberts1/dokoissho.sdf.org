---
title: Fetching JSON data with Emacs Lisp
date: 2019-10-19
---

The following snippet of Emacs Lisp will fetch a remote URI and return the
contents as a parsed JSON object.

```elisp
(defun get-json (uri)
  "Fetch the contents of URI and parse."
  (with-current-buffer (url-retrieve-synchronously uri)
    (goto-char (point-min))
    (goto-char url-http-end-of-headers)
    (prog1 (json-read)
      (kill-buffer))))
```

Something like:

```json
{
   "field" : "value"
}
```

will return an object like this:

```elisp
'((field . "value"))
```
