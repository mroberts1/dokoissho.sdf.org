---
title: Adding a trailing slash to all urls in Rails
date: 2017-04-13
---

Add the following to the `Application` class in `config/application.rb`:

```ruby
default_url_options[:trailing_slash] = true
```

For example, the application `MyApplicationName` will look something like this:

```ruby
module MyApplicationName
  class Application < Rails::Application
    default_url_options[:trailing_slash] = true
  end
end
```

The Rails server will need restarting for the new settings to take effect.

This solution works for Rails 5 and will add a trailing slash to all urls
automatically.
