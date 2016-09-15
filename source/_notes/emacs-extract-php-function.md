---
title: Extracting a PHP function with Emacs Lisp
date: 2016-09-15
---

This snippet moves the currently selected region to a new function and replaces
it with a call to that function. It's not meant for heavy refactoring but it's
ok for quick bits of code cleanup.

![Terrible Example](/assets/images/php-extract-function.gif){:class="centered bordered"}

A little bit of work needs to be done after extracting code, but it's slightly
quicker than doing the whole thing manually.

```emacs-lisp
(defun php-extract-function (start end name)
  "Moves the currently marked text to a new function"

  ;; Prompt for new method name
  (interactive "r\nsNew Function Name: ")

  ;; Kill selected region
  (kill-region start end)

  ;; Insert call to new function
  (insert "\n" name "();\n")

  ;; Set a marker so we can jump back to this line
  (point-to-register 1)

  ;; Move to end of current function
  (php-end-of-defun)

  ;; Insert new function
  (insert "\n\nfunction " name "() {\n"
	  (car kill-ring-yank-pointer)
	  "\n}\n")

  ;; Jump back to where function was snipped from
  (jump-to-register 1))
```
  
