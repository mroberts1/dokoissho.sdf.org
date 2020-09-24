---
title:  Quickly loading text files in BlitzMax
layout: post
---

A few days ago I was trying to track down a performance issue in a project that
loads and parses JSON. I wrote a couple of benchmarks in different languages to
see if it was a language issue, a library issue, or something else entirely.

One thing that stood out was my BlitzMax test was parsing quickly, but it took
an age to load the initial data.

Naturally I had to drop everything to try and figure out what was happening.

## The problem

The file to be loaded was around 900KB, and the following function was used to
load it into memory:

```blitzmax
Function LoadFileAsString:String(url:Object)
    Local streamIn:TStream = ReadFile(url)
    Local contents:String  = ""

    While Not(file.Eof())
        contents:+ file.ReadLine() + "~n"
    Wend

    Return contents
End Function
```

Reading the file byte-by-byte (using `ReadByte`) is far slower than using
`ReadLine`. This approach works well enough on small files (< 20kB), but gets
very slow as they get larger.


## The solution

I figured loading everything into a bank and converting that to a string would
be quicker. After all, a string is just a collection of bytes with a null
terminator, and a BlitzMax bank is a collection of bytes.

The first approach was to read the bank using `LoadBank` and then building a
string using `PeekByte` for each character.

The results were disappointing.

After reading the documentation, I found a few functions that looked to do
exactly what I needed.

The built-in `String` type comes with `FromCString`, a function that can convert
a C-style string into a BlitzMax one. C-style strings are passed around in
BlitzMax as a `Byte Ptr` type.

Even better, BlitzMax banks can use `LockBank` to return a pointer to their
contents as a `Byte Ptr`.

The new code looked something like this:

```blitzmax
Function LoadFileAsString:String(url:Object)

    ' Create a bank and load the file contents.
    Local bank:TBank = LoadBank(url)

    ' Ensure bank finishes with a 0 byte.
    ' This prevents the string from having junk bytes at the end.
    Local size:Int = BankSize(bank)
    ResizeBank(bank, size + 1)
    PokeByte(bank, size, 0)

    ' Get bank contents and convert to a string
    Local buffer:Byte Ptr = LockBank(bank)
    Local content:String  = String.FromCString(buffer)

    ' Cleanup.
    UnlockBank(bank)
    bank = null

    Return content

End Function
```

One important addition is adding a null terminator to the end of the loaded
content. Because `FromCString` expects a null byte terminator, it will continue
to read from memory until it finds one. This can lead to junk data at the end of
the string.


## Performance

The following benchmark is for a 900KB text file.

{:class="table--striped table--fancy table--function-map"}
Method              | Average Time (ms)
--------------------|------------------
Method 1 (ReadLine) | 933.18
Method 2 (LoadBank) | 2.8

Sometimes [yak shaving](http://catb.org/jargon/html/Y/yak-shaving.html) comes in
handy.
