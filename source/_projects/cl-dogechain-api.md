---
title: cl-dogechain-api
github: sodaware/cl-dogechain-api
description:
  A Common Lisp library for working with the dogechain.info public API.
---

**dogechain-api** is a Common Lisp library for working with the
[dogechain.info](https://dogechain.info/) API. It can be used to query
[dogecoin](http://dogecoin.com/) addresses and fetch general information about
the dogecoin network.

It's unit tested using [prove](https://github.com/fukamachi/prove) and uses
[drakma](http://weitz.de/drakma/) for making http requests.


# Simple Query API - Function Reference

**dogechain-api** currently supports all endpoints for the
[simple api](https://dogechain.info/api/simple) which are mapped as follows:

{:class="table--striped table--fancy table--function-map"}
API Method           | Local Function
---------------------|--------------------------------------
addressbalance       | dogechain-api:get-address-balance
addresstohash        | dogechain-api:address-to-hash
checkaddress         | dogechain-api:valid-address-p
decode_address       | dogechain-api:decode-address
getblockcount        | dogechain-api:get-block-count
getdifficulty        | dogechain-api:get-difficulty
getreceivedbyaddress | dogechain-api:get-address-received
getsentbyaddress     | dogechain-api:get-address-sent
totalbc              | dogechain-api:get-total-mined


## Functions

### dogechain-api:get-address-balance *address*

Get the total amount ever received, minus the total amount ever sent for
*address*.

Raises an `invalid-address-error`{:class="code--cl-error"} if the address is
invalid.

```common-lisp
CL-USER> (dogechain-api:get-address-balance "DTnt7VZqR5ofHhAxZuDy4m3PhSjKFXpw3e")
12345.6789
```
{:class="has-cl-prompt"}


### dogechain-api:address-to-hash *address*

Get the public key hash for a valid Dogecoin *address*.

Raises an `invalid-address-error`{:class="code--cl-error"} if the address is
invalid.

```common-lisp
CL-USER> (dogechain-api:address-to-hash "DTnt7VZqR5ofHhAxZuDy4m3PhSjKFXpw3e")
"F8783344AF8532A73DFA97EBDDFCC7527A2C6E5A"
```
{:class="has-cl-prompt"}

### dogechain-api:valid-address-p *address*

Check *address* for validity. An invalid address will return `NIL` rather than
raising an error like other API functions.

```common-lisp
CL-USER> (dogechain-api:valid-address-p "DTnt7VZqR5ofHhAxZuDy4m3PhSjKFXpw3e")
T
```
{:class="has-cl-prompt"}

```common-lisp
CL-USER> (dogechain-api:valid-address-p "INVALID")
NIL
```
{:class="has-cl-prompt"}


### dogechain-api:decode-address *address*

Get the version prefix and hash encoded in *address*. Returns an association
list containing `:version` and `:hash` keys.

Raises an `invalid-address-error`{:class="code--cl-error"} if the address is
invalid.

```common-lisp
CL-USER> (dogechain-api:decode-address "DTnt7VZqR5ofHhAxZuDy4m3PhSjKFXpw3e")
((:version . "1E")
 (:hash . "F8783344AF8532A73DFA97EBDDFCC7527A2C6E5A"))
```
{:class="has-cl-prompt"}


### dogechain-api:get-block-count

Get the current block number. This is the total number of blocks that have been
mined.

```common-lisp
CL-USER> (dogechain-api:get-block-count)
123456
```
{:class="has-cl-prompt"}


### dogechain-api:get-difficulty

Get the difficulty of the most recently solved block.

```common-lisp
CL-USER> (dogechain-api:get-difficulty)
123456
```
{:class="has-cl-prompt"}


### dogechain-api:get-address-received *address*

Get the total amount ever received by *address*.

Raises an `invalid-address-error`{:class="code--cl-error"} if the address is
invalid.

```common-lisp
CL-USER> (dogechain-api:get-received-by-address "DTnt7VZqR5ofHhAxZuDy4m3PhSjKFXpw3e")
123456.7890
```
{:class="has-cl-prompt"}


### dogechain-api:get-address-sent *address*

Get the total amount ever sent by *address*.

Raises an `invalid-address-error`{:class="code--cl-error"} if the address is
invalid.


```common-lisp
CL-USER> (dogechain-api:get-sent-by-address "DTnt7VZqR5ofHhAxZuDy4m3PhSjKFXpw3e")
123456.7890
```
{:class="has-cl-prompt"}


### dogechain-api:get-total-mined

Get the total amount of currency ever mined.

```common-lisp
CL-USER> (dogechain-api:get-total-mined)
123456.7890
```
{:class="has-cl-prompt"}
