---
title: Installing Roswell on CentOS
date: 2016-09-27
---

[Roswell](https://github.com/roswell/roswell) is a command line tool used to
install and manage Common Lisp implementations. It's similar to Ruby's
[rvm](https://rvm.io/) and Python's [pyenv](https://github.com/yyuu/pyenv).

There are some binaries available, but none for CentOS. The following will get
Roswell up and running on a fresh CentOS 7.2 installation:


## Setting up CentOS

Run the following as `root` to install dependencies required for building
Roswell:

```bash
yum install git automake gcc gcc-c++ make openssl-devel curl-devel bzip2
```

## Fetching and installing Roswell

These can be run as any user:

```bash
git clone -b release https://github.com/roswell/roswell.git
cd roswell
sh bootstrap
./configure
make
```

And as `root`

```bash
make install
```

And finally (as the original user)...

```bash
ros setup
```

Roswell will now be installed and available globally.


## Installing and running a Lisp

To install a Lisp binary, such as SBCL, run:

```
ros install sbcl-bin
```

SBCL can then be started using `ros run`.
