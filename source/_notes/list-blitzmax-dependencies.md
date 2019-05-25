---
title: Listing BlitzMax module dependencies
date: 2019-05-19
---

The following snippet will list all modules that a source file (or files) depend
on. Replace `<SOURCE FILE>` with a file name or directory to search:

```bash
grep --include="*.bmx" -hri "^import [^\"]" <SOURCE FILE> |
    sort |
    uniq |
    sed 's/[Ii]mport //g'
```

This will give output something like the following:

```
brl.linkedlist
brl.map
brl.reflection
brl.retro
sodaware.blitzmax_array
sodaware.blitzmax_ascii
sodaware.file_fnmatch
```

The snippet is broken into a couple of parts:

  - `grep --include="*.bmx" -hri "^import [^\"]" <SOURCE FILE>`
    - `--include="*.bmx*"` Instructs grep to search only `bmx` files.
    - `-h` Removes the file name from results
    - `-r` is a recursive search
    - `-i` ignores case
    - `"^import [^\"]"` will search for lines that start with "import" that are
      not followed by a `"` character (i.e. a file import).
  - `sort` - Sorts lines A to Z
  - `uniq` - Removes duplicate lines from the results
  - `sed 's/[Ii]mport//g'` strips the starting `Import `.
