---
title: Opening a Quake-style terminal in XFCE
date: 2019-04-13
---

There are a plenty of packages for GNU/Linux that open Quake-style terminal
windows. KDE has [yakuake](https://kde.org/applications/system/yakuake/), and
GTK has [tilda](https://github.com/lanoxx/tilda) and
[Guake](http://guake-project.org/) (and more).

The built-in XFCE terminal can be opened in drop-down mode by calling
`xfce4-terminal` with the `--drop-down` flag.

The following steps will bind opening a terminal window to a keyboard shortcut
without installing additional packages.

## 1. Open XFCE keyboard settings

This can be found under "Settings" > "Keyboard" in the menu, or by running
`xfce4-keyboard-settings` directly.

## 2. Add a new command

![XFCE keyboard settings window](/assets/images/xfce4-keyboard-settings.png)

Switch to the "Application Shortcuts" tab and use the "Add" button to create a
new shortcut.

Enter `xfce4-terminal --drop-down` as the shortcut.

![XFCE new shortcut](/assets/images/xfce4-shortcut.png)

## 3. Enter the shortcut

XFCE will prompt for a shortcut once the command has been added. I went with
`SUPER`{:class="code--keycode"}+`` ` ``{:class="code--keycode"}, but `F12`{:class="code--keycode"} is
another popular shortcut.

Once set up the shortcut key will show a terminal window at the top of the
screen. Pressing it again will hide the window - the window keeps its previous
contents so it can be hidden without losing anything.
