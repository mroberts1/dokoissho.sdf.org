# sodaware.sdf.org

This repository contains the content and configuration required to build
[sodaware.sdf.org](http://sodaware.sdf.org/).

I use a modified version of [rouge](https://github.com/rouge-ruby/rouge) for
this site so that I can highlight BlitzMax code. It's not included in this
repository, so you'll need to modify the `Gemfile` as follows:

Replace this line:

```ruby
gem 'rouge', path: 'vendor/rouge'
```

with 

```ruby
gem 'rouge'
```

and run `bundle` to update the dependencies.
