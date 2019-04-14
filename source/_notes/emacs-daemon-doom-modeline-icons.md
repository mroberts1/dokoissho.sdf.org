---
title: Enabling doom-modeline icons when using daemon mode
date: 2019-01-22
---

[doom-modeline](https://seagle0128.github.io/doom-modeline/) disables modeline
icons when running Emacs in daemon mode. This caused me much head-scratching,
but I came across two solutions:

The quickest is to set `doom-modeline-icon` to `t` during initialization. This
works fine, but if you connect emacs from the terminal using `emacsclient -nw`
things can look a little weird.

Adding the following to my "init.el" file does the same thing, but only enables
icons the first time a window frame is opened:

```elisp
(defun enable-doom-modeline-icons (_frame)
  (setq doom-modeline-icon t))
  
(add-hook 'after-make-frame-functions 
          #'enable-doom-modeline-icons)
```

I'm still looking for a way to switching icons on and off when switching between
a terminal and windowed session. This does things well enough for now.
