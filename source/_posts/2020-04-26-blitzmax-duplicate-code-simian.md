---
title:  Finding duplicate BlitzMax code with simian
layout: post
---

I've recently started using [simian](www.harukizaemon.com/simian/) to track down
duplicate code blocks in my BlitzMax projects. Although simian doesn't come with
BlitzMax support built-in, it's possible to use some of the other settings to
work with bmx code.


## Examples

I have `java -jar simian.jar` aliased to just `simian` so it's easier to read.

An example run looks a little like this (scanning
[pangolin/contentdb](https://github.com/Sodaware/pangolin.mod/tree/master/contentdb.mod)):


```bash
$ simian -excludes="**/*.tests.bmx" -language=vb -threshold=5 **/*.bmx

Similarity Analyser 2.5.10 - http://www.harukizaemon.com/simian
Copyright (c) 2003-2018 Simon Harris.  All rights reserved.
Simian is not free unless used solely for non-commercial or evaluation purposes.
{failOnDuplication=true, ignoreCharacterCase=true, ignoreCurlyBraces=true, ignoreIdentifierCase=true, ignoreModifiers=true, ignoreStringCase=true, language=VB, threshold=5}
Found 5 duplicate lines with fingerprint 58349a293c079cddfe30357e667a5aa4 in the following files:
 Between lines 193 and 206 in pangolin.mod/contentdb.mod/src/entity_template.bmx
 Between lines 151 and 163 in pangolin.mod/contentdb.mod/src/component_schema.bmx
Found 7 duplicate lines with fingerprint 285244b124a3a29e5c65d4106d0aba7d in the following files:
 Between lines 57 and 70 in pangolin.mod/contentdb.mod/src/component_schema.bmx
 Between lines 81 and 96 in pangolin.mod/contentdb.mod/src/component_field.bmx
Found 24 duplicate lines in 4 blocks in 3 files
Processed a total of 748 significant (1598 raw) lines in 9 files
Processing time: 0.099sec
```

Analysis is quick; the entire pangolin project takes under a second to check.


### Treating BlitzMax code as plaintext

By default simian treats files with unknown extensions as plaintext.

The following will find files in the "src" directory that have more than 6 lines
duplicated:

```bash
simian src/**/*.bmx
```


### Ignoring BlitzMax comments

Plaintext is enough for most use cases, but it also includes comments in
duplication checks. To exclude comments, we can set the language to Visual Basic
as it uses the same `'` comment syntax as BlitzMax.

The adjusted version will now ignore duplicated comments:

```bash
simian -language=vb src/**/*.bmx
```


### Adjusting the threshold

The `-threshold` parameter can be used to adjust the number of copied lines that
trigger a copy warning.

The following will trigger a warning if 5 lines or more match in separate files:

```bash
simian -language=vb -threshold=5 src/**/*.bmx
```
