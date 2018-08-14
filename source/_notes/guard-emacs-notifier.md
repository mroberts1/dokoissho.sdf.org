---
title: Using the Emacs notifier with Guard
date: 2018-08-02
---

[Guard](https://guardgem.org/) is one of my favourite Ruby tools, especially
when working on Rails projects.

One of the most helpful features of Guard is the display of notifications to
indicate a test's success (or failure). There are a few different types
available, but I find the popup ones to be a little annoying after a
while.

However, Guard comes with an Emacs notifier that changes the colour of the
modeline depending on the result of the latest test. This makes getting feedback
from tests extremely quick, and also means I don't have to leave the editor.

Adding the following to `.guard.rb` in your home directory will enable the Emacs
notifier on the local machine.

```ruby
notification :emacs
```

The default colours didn't work so well for my current theme
([aurora](https://emacsthemes.com/themes/aurora-theme.html)), but thankfully
Guard supports configuring colours:

```ruby
notification :emacs,
  fontcolor: '#263238',
  default:   '#546d7a',
  success:   '#396c00',
  failed:    '#640900',
  pending:   '#776600'
```

Alternatively these can go in a `Guardfile`, but I prefer to leave notification
settings up to individuals.
