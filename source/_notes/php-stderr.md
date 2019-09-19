---
title: Writing to STDERR with PHP
date:  2019-09-18 18:10
---

The following function will write `$text` to STDERR instead of STDOUT like
`print` and `echo`.

```php
function print_error($text) {
    fwrite(STDERR, $text . PHP_EOL);
}
```

It's handy for scripts that output things to STDOUT that may be redirected or
saved to a file (e.g. a script that outputs CSV or JSON data).
