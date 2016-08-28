---
title: Adding CSS classes to images in Jekyll
date: 2016-08-28
---

Sometimes an image in a Jekyll post needs a little extra styling.

The following markup will add a CSS class to the generated image.

```markdown
![Alt Text](http://example.org/image.jpg){:class="image-class"}
```

Will produce this:

```html
<img src="http://example.org/image.jpg" alt="Alt Text" class="image-class" />
```

There should no space around the `=` sign.

---

This technique can also be used to add multiple HTML attributes. Adding them all
in a single pair of `{}` does not work; each attribute needs to be in its own
set.

```markdown
![Alt Text](/whatever){:class="something-else"}{:style="border: 2px solid red;"}
```

It also works on links:

```markdown
[Link Example](http://example.org/){:class="big-link"}
```
