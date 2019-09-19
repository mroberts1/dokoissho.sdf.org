---
title: YASnippet to wrap a model access
date:  2019-08-24
---

A piece of PHP code I use fairly often is wrapping a model or helper field in a
function so the object is only instantiated when accessed. It looks like this:

```php
protected function my_helper() {
	if ( empty( $this->my_helper ) ) {
		$this->my_helper = new MyHelper();
	}

	return $this->my_helper;
}
```

The following bit of YASnippet code expands `wrap_helper` into the above code
and automatically sets the field name once the function name has been entered.

```
# -*- mode: snippet -*-
# name: Wrap a helper or model
# key: wrap_helper
# group: templates
# --
protected function $1() {
	if ( empty( $this->$1 ) ) {
		$this->$1 = new ${2:ClassName}();
	}

	return $this->$1;
}
$0
```
