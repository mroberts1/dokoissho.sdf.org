---
title: vault
github: sodaware/vault
description:
  A tiny caching library for PHP
---

[Craft Roulette](http://www.craftroulette.com/) needed some simple data caching
and this is what I came up with. It's not great, but it does the trick.


```php
<?php
require_once 'vault.php';

// Setup vault with APC
Vault::setup('APC');

// Store something
Vault::store('my_key', 'hello, world');

// Output it
echo Vault::fetch('my_key');

// Clear the cache
Vault::clear();
```
