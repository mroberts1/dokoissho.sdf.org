---
title: Excluding a list of words from a grep search
date:  2021-02-27
---

`grep` can search for lines that **don't** include word with the `-v`
flag. We can use `-e` to search for multiple words, but this can be a pain when
there's a lot to search for.

The `-f` flag allows us to specify a file that contains a list of words/phrases
to search for (one on each line) which makes it much easier to read.

For example:

```bash
grep -v -e "phrase one" -e "phrase two" -e "phrase three" <filename>
```

Can be rewritten as follows:

```bash
grep -v -f words.txt <filename>
```

where `words.txt` looks like:

```
phrase one
phrase two
phrase three
```

Removing the `-v` flag would search for only the words in the file.
