---
title: Showing a list of git branches with their last commit date
date: 2017-05-24
---

Over time a git repository can end up with a lot of feature branches. Most of
these are not much use once they've been merged into the main branch.

The following command shows a list of all local branch names, along with the date of
their last commit:

```bash
git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'
```

Produces output like:

```
2015-10-12 feature-branch-name
2016-01-15 another-feature-branch
2016-03-16 one-last-feature-branch
2017-05-24 master
```
