---
title: Aligning PHP arrays with Emacs
date: 2018-01-16
---

PHP doesn't require arrays to be aligned in a specific way, but certain coding
standards will raise a warning if they're aren't aligned correctly. Doing this
by hand can be a pain.

[emacs-php-align](https://github.com/tetsujin/emacs-php-align) is a small
extension that can automatically align arrays. It's not available on Melpa, but
it's fairly quick to setup.

Once it's installed, calling `M-x align-current` will align an array and turn this:

```php
$my_array = array(
    'key' => 'Value',
    'key_two => 'Another value',
    'really_long_key' => 'Value',
    'k' => 'Value',
);
```

into this:

```php
$my_array = array(
    'key'             => 'Value',
    'key_two          => 'Another value',
    'really_long_key' => 'Value',
    'k'               => 'Value',
);
```
