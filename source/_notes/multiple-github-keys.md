---
title: Using multiple SSH keys with GitHub
date: 2017-12-20
---

I have a couple of different accounts for GitHub[^1] - one for my personal
projects, and one for work. GitHub doesn't allow the same SSH key to be used on
different accounts which can make working with repositories difficult.

For example, cloning a private repository from one account may not work, even if
both keys are currently being used by the SSH agent.

To workaround this limitation, the SSH agent can be configured to use a specific
key when accessing a domain. In this case the same domain requires different
keys, so an alias is used instead.

This alias needs to be used when checking out repositories, but once the initial
step is complete everything else happens automatically.

Modifying `~/.ssh/config` with the following:

```
# Work GitHub Account
Host github.com-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/work_public_key
```

Will now tell the SSH agent to use `~/.ssh/work_public_key` when trying to
access anything on `github.com-work`.

## Cloning a repository

To use the alias when cloning a reposiory, replace `github.com` with the
configured alias.

For example, cloning the `ruby` repository with the work alias from earlier
looks like this:

```
git clone git@github.com-work:ruby/ruby.git
```

Standard git commands like `git push` will work just the same as any other
repository.

## Existing repositories

To update an existing repository to use a new alias, modify the `.git/config`
file in the project's working directory. It should look something like this:

```
[remote "origin"]
	url = git@github.com-work:ruby/ruby.git

```


[^1]: This solution also works with BitBucket.
