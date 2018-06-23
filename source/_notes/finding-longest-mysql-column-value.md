---
title: Finding the longest value of a MySQL column
date: 2018-06-23
---

This came up during the rebuild of a very old legacy application. The previous
app used `varchar(255)` for most columns, but this seemed a bit wasteful.

To get a better idea of how large things needed to be in the new design, I
wanted to know the the longest value stored for each column.

Thankfully MySQL has the `length` function that can be used for this. The
following query qill return a single result containing the longest value, as
well as its length:

```sql
SELECT <column>, LENGTH(<column>) as col_length 
FROM <table> 
ORDER BY col_length DESC
LIMIT 1
```

Just replace `<column>` and `<table>` with the column and table name to query.
