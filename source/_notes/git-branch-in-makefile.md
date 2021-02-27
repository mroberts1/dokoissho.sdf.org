---
title: Getting the current git branch name in a Makefile
date:  2021-02-26
---

I wanted to automate a build step that used the current git branch name. Here's
how to get it from within a `Makefile`:

```makefile
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
```

`BRANCH` will then contain the branch name and can be used like a normal
`Makefile` variable.
