---
title: Importing a remote MySQL database into another
date: 2018-08-21
---

This is a very simple bash script that downloads a copy of a remote MySQL
database to a temporary file, and then imports that into a local database.

It can't be used to import the local contents into the remote one (deliberately
to prevent me from making mistakes). I use it to keep my local development copy
of a site up-to-date with the production version.


## Configuration

To use the script, replace the variables in the "Configuration" section with
your own values.

{:class="table--striped table--fancy table--function-map"}
Variable         | Description
-----------------|--------------------------------------
SSH\_USER        | The username to login to the remote site with.
SSH\_HOST        | The remote machine to connect to.
REMOTE\_DB\_HOST | The database host on the remote machine. Usually `localhost`.
REMOTE\_DB\_NAME | The remote database name.
REMOTE\_DB\_USER | The user to connect to the database as.
REMOTE\_DB\_PW   | The remote database user's password.
LOCAL\_DB\_HOST  | The local database post. Usually `localhost`.`
LOCAL\_DB\_NAME  | The local database name.
LOCAL\_DB\_USER  | The local database user.
LOCAL\_DB\_PW    | Password for the local database user.


## Code


```bash
#!/bin/bash

# ------------------------------
# -- Configuration.

SSH_USER="<value goes here>"
SSH_HOST="<value goes here>"

REMOTE_DB_HOST="localhost"
REMOTE_DB_NAME="<value goes here>"
REMOTE_DB_USER="<value goes here>"
REMOTE_DB_PW="<value goes here>"

LOCAL_DB_HOST="localhost"
LOCAL_DB_NAME="<value goes here>"
LOCAL_DB_USER="<value goes here>"
LOCAL_DB_PW="<value goes here>"

# ------------------------------
# -- Syncing.

# Remove any existing dumps.
rm /tmp/$REMOTE_DB_NAME.sql

# Fetch the remote database.
echo 'Fetching remote database'
ssh $SSH_USER@$SSH_HOST "mysqldump -u$REMOTE_DB_USER --password='$REMOTE_DB_PW' -h $REMOTE_DB_HOST $REMOTE_DB_NAME" > /tmp/$REMOTE_DB_NAME.sql

# Load it into the local database.
echo 'Importing database dump'
mysql -u$LOCAL_DB_USER --password=$LOCAL_DB_PW -h $LOCAL_DB_HOST $LOCAL_DB_NAME < /tmp/$REMOTE_DB_NAME.sql
```
