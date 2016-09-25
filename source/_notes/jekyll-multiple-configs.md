---
title: Using multiple configuration files with Jekyll
date: 2016-09-25
---

When building this site I wanted to use `jekyll-minifier` to keep the page size
small. However, it increases the build time significantly which is a pain during
development.

Thankfully Jekyll can accept multiple configuration files at a time.

The following command will start a Jekyll server with the standard `_config.yml`
configuration as well as `_config.development.yml`.

```bash
bundle exec jekyll serve --drafts --watch --config=_config.yml,_config.development.yml
```

Anything in the *development* configuration will override the base values in
`_config.yml`.


## Examples

The production & development configurations for this site look like this:

**_config.production.yml**
```yml
gems:
  - jekyll-minifier
```

**_config.development.yml**
```yml
livereload: true
gems:
  - jekyll-livereload
```

Cutting `jekyll-minifier` from development cuts page generation times from 10
seconds to about 0.8. Coupled with `jekyll-livereload` it makes previewing site
changes much easier.


## Updated Makefile

This changes the build and serve parts of the Makefile[^1] to look like this:

```make
build:
	bundle exec jekyll build --config=_config.yml,_config.production.yml

serve:
	bundle exec jekyll serve --drafts --watch --config=_config.yml,_config.development.yml
```

[^1]: See [/notes/jekyll-makefile/](A simple Jekyll deployment Makefile)
