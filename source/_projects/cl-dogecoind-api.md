---
title: cl-dogecoind-api
github: sodaware/dogecoind-api
description:
  A Common Lisp library for working with the dogecoind RPC server.
---

**dogecoind-api** is a Common Lisp library for working with a `dogecoind` server
via its RPC interface.


# Client Documentation

A `client` object must be created before any RPC methods can be called. This
should then be passed to any of the RPC methods.

## Creation

By default the client connects to `http://127.0.0.1:8334`, but this can be
overridden by passing the following values to `make-client`:

  - `:host` - The host to connect to.
  - `:port` - The port to connect to.
  - `:protocol` - Connection protocol. Either "http" or "https".


## Authorization

Call `authorize` with a username and password if the RPC requires authentication.

## Client Functions

### dogecoind-api:make-client &keys host port protocol

Create a new RPC client.


### dogecoind-api:authorize client username password

Set the username and password required by the server.


### dogecoind-api:authorizep client

Check if the client has authorization details set.


# Function Documentation

RPC documentation for each method can be found on the
[Bitcoin wiki](https://en.bitcoin.it/wiki/Original_Bitcoin_client/API_calls_list).

The API functions are mapped as follows:

{:class="table--striped table--fancy table--function-map"}
API Method           | Local Method
---------------------|--------------------------------------
addmultisigaddress   | dogecoind-api:add-multisig-address
backupwallet         | dogecoind-api:backup-wallet
getbalance           | dogecoind-api:account-balance
                     | dogecoind-api:server-balance

Some RPC methods are wrapped with several helper methods.


### dogecoind-api:add-multisig-address *client* *keys* &optional *account*

Add a multisignature address to the wallet that requires *keys* in order to
spend and return the newly-created dogecoin address.

Each *key* in *keys* is a dogecoin address or hex-encoded public key. 

If *account* is specified, the address with be assigned to that account.

```common-lisp
;; Create a new multisignature address that will require "address1" and
;; "address2" to spend.
(dogecoind-api:add-multisig-address *client* (list "address1" "address2"))
```


### dogecoind-api:backup-wallet *client* *destination*

Safely copy wallet.dat to *destination*.

*destination* can either be a directory or a path with filename.

```common-lisp
;; Copy the wallet to "/home/doger/my-new-wallet.wallet"
(dogecoind-api:backup-wallet *client* "/home/doger/my-new-wallet.wallet")
```


### dogecoind-api:account-balance *client* *account* *minimum-confirmations* *watch-only-p*

Get the available balance for *account*.

*minimum-confirmations* is the minimum number of confirmations an
externally-generated transaction must have before it is counted towards the
balance.

If *watch-only-p* is true, watch-only addresses will be included in details and
calculations as if they were regular addresses belonging to the wallet.

```common-lisp
;; Get the balance for the "my_account" account
(dogecoind-api:account-balance *client* "my_account")
```


### dogecoind-api:server-balance *client* *minimum-confirmations* *watch-only-p*

Get the total balance of all accounts on the server.

Works the the same as `dogecoind-api:account-balance`.

```common-lisp
;; Get the total balance for all accounts on the server.
(dogecoind-api:server-balance *client*)
```
