---
title: Converting values to booleans in PHP
date:  2018-09-07
---

PHP doesn't have a specific function for converting data to booleans, but it
does have `filter_var` which can be used to do the same thing.

```php
filter_var($value, FILTER_VALIDATE_BOOLEAN);
```

Passing a value to `filter_var` with the `FILTER_VALIDATE_BOOLEAN` flag will
return true for the following values:

* `true`
* `'true'`
* `1`
* `'1'`
* `'on'`
* `'yes'`

Anything else will return `false`.
