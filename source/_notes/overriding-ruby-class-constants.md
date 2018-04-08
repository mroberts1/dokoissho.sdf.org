---
title: Overriding Ruby class constants
date: 2018-04-08
---

I'll preface this note with the disclaimer that you probably shouldn't do
this.

I use org-mode to track time worked on projects, and I've been using
[org-ruby](https://github.com/bdewey/org-ruby) to extract the data to make
graphs and things.

One issue I've bumped into is that org-ruby hard-codes the list of keywords that
can start a headline and only supports `TODO` and `DONE`. This meant some
headlines got ignored and didn't show up in reports.

To get around this I needed to override the constants org-ruby uses. In the end I
went with the following approach:

```ruby
##
# Monkey patch
module Orgmode
  class Headline
    remove_const(:Keywords) if defined?(Keywords)
    remove_const(:KeywordsRegexp) if defined?(KeywordsRegexp)

    Keywords       = %w[TODO IN-PROGRESS TESTING DONE CANCELLED].freeze
    KeywordsRegexp = Regexp.new("^(#{Keywords.join('|')})\$")
  end
end
```

