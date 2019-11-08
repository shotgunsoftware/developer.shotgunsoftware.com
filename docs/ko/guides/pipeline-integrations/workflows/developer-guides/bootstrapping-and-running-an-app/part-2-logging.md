---
layout: default
title: Part 1 Importing the sgtk API for bootstrapping
pagename: part-1-importing-sgtk-bootstrap
lang: ko
---

# Part 2 - Logging

[Overview](./sgtk-developer-bootstrapping.md)<br/>
[Previous step](./part-1-importing-sgtk-for-bootstrapping.md)

If you are running this script via an IDE or shell, then you will most likely want to enable the logging
to be output. To do this you need to run [`LogManager().initialize_custom_handler()`](https://developer.shotgunsoftware.com/tk-core/utils.html#sgtk.log.LogManager.initialize_custom_handler).
You don't need to provide a custom handler for this purpose, as not providing one will set up a [standard stream based logging handler](https://developer.shotgunsoftware.com/tk-core/utils.html#sgtk.log.LogManager.initialize_custom_handler).

Optionally you can also set the `LogManager().global_debug = True` to give you more verbose output. In other words any
 `logger.debug()` calls should also be output. You should only set this when developing as it can have an impact on performance. 

```python
import sgtk

# Initialize the logger so we get output to our terminal.
sgtk.LogManager().initialize_custom_handler()
# Set debugging to true so that we get more verbose output, (should only be used for testing).
sgtk.LogManager().global_debug = True
```
Next, [authentication](part-3-authentication.md).