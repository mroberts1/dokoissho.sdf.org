---
title: Callbacks with BlitzMax
layout: post
---

BlitzMax supports function pointers, but they can be a bit tricky at times.

```blitzmax
Function my_callback_function:String(name:String)
    Return name + " was called!"
End Function

Local function_pointer:String(name:String) = my_callback_function
Print function_pointer("callback")
```

The example above will print "callback was called" when run.

This approach works well enough, but what if you'd like to call a method on an
object? You need to work around it a little bit:

```blitzmax
Type MyType
    Function MyCallback:String(obj:MyType, name:String)
        return MyType(obj).myActualCallback(name)
    End Function
    
    Method myActualCallback:String(name:String)
        return name + " was called!"
    End Method
End Type

Local callback:String(obj:MyType, name:String) = MyType.MyCallback
Local instance:MyType = new MyType
Print callback(instance, "callback")
```

This isn't ideal, as it means all methods need wrapping by another function as
well as have the object passed in.


## Using BlitzMax reflection

BlitzMax has a nice reflection system, which makes it possible to get
information about a variety of things at runtime. This can be used to query a
type and its variables, methods and functions.

Type method information is returned in a `TMethod` object which contains the
method name, parameters and return type. It also has a method called `invoke`,
which calls the method on an object instance.

Using the example `MyType` above, we could get information on `myActualCallback`
using the following:

```blitzmax
Local objectInfo:TTypeId = TTypeId.ForName("MyType")
Local methodInfo:TMethod = objectInfo.FindMethod("myActualCallback")
```

When combined with `invoke`, a method on `instance` can be executed without
explicitly calling it.

```blitzmax
' Executes the 'myActualCallback' method on our instance.
Print String(methodInfo.invoke(instance, ["invoked callback"]))
```

The `invoke` method takes two arguments: an object instance, and an array of
objects that are passed as parameters to the method.


## Wrapping it all up

With a little wrapper class we can call a method on any object instance.


```blitzmax
SuperStrict

Import brl.reflection

Type CallbackWrapper

    Field _caller:Object
    Field _method:TMethod

    Method execute:Object(args:Object[])
        Return Self._method.Invoke(Self._caller, args)
    End Method

    Function Create:CallbackWrapper(caller:Object, methodName:String)

        Local this:CallbackWrapper = New CallbackWrapper

        this._caller = caller
        this._method = TTypeId.ForObject(caller).FindMethod(methodName)

        ' Must be a valid method
        If this._method = Null Then
            Throw "Cannot create a callback for missing method: " + methodName
        EndIf

        Return this

    End Function

End Type
```

This allows us to do the following using the `MyType` object from earlier:

```blitzmax
Local instance:MyType         = new MyType
Local wrapper:CallbackWrapper = CallbackWrapper.create(instance, "myActualCallback")

Print String(callbackInstance.execute("wrapped callback"))
```

Hooray!

One nice thing about this approach is it can be used on any object, so you don't
have to worry about extending a base class. Also, because the callbacks are
BlitzMax objects they can be stored in data structures like `TMap` or
`TList`. Function pointers cannot.

This approach is not without its drawbacks. Because `invoke` uses `Object` for
its arguments and return values, there usually needs to be a little data
massaging to get it working.

To get around this I'll usually write an `execute` method for specific method
signatures I want:

```blitzmax
' Wrapping the `execute` method with something nicer.
Method execute_callback:String(name:String)
    Return String(self._method.invoke(self._caller, [name]))
End Method
```


## Performance

There is a performance hit to using this approach. Testing each approach
10,000,000 times gave the following results on a Linux machine:


{:class="table--striped table--fancy table--benchmark"}
| Method Used                         | Total Time (Milliseconds) |
|-------------------------------------|--------------------------|
| Function Pointer                    | 525                      |
| Type Function Pointer               | 570                      |
| Reflection-based Callback           | 2898                     |
| Reflection-based Callback (wrapped) | 3878                     |


Wrapping the callback with casting slows things down considerably, so there is a
trade-off between readability and speed.


## Example Usages

I've used this approach in a couple of places in my own projects:

  1. The pangolin.events module uses it for [event handlers](https://github.com/sodaware/pangolin.mod/blob/master/events.mod/src/event_handler.bmx).
     Using this system allows events to have handler objects or methods added
     and removed dynamically at runtime.
  2. The pangolin [entity factory](https://github.com/sodaware/pangolin.mod/blob/master/contentdb.mod/src/entity_factory.bmx#L116)
     uses it to check if an object has an `initializeFromTemplate` method. If it
     does, the method is called. Otherwise a warning is signalled and the object
     is created using reflection.
  3. A couple of tools use it to provide some very basic scripting. For example,
     something like ```addCommand("command_name", MyCallback.create(object,
     "exec_command_name"))``` can be used to dynamically add commands.
