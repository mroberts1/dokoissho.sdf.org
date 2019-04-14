---
title: Counting words with wc
date: 2019-03-20
---

Linux systems come with `wc`, a useful command for counting words that gives
output something like this:

```
 39 141 853 sorting-directories-by-size.md
```

This gives 3 values: The number of lines, the number of words and the number of
bytes. `wc` also supports flags for getting just one of these values.

For example:

```bash
$ wc -w my-file.md
123 my-file.md
```

However, that still includes the filename. To get **just** the word count (or
byte count/line count) without parsing the file takes an extra step:

```bash
cat my-file.md | wc -w
```

Which will echo the number of words without any extra data. 

I've used this to keep track of a text file's wordcount over time with the
following snippet:

```bash
echo "$(date '+%Y-%m-%d %H:%M:%S'),file.org,$(cat file.org | wc -w)" >> wordcount.csv
```

This appends a line to "wordcount.csv" containing the current time and date, the
file name and the number of words.
