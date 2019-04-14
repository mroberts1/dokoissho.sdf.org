---
title: Sorting top-level directory names by size
date: 2019-03-17
---

This is a quick one-liner for sorting a list of directories by size, largest
first:

```bash
du --max-depth=1 . | sort -nr
```

Which will return a list something like this:

```
8204	./.cache
1829	./.git
1416	./_site
785	./source
384	./.sass-cache
8	./plugins
4	./raw
0	./images
```

There are two parts to the command:

#### du --max-depth=1 .

`du` displays a list of directory sizes. The `--max-depth=1` parameter limits
the list to top-level directories. Their size will still include files in their
sub-directories, but these sub-directories will not be included in the results
list.

#### sort -nr

Sorts the results. The `n` parameter sorts by numerical data (in this case size
rather than the name) and `r` reverses the list so newer smallest items show at
the bottom.
