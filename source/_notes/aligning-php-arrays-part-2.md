---
title: Aligning PHP arrays with Emacs (Part 2)
date: 2019-03-12
---

In the past I've used [emacs-php-align](/notes/aligning-php-arrays-with-emacs/)
to align PHP arrays. However, there's a more flexible alternative built into
Emacs - `align-regexp`.

Here's the original example I used.

```php
$my_array = array(
    'key' => 'Value',
    'key_two' => 'Another value',
    'really_long_key' => 'Value',
    'k' => 'Value',
);
```

To align this with `align-regexp`, highlight the contents of the array and then:

1. Run the `align-regexp` command (i.e. `M-x align-regexp`)
2. Enter `=>` at the "Align regexp" prompt

Which converts it into this:

```php
$my_array = array(
    'key'             => 'Value',
    'key_two'         => 'Another value',
    'really_long_key' => 'Value',
    'k'               => 'Value',
);
```

As the name suggests, `align-regexp` takes a regular expression for
alignment. This means it can also be used to align pretty much anything.

e.g.

```json
{
    "key" : "Value",
    "key_two" : "Another value",
    "really_long_key" : 200,
    "k" : "Value",
}
```

With `align-regexp` using `:` becomes:

```json
{
    "key"             : "Value",
    "key_two"         : "Another value",
    "really_long_key" : 200,
    "k"               : "Value",
}
```
