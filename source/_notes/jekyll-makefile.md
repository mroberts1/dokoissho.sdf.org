---
title: A simple Jekyll deployment Makefile
date: 2016-08-30
---

The following *Makefile* can be used to build, serve and deploy a Jekyll site.

```make
REMOTE ?= "<connection info here>"
build:
	bundle exec jekyll build

push:
	rsync -avrz --delete-excluded _site/* $(REMOTE)

deploy: build push

serve:
	bundle exec jekyll serve --drafts --watch
```

`REMOTE` should be something like this `username@server:path`, where:

  - `username` is your username on the remote server
  - `server` is the remote server to deploy to
  - `path` is the remote directory files should be copied to

If *rsync* is unavailable on the remote machine, *scp* can also be used by
changing `push` to the following:

```make
push:
	scp -r _site/* $(REMOTE)
```

Running `make deploy` will build the site and upload it in one command.
