---
title: Automatic Emacs theme switching in OSX dark mode
date:  2020-06-27
---

The following snippet of code will automatically switch between themes if OSX is
using light or dark mode.

Call using `M-x match-emacs-theme-to-system`. Replace `'dark-theme` and
`'light-theme` with appropriate theme names.

```lisp
(defun match-emacs-theme-to-system ()
  "Automatically set the theme to match if OSX is in dark mode."
  (interactive)

  (if (system-dark-mode-enabled-p)
      (load-theme 'dark-theme  t)
      (load-theme 'light-theme t)))

(defun system-dark-mode-enabled-p ()
  "Check if dark mode is currently enabled on OSX."
  (if (string= system-type "darwin")
      (string=
       (shell-command-to-string "printf %s \"$( osascript -e \'tell application \"System Events\" to tell appearance preferences to return dark mode\' )\"")
       "true")
      nil))

(match-emacs-theme-to-system)
```

