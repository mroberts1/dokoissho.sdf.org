---
title: Middle-click scrolling on Linux Firefox
date: 2017-10-17
---

After upgrading to Ubuntu 16.04 I noticed my usual middle-click behaviour on
Firefox had changed - instead of enabling auto-scroll it was attempting to
navigate to strange urls.

Normally Ubuntu will try to paste the contents of the clipboard when you click
your middle mouse button. If you're currently in Firefox and you do this it will
try to open what you pasted as a URL.

To revert to middle-click scrolling:

1. Go the the advanced preferences page. To get there, type `about:config` in
   the Address Bar and hit enter.

2. In the preferences search bar type `middlemouse`
   1. Change `middlemouse.contentLoadURL` to `false`.
   2. Change `middlemouse.paste` to `false`.


3. Type `autoScroll` into the preferences search bar. 
   1. Change `general.autoScroll` to `true`.

4. Close the browser and restart.

Middle-click scrolling will now be enabled again.
