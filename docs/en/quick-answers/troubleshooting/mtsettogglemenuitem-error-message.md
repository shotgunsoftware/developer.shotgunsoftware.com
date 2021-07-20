---
layout: default
title: Cannot find procedure “MTsetToggleMenuItem”
pagename: mtsettogglemenuitem-error-message
lang: en
---

# Cannot find procedure “MTsetToggleMenuItem”

## Related error messages:

Maya crashs just before loading the full window, after the usual splash screen:
- Cannot find procedure "MTsetToggleMenuItem"

## How to fix:

In the before_app_launch hook before launching Maya, it’s possible that something inadvertently is being removed from the path, causing the error at Maya launch. In this case, adding a python install to `PTHONPATH` will prevent Maya 2019 from finding the Plugin Path.

## Example of what's causing this error: 
The user had several problems, as this hook ensured that `C:\Python27` was set as `PYTHONPATH`, and they actually installed the workstation with this `PYTHONPATH`.

[See the full thread in the community](https://community.shotgridsoftware.com/t/tk-maya-cannot-find-procedure-mtsettogglemenuitem/4629).

