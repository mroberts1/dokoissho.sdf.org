---
title: BlitzMax optimization - Resizing arrays
layout: post
categories:
  - blitxmax
---

BlitzMax comes with a number of data structures. Arrays are a staple of the
BASIC dialect, but they can be a pain to use if items need to be frequently
added and removed. BlitzMax's `TList` structure is more flexible, but comes with
a [performance hit when casting objects](/blog/blitzmax-optimization-casting/).


## Resizing arrays

Normally I'd do something like this to resize an array:

```blitzmax
Framework brl.basic

' Create initial array.
Local original:Int[] = [1, 2, 3, 4, 5]
Print original.length
' => 5

' Resize to hold 6 elements.
original = ResizeArray(original, 6)
Print original.length
' => 6

Function ResizeArray:Int[](target:Int[], newSize:Int)
    Local dest:Int[newSize]

    For Local i:Int = 0 to target.Length - 1
        dest[i] = target[i]
    Next
    
    Return dest
End Function
```

It works, but it's not the most efficient. Things slow down when the target
array is large. The main `For` loop can be unrolled or converted to a
`Repeat...Until` loop, but that's a small optimization. It would be nice to
remove the loop entirely.

[bmk-ng](https://github.com/bmx-ng/bmk) comes with a handy function called
`ArrayCopy` for copying the contents of one array to another.

I wrote a [quick performance
test](https://gist.github.com/Sodaware/2a4a5ae46d45d0f64a8e50af7c260623) to
compare `ArrayCopy` against copying elements using a `For...Next` loop. It's
probably not that accurate, but the results are encouraging.

Time to copy a 1,000 element array 1,000,000 times:

{:class="table table--fancy table--striped"}
| Method                     | Time (millisecs) |
|:---------------------------|-----------------:|
| Copy (`For...Next`)        |             2249 |
| `ArrayCopy`                |             1127 |
| Object Copy (`For...Next`) |             3264 |
| Object `ArrayCopy`         |             2152 |

For simple Integer arrays, `ArrayCopy` is about twice as fast as copying using a `For...Next` loop. Copying objects is slower, but still shows a good speed improvement. Nice!

But I wondered if there was a better way to implement resizing. 

BlitzMax has built-in (and mostly undocumented) functionality for [copying and
resizing arrays using "slices"](https://blitzmax.org/docs/en/language/arrays/#copying-an-array).

Instead of creating a larger array and copying the contents, resizing can be
done in a single command:

```blitzmax
Local myArray:Int[10]

' Resize array to be 20 elements.
myArray = myArray[..20]
```

Copying can be done in a single line too:

```blitzmax
Local target:Int[10]
Local destination:Int[10]

destination = myArray[..]
```

Using slices reduces the `ResizeArray` method to this:

```blitzmax
Method ResizeArray:Int[](target:Int[], newCapacity:Int)
    Return target[..newCapacity]
End Method
```

I've resized arrays using `For...Next` loops in a few of my
modules. [ObjectBag#_grow](https://github.com/Sodaware/sodaware.mod/blob/1847b8ecf53754f3452a6595546a87beb058ddb5/objectbag.mod/src/object_bag.bmx#L316)
used it when resizing the internal storage array.

A [quick performance
test](https://gist.github.com/Sodaware/ed1151972c586a6b62facbe986de2fef) gave
the following results for adding 10,000 items to a bag 10,000 times:

{:class="table table--fancy table--striped"}
| Method            | Time (millisecs) |
|:------------------|-----------------:|
| Original `_grow`  |              821 |
| ArrayCopy `_grow` |              559 |
| Slices `_grow`    |              482 |

`ArrayCopy` is a big improvement, but slices are even faster (and work with
vanilla BlitzMax too).

---

The original issue that spawned this post: [#2 Array growing using ArrayCopy](https://github.com/Sodaware/pangolin.mod/issues/2)
