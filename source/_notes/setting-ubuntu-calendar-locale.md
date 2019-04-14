---
title: Setting Xubuntu calendar week to start on Mondays
date: 2019-04-13
---

I use the [xfce](https://xfce.org/) for my desktop environment. Recently I've
been trying to fix all of the little things that bug me but aren't really
important. I wanted the xfce calendar to start weeks on Monday rather than
Sunday.

Adding the following to `/etc/default/locale` did the trick:

```
LC_TIME="en_GB.UTF-8"
```
