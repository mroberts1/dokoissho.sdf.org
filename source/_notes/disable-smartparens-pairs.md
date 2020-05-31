---
title: Disabling global smartparens pairs in a mode
date:  2020-05-30
---

I wanted to use [smartparens](https://github.com/Fuco1/smartparens) with
[blitzmax-mode](https://www.sodaware.net/blitzmax-mode/), but the global `'`
completion was inserting two `'` characters whenever I commented a line. Not the
end of the world, but it was annoying and I wanted a solution.

**smartparens** can disable a global pair by setting `:actions nil` when using
`sp-local-pair`. For blitzmax-mode, my config looks like this:

```lisp
(use-package smartparens
  :diminish smartparens-mode
  :commands (smartparens-mode sp-local-pair)
  :hook
  ((blitzmax-mode . smartparens-mode))
  :config
  (require 'smartparens-config)

  ;; Disable ' auto-pair in blitzmax-mode.
  (sp-local-pair 'blitzmax-mode "'" nil :actions nil))
```

Now smartparens inserts a single `'` character when I comment a line, but still
inserts matching `(` and `[` characters. Perfect!
