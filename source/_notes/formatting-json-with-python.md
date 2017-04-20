---
title: Formatting JSON from the command line with Python
date: 2017-04-19
---

This is a really quick way to format JSON nicely. Calling `python -m json.tool`
with a filename argument will fix any indentation issues in the file and output
the result.

For example, a file called *my_file.json* with the following contents:

```json
{ "some_field" :
"value"
}
```

When called like this:

```bash
python -m json.tool my_file.json
```

Will output:

```json
{
    "some_field": "value"
}
```
