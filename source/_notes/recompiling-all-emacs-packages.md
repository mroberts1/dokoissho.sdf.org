---
title: Recompiling all Emacs packages
date:  2020-12-27
---

To re-compile all packages installed from Melpa/Elpa, use
`byte-recompile-directory`. This can be called via `M-:`:

`M-: (byte-recompile-directory package-user-dir nil 'force)`

Emacs will need to be restarted for the compiled changes to load.
