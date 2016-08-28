---
title: hagfish
github: sodaware/hagfish
description:
  An ugly PHP framework
---

Every developer should build a terrible web framework at some point. This one is
mine.

```php
<?php
require_once 'hagfish/hagfish_core.php';

// Create a controller
$app = new HagfishController();

// Add an action
$app->addAction('default', function() {
    return "hello world";
});

// Dispatch
$app->dispatch();
```

It's not going to win any awards (and doesn't deserve to), but it's lightweight
and is what I used to build [Craft Roulette](http://www.craftroulette.com/).
