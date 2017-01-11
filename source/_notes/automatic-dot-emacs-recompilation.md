---
title: Automatic .emacs recompilation
date: 2016-10-31
---

Byte-compiled Elisp files run faster. This snippet will automatically recompile
`~/.emacs` when it's saved in the editor.

```elisp
(defun sodaware/autocompile-emacs-configuration ()
  "Automatically compile changes to ~/.emacs"
  (when (eq major-mode 'emacs-lisp-mode)
    (sodaware/compile-elisp-file "~/emacs")))

(defun sodaware/compile-elisp-file (file-name)
  "Byte-compile FILE-NAME if it exists."
  (let ((elisp-file (expand-file-name file-name)))
    (if (string= (buffer-file-name) (file-chase-links elisp-file))
        (byte-compile-file elisp-file))))

;; Run the auto-compile function when an Elisp file is saved
(add-hook 'after-save-hook #'sodaware/autocompile-emacs-configuration)
```

I have a couple of different files in my `~/.emacs.d/` directory, but it's easy
to modify the `sodaware/autocompile-emacs-configuration` function to support
multiple files:

```elisp
(defun sodaware/autocompile-emacs-configuration ()
  "Automatically compile changes to ~/.emacs"
  (when (eq major-mode 'emacs-lisp-mode)
    (mapc #'sodaware/compile-elisp-file
          (list "~/.emacs"
                "~/.emacs.d/init.el"
                "~/.emacs.d/my-email.el"
                ;; ... and more
                "~/.emacs.d/my-news.el"))))
```
