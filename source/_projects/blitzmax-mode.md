---
title: blitzmax-mode
github: sodaware/blitzmax-mode
description:
  A GNU Emacs major mode for editing BlitzMax files.
---

This project adds a new major mode to GNU Emacs for editing BlitzMax source
files. It supports keyword highlighting and automatic indentation.


## Installation

To manually install this extension:

  1. Download the source code and put it somewhere Emacs can find it (probably
     `~/.emacs.d/`).
  2. Add that directory to your `load-path` if it's not yet there: 
    `(add-to-list 'load-path "/path/to/blitzmax-mode")`
  3. Require the mode:
     `(require 'blitzmax-mode)`

Once everything is loaded, blitzmax-mode can be enabled for a buffer by running
`M-x blitzmax-mode`. The mode also associates itself with `.bmx` files, so they
will automatically switch to `blitzmax-mode** when enabled.


## Configuration

**blitzmax-mode** provides the following configuration options:

* `blitzmax-mode-indent` - The number of spaces to indent by. By default
  **blitzmax-mode** indents by 4 spaces which is converted to a single tab.

* `blitzmax-mode-fontify-p` - Disable syntax highlighting by setting this to
  `nil`. `t` by default.

* `blitzmax-mode-smart-indent-p` - Disable smart indentation by setting this to
  `nil`. `t` by default.

* `blitzmax-mode-compiler-pathname` - Full pathname to the BlitzMax compiler
  `bmk**. Empty by default.


## Current Features

**blitzmax-mode** comes with the following features:

* Basic syntax highlighting -- highlights standard BlitzMax functions, built-in
  types (such as `String` and `Int`) and built-in constants (`True`, `False` and
  `Null`).
* Automatic indentation -- new lines are automatically indented (using spaces
  *or* tabs) to the correct level.


## Planned Features

These features are currently WIP:

* Compile current buffer
* Auto-completion
* Integration with bmk
* Integration with blam
