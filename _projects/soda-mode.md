---
title: soda-mode
github: sodaware/soda-mode
description:
  An Emacs major mode for editing `.soda` files
---

This is my first attempt at writing a major mode for Emacs. I'm pretty sure I'm
the only person that will ever use it, but it may be useful when learning how to
build major modes.

Here's an example `soda` file, as used in [Shining Online](http://www.shiningonline.org/):

```
[t:template,n:equipment_silver_ring] {
    doc               = "Silver Ring";
    specializes       = base_equipment_ring;

    equipment:defence = 2;
    equipment:luck    = 1;

    [item] {
        display_name  = "Silver Ring";
        icon          = "demo5.icons.equipment.silver_ring";
        description   = "A silver ring";
        base_price    = 3000;
    }
}
```

It's sort of a cross between an ini file and json. But not as good as either.
