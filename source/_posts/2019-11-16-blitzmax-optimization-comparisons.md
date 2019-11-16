---
title: BlitzMax optimization - Variable comparisons
layout: post
categories:
  - blitzmax
---

BlitzMax comes with several built-in data types:

- `Double`
- `Long`
- `Int`
- `Short`
- `Byte`
- `Float`
- `String`
- `Object`

How fast are comparisons for different types? Is using a `String` for a variable
much faster or slower than an `Int`?


## Summary

Smaller data types such as `Byte` and `Short` are roughly twice as fast to
directly compare than `Double` and `Long`. 

`String` is the slowest comparison, but string length does not affect how long
it takes to compare.


## Equality benchmarks

All benchmarks are in release mode with threading enabled. 1,000,000,000
iterations.

{:class="table--striped table--fancy table--benchmark"}
Check Type  | Execution Time (milliseconds)
------------|------------------------------
Double      | 2462
Long        | 2771
Integer     | 1565
Short       | 1253
Byte        | 1247
Float       | 2493
String      | 4099
Long string | 4102
Object      | 1549


## Test code

```blitzmax
SuperStrict
Framework brl.basic

SeedRnd(MilliSecs())

Const ITERATIONS:Int = 1000000000

Local startTime:Int
Local result:Byte

' ----------------------------------------
' -- Equality Checks

Local dval1:Double = Rand(0, 100), dval2:Double = Rand(0, 100)

startTime = millisecs()
For local i:Int = 1 to ITERATIONS
    result = (dval1 = dval2)
Next
print "Double check: " + (millisecs() - startTime) 

' ----------

Local lval1:Long = Rand(0, 100), lval2:Long = Rand(0, 100)

startTime = millisecs()
For local i:Int = 1 to ITERATIONS
    result = (lval1 = lval2)
Next
print "Long check: " + (millisecs() - startTime) 

' ----------

Local ival1:Int = Rand(0, 100), ival2:Int = Rand(0, 100)

startTime = millisecs()
For local i:int = 1 to ITERATIONS
    result = (ival1 = ival2)
Next
print "Integer check: " + (millisecs() - startTime) 

' ----------

Local sval1:Short = Rand(0, 100), sval2:Short = Rand(0, 100)

startTime = millisecs()
For local i:Int = 1 to ITERATIONS
    result = (sval1 = sval2)
Next
print "Short check: " + (millisecs() - startTime) 

' ----------

Local bval1:Byte = Rand(0, 100), bval2:Byte = Rand(0, 100)

startTime = millisecs()
For local i:Int = 1 to ITERATIONS
    result = (bval1 = bval2)
Next
print "Byte check: " + (millisecs() - startTime) 

' ----------

Local fval1:Float = Rand(0, 100), fval2:Float = Rand(0, 100)

startTime = millisecs()
For local i:Int = 1 to ITERATIONS
    result = (fval1 = fval2)
Next
print "Float check: " + (millisecs() - startTime) 

' ----------

Local stval1:String = Rand(0, 100), stval2:String = Rand(0, 100)

startTime = millisecs()
For local i:Int = 1 to ITERATIONS
    result = (stval1 = stval2)
Next
print "String check: " + (millisecs() - startTime) 

' ----------

Local lstval1:String = MakeRandomLlongString()
Local lstval2:String = MakeRandomLlongString()

startTime = millisecs()
For local i:Int = 1 to ITERATIONS
    result = (lstval1 = lstval2)
Next
print "Long string check: " + (millisecs() - startTime) 

' ----------

Local obval1:Object = String(Rand(0, 100)), obval2:Object = String(Rand(0, 100))

startTime = millisecs()
For local i:Int = 1 to ITERATIONS
    result = (obval1 = obval2)
Next
print "Object check: " + (millisecs() - startTime) 

Function MakeRandomLlongString:String(length:Int = 255)
    Local result:String = ""

    For Local i:Int = 1 To length
        result :+ Chr(Rand(32, 64))
    Next

    Return result
End Function
```
