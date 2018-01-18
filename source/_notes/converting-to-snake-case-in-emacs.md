---
title: Converting to (and from) snake case in Emacs
date: 2018-01-18
---

[string-inflection](https://github.com/akicho8/string-inflection) is a neat
Emacs package that adds functionality to quickly switch text between `CamelCase`,
`snake_case` and `kebab-case`.

It adds functions that can be called using `M-x` or bound to a shortcut. All of
them can select the word at the current point, so no region needs to be marked
before using them.


## Conversion Functions


### `string-inflection-upcase`

Converts text to `UPPER_SNAKE_CASE`.

  - `ExampleName` becomes `EXAMPLE_NAME`
  - `another-name` becomes `ANOTHER_NAME`


### `string-inflection-camelcase`

Converts text to `CamelCase`.

  - `EXAMPLE_NAME` becomes `ExampleName`
  - `another-name` becomes `AnotherName`


### `string-inflection-underscore`

Converts text to `underscore_case`. Pretty much the same as
`string-inflection-upcase` but with lowercase letters.

  - `ExampleName` becomes `example_name`
  - `another-name` becomes `another_name`


### `string-inflection-kebab-case`

Converts text to `kebab-case`. Also known as `lisp-case` or `dash-case`.

  - `ExampleName` becomes `example-name`
  - `ANOTHER_NAME` becomes `another-name`


### `string-inflection-lower-camelcase`

Converts to `lowerCamelCase`.

  - `EXAMPLE_NAME` becomes `exampleName`
  - `another-name` becomes `anotherName`


## Cycling Cases

There are a few additional functions that cycle between cases.


### `string-inflection-ruby-style-cycle`

Cycles between:
  - Lower snake case
  - Upper snake case
  - Upper camel case


```
emacs_lisp => EMACS_LISP => EmacsLisp => emacs_lisp
```

### `string-inflection-python-style-cycle`

Cycles between:
  - Lower snake case
  - Upper snake case
  - Upper camel case

```
emacs_lisp => EMACS_LISP => EmacsLisp => emacs_lisp
```


### `string-inflection-java-style-cycle`

Cycles between:
  - Lower camel case
  - Upper snake case
  - Upper camel case

```
emacsLisp => EMACS_LISP => EmacsLisp => emacsLisp
```


### `string-inflection-all-cycle`

Cycles between all available cases:
  - Lower snake case
  - Upper snake case
  - Upper camel case
  - Lower camel case
  - Kebab case

```
emacs_lisp => EMACS_LISP => EmacsLisp => emacsLisp => emacs-lisp => emacs_lisp
```

---

<p class="project-information">
    <a href="https://github.com/akicho8/string-inflection" class="button">
        View string-inflection on GitHub
    </a>
</p>
