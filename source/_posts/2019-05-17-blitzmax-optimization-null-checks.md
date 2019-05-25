---
title: BlitzMax optimization - Null checks
layout: post
categories:
  - blitzmax
---

BlitzMax has a couple of ways to check if a variable is `Null`:

* Null - `If o = Null`
* Null (Yoda) - `If Null = o`
* Not - `If Not o`
* Not (brackets) - `If Not(o)`
* Not (explicit) - `If Not(o) = True`
* No check - `If o`


## Summary

There's not a huge amount of performance difference between most checks. Calling
`Not` adds a very small amount of overhead, and explicit `Not` checks are about
2x slower than everything else.

It's probably not worth rebuilding code unless it's being run millions of times.


## Null check benchmarks

All benchmarks are in release mode with threading enabled. 1,000,000,000
iterations.

{:class="table--striped table--fancy table--benchmark"}
Check Type          | Execution Time (milliseconds)
--------------------|------------------------------
Null                | 754
Null (Yoda)         | 754
Not                 | 889
Not (brackets)      | 885
Not (explicit)      | 2082
No check            | 752


## Test code

```blitzmax
SuperStrict
Framework brl.basic

Const ITERATIONS:Int = 1000000000

Local startTime:Int
Local counter:int

Local result:int
Local o:Object

result = false
startTime = millisecs()
For local i:int = 1 to ITERATIONS
    if o = Null then result = true
Next
print "Null: " + (millisecs() - startTime) 

result = false
startTime = millisecs()
For local i:int = 1 to ITERATIONS
    if Null = 0 then result = true
Next
print "Null (Yoda): " + (millisecs() - startTime) 

result = false
startTime = millisecs()
For local i:int = 1 to ITERATIONS
    if not o then result = true
Next
print "Not: " + (millisecs() - startTime) 

result = false
startTime = millisecs()
For local i:int = 1 to ITERATIONS
    if not(o) then result = true
Next
print "Not (brackets): " + (millisecs() - startTime) 

result = false
startTime = millisecs()
For local i:int = 1 to ITERATIONS
    if not(o) = true then result = true
Next
print "Not (explicit): " + (millisecs() - startTime) 

' Opposite of a Null check

o = "d"

result = false
startTime = millisecs()
For local i:int = 1 to ITERATIONS
    If o Then result = true
Next
Print "No check: " + (millisecs() - startTime) 

result = false
startTime = millisecs()
For local i:int = 1 to ITERATIONS
    if (Null = o) = false then result = true
Next
Print "No check (double check): " + (millisecs() - startTime) 
```
