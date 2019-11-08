---
layout: default
title: Part 1 Importing the sgtk API for bootstrapping
pagename: part-1-importing-sgtk-bootstrap
lang: en
---

# Part 2 - Logging

[Overview](./sgtk-developer-bootstrapping.md)<br/>
[Previous step](./part-1-importing-sgtk-for-bootstrapping.md)

Before progressing any further bootstrap it 

```python
# Initialize the logger so we get output to our terminal
sgtk.LogManager().initialize_custom_handler()
# Set debugging to true so that we get more verbose output, (should only be used for testing)
sgtk.LogManager().global_debug = True
```
Now to [authenticate](part-3-authentication.md).