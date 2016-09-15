---
title: vault
github: sodaware/vault
description:
  A tiny caching library for PHP.
---

[Craft Roulette](http://www.craftroulette.com/) needed some simple data caching
and this is what I came up with. It's not great, but it does the trick.

It lives in a single file and is targeted towards quick and simple apps that
just need a little caching. There are much, much better PHP caching libraries
out there (like [Stash](http://www.stashphp.com/) or
[Cache](https://github.com/desarrolla2/Cache)) for heavy duty caching
requirements.


## Example usage

```php
<?php
require_once 'vault.php';

// Setup vault with APC as the storage engine.
Vault::setup( 'APC' );

// Store something with a default lifespan (3600 seconds).
Vault::store( 'my_key', 'hello, world' );

// Fetch it.
echo Vault::fetch( 'my_key' );

// Clear the cache.
Vault::clear();

```

Items stored with Vault will expire after 1 hour, but this can be altered when
storing items in the cache.

## Example usage with expiration times

```php
<?php

// Store something for a couple of seconds.
Vault::store( 'short_lived_key', 'I will be gone soon', 3 );

// Show it exists.
echo Vault::fetch( 'short_lived_key' );
# => "I will be gone soon"

// Wait until this item has expired.
sleep( 4 );

echo Vault::fetch( 'short_lived_key' );
# => null
```
