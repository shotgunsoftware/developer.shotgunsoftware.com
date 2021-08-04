---
layout: default
title: Tk-desktop console silently ignoring errors
pagename: tk-desktop-console-silently-ignoring-errors
lang: en
---

# Tk-desktop console silently ignoring errors

## Use case

When developing a toolkit app, tk-desktop is silently ignoring all the exceptions the app raises during initialization,  even though the "Toggle debug logging" checkbox on. The only way to know there is an issue is that registered commands don't show up after loading the config for a project.

## How to fix

When Desktop is loading the app for the project, that logging is never getting passed to SG Desktop main UI process.  However, it should still get output to the `tk-desktop.log`.  Check that file for exceptions.


## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/tk-desktop-console-silently-ignoring-errors/8570)