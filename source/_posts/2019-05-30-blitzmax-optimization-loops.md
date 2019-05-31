---
title: BlitzMax optimization - Loops
layout: post
categories:
  - blitzmax
---

BlitzMax supports the following types of loop:

  - `For...Next`
  - `While...Wend`
  - `Repeat...Until`

## Summary

The different types of loops are almost identical in performance.

`Repeat...Until` loops are slightly faster, but it's unlikely to be a huge
benefit to rewrite everything. It's far more effective to optimize whatever is
being called inside the loop.

One slight performance boost was to use a `<>` check when using while loops,
rather than a `<` check. For example:

```blitzmax
While x < 10
    ' Code here
Wend

While x <> 10
    ' Code here
Wend
```

The second loop will be slightly faster.


## Loop calculations

One important difference between the three types of loop is how limits are
checked when using a function. 

For example:

```blitzmax
' Will print "Called" once.
Print "For...Next"
For Local i:Int = 0 to getNumber()
Next

' Will print "Called" 5 times.
Print "While...Wend"
Local w:Int = 0
While w < getNumber()
    w :+ 1
Wend

Function getNumber:Int()
    Print "Called"
    
    Return 5
End Function
```

The `For...Next` loop will only execute `getNumber` once. However, the
`While...Wend` loop will call it every loop iteration. The number should be
stored in a variable unless it must be recalculated every loop.


## Loop benchmarks

All benchmarks are in release mode with threading enabled. 1,000,000,000
iterations.

{:class="table--striped table--fancy table--benchmark"}
Check Type               | Execution Time (milliseconds)
-------------------------|------------------------------
For...Next               | 3043
While...Wend             | 3034
While...Wend (Not Equal) | 2766
Repeat...Until           | 2730


## Test code

```blitzmax
SuperStrict

Framework brl.basic

Const ITERATIONS:Int = 1000000000

Local startTime:Int

' For/Next
startTime = millisecs()
For local i:int = 0 to ITERATIONS
	DoSomething(i)
Next
print "For/Next: " + (millisecs() - startTime) 


' While/Wend
startTime = millisecs()
Local whilePos:int = 0
While whilePos < ITERATIONS
	DoSomething(whilePos)
	whilePos:+ 1
Wend
print "While/Wend: " + (millisecs() - startTime) 


' While/Wend (Not Equal check)
startTime = millisecs()
whilePos = 0
While whilePos <> ITERATIONS
	DoSomething(whilePos)
	whilePos:+ 1
Wend
print "While/Wend (NE): " + (millisecs() - startTime) 


' Repeat/Until
startTime = millisecs()
Local repeatPos:int = 0
Repeat
	DoSomething(repeatPos)
	repeatPos:+ 1
Until repeatPos = ITERATIONS
print "Repeat/Until: " + (millisecs() - startTime)

Function DoSomething(arg1:Int)
End Function
```
