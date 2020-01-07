---
title: Enabling lsp-mode for solargraph projects
date:  2019-12-28
---

I've started using `lsp-mode` in Emacs to add some smarter auto-completion and
tooltips. I wanted to try and activate `lsp-mode` automatically when editing
files in a Rails project, but only if solargraph is in the `Gemfile`.

I'm not sure this is actually something I'll keep using, but it was a fun
exercise.

```lisp
(add-hook 'enh-ruby-mode-hook #'sodaware/enable-lsp-for-solargraph-projects)

(defun sodaware/enable-lsp-for-solargraph-projects ()
  "Enable lsp-mode if the current project has solargraph installed."
  (when (sodaware/has-solargraph-p)
    (lsp)))

(defun sodaware/has-solargraph-p ()
  "Check if the current Rails project has solargraph installed."
  (let* ((root    (sodaware/get-closest-gemfile-root))
         (gemfile (concat root "/Gemfile")))
    (unless nil
      (with-temp-buffer
        (insert-file-contents gemfile)
        (search-forward "solargraph" nil t)))))

(defun* sodaware/get-closest-gemfile-root (&optional (file "Gemfile"))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.

This may not do the correct thing in presence of links. If it does not find
FILE, then it shall return the name of FILE in the current directory, suitable
for creation."
  (let ((root (expand-file-name "/")))
    (loop
     for d = default-directory then (expand-file-name ".." d)
     if (file-exists-p (expand-file-name file d))
     return d
     if (equal d root)
     return nil)))
```

It's not particularly elegant, and I think there will be performance problems
for with larger `Gemfile`s.
