---
title: Emacs Lisp - Loading a custom configuration file
date: 2017-03-09
---

`.dir-locals.el` is a great way to store directory-specific configuration
values. However you don't always want to clog it up when writing a custom
extension.

This function searches a directory (and its parents) for a named file. The file
is loaded if found. An error is raised if the file is not found.

For the `sodaware/file-search-upward` function see
"[Emacs Lisp - Searching parent folders for a file](/notes/emacs-lisp-find-file-upwards/)".

```emacs-lisp
(defun sodaware/load-custom-config (filename directory)
  "Loads a configuration FILENAME from DIRECTORY.

If not found in the current directory, will search upwards until one is found."
  (let ((config-file-path (sodaware/file-search-upward directory filename)))
    (unless (and config-file-path
                 (file-exists-p config-file-path))
      (error (format "Could not find configuration file '%s'" filename)))
    (message (format "Loading configuration file: %s" config-file-path))
    (load-file config-file-path)))
```

## Example usage

### 1. Loading a configuration

Assuming `.config.el` exists in `/some/dir/`:

```emacs-lisp
(sodaware/load-custom-config ".config.el" "/some/dir/")
=> t
```

Assuming `.invalid.el` does not exist in `/some/dir/`:

```emacs-lisp
(sodaware/load-custom-config ".invalid.el" "/some/dir/")
;; => Could not find configuration file '.bad.el'
```

### 2. Loading a configuration based on the current file

Emacs provides the variable `buffer-file-name` which contains the full path of
the currently edited buffer.

This example searches for a configuration file using the current buffer's path:

```emacs-lisp
(sodaware/load-custom-config ".config.el" (file-name-directory buffer-file-name))
```


## Without error raising

This is a modified version of the original function. It still searches parent
directories for the configuration file, but will return `NIL` if the file is not
found instead of raising an error.

```emacs-lisp
(defun sodaware/load-custom-config (filename directory)
  "Loads a configuration FILENAME from DIRECTORY.

If not found in the current directory, will search upwards until one is found."
  (let ((config-file-path (sodaware/file-search-upward directory filename)))
    (when (and config-file-path
               (file-exists-p config-file-path))
      (load-file config-file-path))))
```


