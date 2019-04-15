---
title: Elisp for adding log entries
date: 2019-04-15
---

The [logs section](/log/) of this site uses some simple markdown for
entries. An example looks like this:

```
---
title: 2019
layout: log
---

## 2019-04-15

* This is a log entry.
```

I wanted to try writing a little bit of elisp code to streamline the process of
adding new entries. It's not exactly time-consuming to add a few new lines by
hand, but reducing friction means I'm more likely to keep things updated.

Each log file is stored in `_logs` inside the jekyll source directory:

```
- src
  - _posts
  - _notes
  - _logs
    - 2019.md
```

In the end I came up with the following code:

```elisp
(defvar sodaware/sdf-logs-path "/path/to/jekyll/src/_logs/")

(defun sodaware/sdf-log ()
  "Add a new entry to the current sodaware.sdf.org log."
  (interactive)
  (let* ((current-year (format-time-string "%Y"))
         (current-date (format-time-string "%Y-%m-%d"))
         (log-file     (format "%s%s.md" sodaware/sdf-logs-path current-year)))
    ;; Find the log file.
    (find-file log-file)

    ;; Add Jekyll markup if file is empty.
    (when (= 0 (buffer-size))
      (insert "---" "\n")
      (insert "title: " current-year "\n")
      (insert "layout: log\n")
      (insert "---" "\n\n")
      (insert (format "## %s\n\n" current-date)))

    ;; Attempt to find the current heading. If not found, insert it.
    (sodaware/find-or-insert-heading (format "## %s" current-date) "## ")

    ;; Insert after.
    (forward-line 2)
    (insert "* \n")
    (forward-line -1)
    (move-end-of-line 1)))

(defun sodaware/find-or-insert-heading (heading start-of-heading)
  "Find or insert HEADING before START-OF-HEADING in the current buffer."
  ;; Go to the start of the file.
  (goto-char (point-min))

  ;; Search for the heading. If not found, find the start of the first heading
  ;; and insert before that.
  (unless (search-forward heading nil t)
    (goto-char (point-min))
    (search-forward start-of-heading)
    (move-beginning-of-line 1)
    (insert "\n\n")
    (forward-line -2)
    (insert heading "\n")
    (forward-line -1))

  (move-beginning-of-line 1))

```

## Notes

- `sodaware/sdf-logs-path` 
: The full path of the log directory.

- `sodaware/find-or-insert-heading`
: A utility function function that searches for a headline in the current buffer. If the
  headline is not found, it will be inserted above the first headline in the
  file. It's not Markdown specific, so something like
  `(sodaware/find-or-insert-heading "** heading" "** ")` would work for org-mode
  headlines.

- `sodaware/sdf-log`
: The main function to call when adding a new entry. It opens the log file for
  the current year and inserts a timestamp heading before the first headline. If
  the file does not exist, it is created and filled with Jekyll markup and the
  first headline.

## Future improvements

I'm not 100% happy with how things currently work. I'd like to split things up
further so I can reuse the main note creation function for other projects. I
often keep project development logs in markdown format and it would be handy to
use the same skeleton code for adding entries to them.
