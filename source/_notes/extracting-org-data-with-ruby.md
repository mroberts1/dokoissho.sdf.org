---
title: Extracting org-mode data with Ruby
date: 2017-01-11
---

[**org-ruby**](https://github.com/bdewey/org-ruby) is a Ruby gem that can be
used to parse `org-mode` files. It's not as robust as using Emacs itself, but
sometimes a quick script is all that's needed to extract a couple of bits of
data

The following code will read an `org-mode` file and list all major headlines:

```ruby
require 'org-ruby'
document = Orgmode::Parser.new(File.read('TODO.org'))

document.headlines.each do |headline|
  puts headline.headline_text
end
```

Here's a more advanced example. This will read all headlines that are marked as
"DONE" along with any list items they contain.

```ruby
require 'org-ruby'
document = Orgmode::Parser.new(File.read('TODO.org'))

doc.headlines.each do |headline|
  next unless headline.keyword == 'DONE'

  puts headline.headline_text

  headline.body_lines.each do |line|
    next if line.nil?
    next unless line.paragraph_type == :list_item

    task_line = line.output_text.strip
    puts ' -> ' + task_line[4..-1]
  end
end
```

Using this file:

```
#+TITLE: TODO.org
DONE Top Level Task 1
  - [X] Checkbox one
  - [X] Checkbox two
TODO Top Level Task 2
  - [ ] Checkbox three
```

will output:

```
Top Level Task 1
 -> Checkbox one
 -> Checkbox two
```

-----

The [Mini Shinobi development page](https://www.sodaware.net/1gam-2017/01-mini-shinobi/)
is a good example of what this can be used to create. The "daily activity" and
"milestones" sections are both built entirely using org data.
