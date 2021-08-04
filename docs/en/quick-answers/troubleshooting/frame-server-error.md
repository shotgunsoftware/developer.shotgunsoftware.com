---
layout: default
title: The Frame Server has encountered an error
pagename: frame-server-error
lang: en
---

# The Frame Server has encountered an error

## Use Case

When launching Nuke from SG Desktop the error message “The Frame Server has encountered an error.” is presented, and you can continue to work.

Complete error:

```
The Frame Server has encountered an error.

Nuke 12.1v5, 64 bit, built Sep 30 2020.
Copyright (c) 2020 The Foundry Visionmongers Ltd. All Rights Reserved.
Loading - init.py
Traceback (most recent call last):
File “/Applications/Nuke12.1v5/Nuke12.1v5.app/Contents/Resources/pythonextensions/site-packages/foundry/frameserver/nuke/workerapplication.py”, line 18, in
from util import(asUtf8, asUnicode)
ImportError: cannot import name asUtf8
cannot import name asUtf8
```

## How to fix

This error can happen when there is a dev path still on the config.

## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/the-frame-server-has-encountered-an-error/11192)