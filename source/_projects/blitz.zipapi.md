---
title: blitz.zipapi
github: sodaware/blitz.zipapi
documentation: blitz.zipapi
description:
  Zip functionality to BlitzPlus & Blitz3D. Extract files, create archives and compress banks. http
---

One of the first libraries I wrote for BlitzPlus. It has functionality for
extracting files, as well as packing and unpacking banks.

Here's some example code:

```
Const TEST_STRING$ = "Repetition is good for compression."

; Create a bank to be compressed
Local testBank = CreateBank((Len(TEST_STRING) * 2) + 1)

; Store our test string
PokeString(testBank, 0, TEST_STRING + TEST_STRING)

; Compress the data
Local compressedBank = ZipApi_Compress(testBank)

; Output statistics
Print "Old Size: " + BankSize(testBank)
Print "New Size: " + BankSize(compressedBank)
```

I don't use BlitzPlus now, but I enjoyed building it.
