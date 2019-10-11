---
layout: default
title: Part 1 Importing the sgtk API for bootstrapping
pagename: part-1-importing-sgtk-bootstrap
lang: en
---

# Part 1 - Importing the sgtk API for bootstrapping

[Overview](./sgtk-developer-bootstrapping.md)

## Where should I import sgtk from?

If you've followed the [generating a path and publishing it](../generating-path-and-publish/sgtk-developer-generating-path-and-publish.md) 
guide then your'll have covered the step of importing sgtk. In that step it states that you must import the sgtk API package from
the project configuration you wish to work with. This is still true, however, with bootstrapping, it doesn't actually matter
which initial sgtk API you import, as any sgtk API can perform the bootstrap operation into a different project configuration.
As part of this process it will swap out the currently imported sgtk package for the new project config's sgtk API.

## Downloading a standalone sgtk core API

To start with you need to import an sgtk API package. 
You could import one from an existing project, however this might be tricky to conveniently locate.
A recommended approach would be to download a standalone copy 
of the [latest core API]((https://github.com/shotgunsoftware/tk-core/releases)) which will be used purely for the purpose of bootstrapping.
You should store it in a conveinent place where it can be imported. 
Then you can add the path to `sys.path`, if it's not located in a standard location that python will look in.

## Code

```python
# If your sgtk package is not located in a location where Python will automatically look
# then add the path to sys.path
import sys
sys.path.insert(0, "/path/to/sgtk-package")

import sgtk
```

Now to [authenticate](part-2-authentication.md).