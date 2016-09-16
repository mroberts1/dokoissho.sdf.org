---
title: Sonic's Adventure
github: sodaware/sonics-adventure
description:
  Source code for the first game I ever developed - Sonic's Adventure
---

This is the first game I ever wrote by myself. It's a text adventure starring
Sonic the Hedgehog.

It was written in Power Basic for the Atari ST. The source code is extremely
scrappy and has some wonderfully useless comments and variable names.

For example, the code to handle the "TALK" command looks like this:

```visualbasic
'IT'S GOOD TO TALK!
6000 FOR T=1 TO 6
6010 IF BLOKEPOS(T)=H THEN GOTO 6040
6020 NEXT T
6030 PRINT "THERE'S NO-ONE TO TALK TO!":GOTO 2100
6040 PRINT BLOKE$(T);" SAYS"
6045 ? CHR$(34);SPEECH$(T);CHR$(34)
6430 GOTO 2100
```

Oh dear...
