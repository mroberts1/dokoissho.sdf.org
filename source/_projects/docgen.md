---
title: docgen
description:
  A stupid tool for parsing BlitzMax source code and creating documentation files.
---

**docgen** is a quick and dirty tool I built to extract documentation tags from
BlitzMax files.

It turns something like this:

```
''' <summary>My cool function</summary>
''' <param name="name">Who is cool?</param>
''' <return>You are cool</return>
Function whoIsCool:String(name:String)
    Return name + " is cool"
End Function
```

Into this:

```json
{
    "files": [
        {
            "name": "example.bmx",
            "functions": [
                {
                    "name": "whoIsCool",
                    "summary": "My cool function.",
                    "returnType": "String",
                    "returnDescription": "You are cool",
                    "parameters": [
                        {
                            "name": "name",
                            "type": "String",
                            "description": "Who is cool?"
                        }
                    ],
                    "line": 1,
                    "column": 1
                }
            ]
        }
    ]
}
```

Which can then be turned into this:

![docgen-output](/assets/images/docgen-output.png){:class="bordered"}

Exciting, right? The example above was converted from json to docbook XML, and
then from XML to HTML.

More examples can be seen at [docs.sodaware.net](http://docs.sodaware.net/).
