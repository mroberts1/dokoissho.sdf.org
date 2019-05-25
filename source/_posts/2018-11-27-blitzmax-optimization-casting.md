---
title: BlitzMax optimization - Object casting
layout: post
categories:
  - blitxmax
---

With the exception of numeric types (`Byte`, `Short`, `Int`, `Float`, `Double`
and `Long`), all objects in BlitzMax extend the from base `Object` type. This
comes in handy for passing around variables that can be different types, but
there's some overhead when converting (i.e. casting) an `Object` to a different
type.


For example:

```blitzmax
Type MyType
    Field something:String
     
    Method New()
         Self.something = "Hello, World!"
    End Method
End Type

' Create a new MyType but assign it to an Object variable.
Local o:Object = new MyType

' The following code is invalid:
' Print o.something

' The variable needs to be cast first:
Print MyType(o).something
```

There's normally no need to use plain `Object` types, but collections like `TMap`
and `TList` use them for storing generic objects. This makes it easier to create
lists on the fly, but comes with some overhead.


## Summary

1. Casting an object is approximately **8x slower** than not casting.
2. The size of the object (i.e. the number of fields and methods) **does not**
   affect performance.
3. Casting happens automatically when iterating over a collection (such as a
   TList). If possible, **use arrays or a strongly-typed list** if frequently
   iterating over the same collection.


## Casting benchmarks

All benchmarks are in release mode with threading enabled. Each test was
executed 1,000,000,000 times.

{:class="table--striped table--fancy table--benchmark"}
Assignment Type   | Execution Time (milliseconds)
------------------|------------------------------
No Cast           | 324
Cast              | 2849

The size of the object makes no difference. The same as the previous test, but
with a type containing 2,000 fields:

{:class="table--striped table--fancy table--benchmark"}
Assignment Type   | Execution Time (milliseconds)
------------------|------------------------------
No Cast           | 328
Cast              | 2916


## Reducing casting

For collections that are large, or iterated over frequently, a strongly-typed
collection will help with performance. If the size of the collection remains the
same, an array will be fastest. A strongly-typed
[ObjectBag](https://www.sodaware.net/dev/blitz/modules/sodaware.mod/) is
almost as fast but can also be resized on the fly.


## Test code

```blitzmax
SuperStrict
Framework brl.basic

Const ITERATIONS:Int = 1000000000
Local startTime:Int
Local counter:int

' -- No Casting
Local result1:Object
Local o:Object = new MyType
startTime = millisecs()
For local i:int = 1 to ITERATIONS
	result1 = o
Next
Print "No Cast: " + (millisecs() - startTime) 

' -- Casting
Local result2:MyType
startTime = millisecs()
For local i:int = 1 to ITERATIONS
	result2 = MyType(o)
Next
Print "Cast: " + (millisecs() - startTime) 

Type MyType
     Field something:String
     Field something_else:Int
End Type
```
