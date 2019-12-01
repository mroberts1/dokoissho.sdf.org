---
title: BMK compiler flags
date:  2019-12-01
---

The BlitzMax compiler (`bmk`) supports a number of compilation options, but
it just outputs "Command line error" instead of a help message.

A compilation command is make up of three parts:
  - The action to take
  - Optional flags
  - The file or module to compile
  
Allowed actions are:
  - `makeapp` : Create an application (e.g. an `exe` file on Windows)
  - `makemods` : Compile a BlitzMax module

The following flags are supported:

- `-h` : Compile in threaded mode.
- `-d` : Compile in debug mode.
- `-r` : Compile in release mode.
- `-a` : Rebuild all files during compilation.
- `-t gui` : Compile in GUI mode. Applications compiled with this argument will
  not display a console window when run.
- `-o <file>` : Write the compiled application to `<file>`

The final argument should be the file or module to compile.

## Examples:

### 1. Compile a module in release mode

```bash
bmk makemods -r my_module
```

### 2. Compile a threaded, non-console application

```bash
bmk makeapp -h -t gui -o output.exe src/my_file.bmx
```
