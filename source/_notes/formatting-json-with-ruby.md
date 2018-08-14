---
title: Formatting JSON with Ruby
date: 2018-08-14
---

Sometimes the JSON that's received from a web service is hard to read. Ruby's
JSON module comes with a function to help:

```ruby
require 'json'

json = JSON.parse(raw_text)
puts JSON.pretty_generate(json)
```

The `pretty_generate` function will add line breaks where needed and fix any
alignment issues.

Adding in syntax highlighting using [rouge](https://github.com/jneen/rouge)
requires only a few more steps:

```
require 'json''
require 'rouge'

def prettify_json(raw_text)
  json = JSON.parse(raw_text)
  JSON.pretty_generate(json)
end

def highlight_json(text)
  formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
  lexer = Rouge::Lexer.find('json')
  formatter.format(lexer.lex(text))
end
```

Calling `highlight_json` will return HTML markup to display json with syntax
highlighting.
