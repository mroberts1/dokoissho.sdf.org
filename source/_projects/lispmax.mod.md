---
title:    lispmax.mod
github:   sodaware/lispmax.mod
homepage: https://www.sodaware.net/lispmax.mod/
description: >
  A lisp-y script language for BlitzMax
---


`lispmax` is a module for BlitzMax that can parse and execute a lispy scripting
language.


## A quick example

The following lisp expression adds two numbers together:

```scheme
(+ 10 20)
```

To run this within BlitzMax using lispmax, we need to do the following:

1. Create and initialize a LispMax object - this contains the environment
   (functions, variables etc)
2. Parse the expression - this converts a string containing lisp code into
   something LispMax can use
3. Evaluate the expression - this is where the magic happens

In practice, it looks a little like this:

```blitzmax
Framework brl.basic
Import sodaware.lispmax

' Create a new LispMax instance.
Local lisp:LispMax = New LispMax

' Load built-in and library functions.
lisp.initializeEnvironment()

' Parse and evaluate the expression.
Local expression:LispMax_Atom = lisp.parseExpression("(+ 10 20)")
Local result:LispMax_Atom     = lisp.evaluateExpression(expression)

' Print the result.
lisp.printExpression(result)
```

Running the above example will print `30`.

-> Read more on the [lispmax.mod project homepage](https://www.sodaware.net/lispmax/).
