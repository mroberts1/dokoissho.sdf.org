---
title: nginx IP authentication with password fallback
date: 2019-05-12
---

I have a few pages online that I want to be protected, but ocassionally I might
pass out a link to share. I didn't really like having to remember a password, so
I set up an IP whitelist. Anybody not on the list is denied.

The problem is that I need to update the IP whitelist when someone new wants
access, which isn't always practical.

This solution will check for a whitelisted IP first. If that fails, it will
prompt for a username and password.

```nginx
satisfy any;

# Authenticate via IP address.
allow 127.0.0.1; # Should be an actual IP
deny all;

# Try a password if IP didn't match.
auth_basic           "Private";
auth_basic_user_file /path/to/.htpasswd;
```
