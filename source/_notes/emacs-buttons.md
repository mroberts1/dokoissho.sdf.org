---
title: Inserting buttons into Emacs buffers
date:  20-06-2020
---

This is something I discovered during development of
[beeminder.el](/projects/beeminder.el/) version 1.2. I wanted to have some text
in the buffer saying "View all data" that would perform an action when clicked
or when the user pressed <kbd>RET</kbd> on it.

I tried a couple of approaches, such as setting text properties in the buffer
and then searching at the current point when <kbd>RET</kbd> was pressed. But
those solutions didn't feel right.

Finally, I discovered the `insert-button` function which does what I wanted.

The previous code looked a little like this:

```lisp
(insert "View all data")
(put-text-property (line-beginning-position)
                   (line-end-position)
                   'beeminder-is-read-more
                   t)

(defun beeminder-handle-view-all-data-link ()
  "Handle a click on the 'Read more data' text."
  (when (get-text-property (point) 'beeminder-is-read-more)
        (beeminder-view-data-for-current-goal)))

;; Bind to <RET>
(define-key beeminder-mode-map
            (kbd "<RET>")
            #'beeminder-handle-view-all-data-link)
```

It's not the cleanest code ever, and it's a lot of effort for a simple
button. By using `insert-button`, it now looks like this:

```lisp
(insert-button "View all data"
               'action (lambda (_arg) (beeminder-view-data-for-current-goal)))
```

Much better!

**Read more**: [Buttons - GNU Emacs Lisp Reference Manual](https://www.gnu.org/software/emacs/manual/html_node/elisp/Buttons.html).
