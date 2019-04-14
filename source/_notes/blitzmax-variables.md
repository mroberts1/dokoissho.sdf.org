---
title: BlitzMax variables are case-insensitive
date: 2018-09-15
---

Even though I've used BlitzMax for years, I only just realized that it doesn't
care about case when it comes to variables. I knew that local and global
variables didn't matter, but constant names are also case-insensitive.

For example, the following will output "ONE":

```blitzmax
Const my_constant:Int = 1

If MY_CONSTANT = 1 Then Print "ONE"
```

The same result occurs even in `SuperStrict` mode.
