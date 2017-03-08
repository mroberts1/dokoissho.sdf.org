---
title: Emacs Lisp - Searching parent folders for a file
date: 2017-03-08

---

This code searches a directory for a filename. If the file is not found, the
parent directory is searched. It continues searching upwards until the file is
found or there are no more directories to search.

If the file is found its full path is returned, otherwise `NIL` is returned.

```emacs-lisp
(defun sodaware/file-search-upward (directory file)
  "Search DIRECTORY for FILE and return its full path if found, or NIL if not.

If FILE is not found in DIRECTORY, the parent of DIRECTORY will be searched."
  (let ((parent-dir (file-truename (concat (file-name-directory directory) "../")))
        (current-path (if (not (string= (substring directory (- (length directory) 1)) "/"))
                         (concat directory "/" file)
                         (concat directory file))))
    (if (file-exists-p current-path)
        current-path
        (when (and (not (string= (file-truename directory) parent-dir))
                   (< (length parent-dir) (length (file-truename directory))))
          (sodaware/file-search-upward parent-dir file)))))
```

## Example usage

Given the following directory structure:

```
|-- dir1
    |-- my_file.txt
    |-- dir2
        |-- dir3
```

Searching `dir3` will also search `dir2` and `dir1`:

```emacs-lisp
;; Finding a file that exists in a parent directory.
(sodaware/file-search-upward "/dir1/dir2/dir3/" "my_file.txt")
=> "/dir1/my_file.txt"

;; Failing to find a file.
(sodaware/file-search-upward "/dir1/dir2/dir3/" "not_found.txt")
=> NIL
```
