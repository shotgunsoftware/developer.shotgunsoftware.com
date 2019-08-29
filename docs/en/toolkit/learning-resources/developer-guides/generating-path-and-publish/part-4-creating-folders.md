---
layout: default
title: Part 4 Importing sgtk
pagename: part-4-creating-folders
lang: en
---

# Part 4 - Creating Folders

Toolkit can dynamically generate a folder structure on disk based upon your project entities.

This fulfills two purposes.

1. You get an organised structure created on disk where you can place your files.
2. It allows Toolkit to programmatically understand your structure, derive context from it, and know where to place files.

You need to ensure that the folders exist on disk so that you can resolve the path in a later step.
You will use the [Sgtk.create_filesystem_structure()](https://developer.shotgunsoftware.com/tk-core/core.html?#sgtk.Sgtk.create_filesystem_structure) method achieve this:

```python
tk.create_filesystem_structure("Task", context.task["id"])
```
You can use the context object to get the task id to generate the folders.

You code should now look like this:

```python
import sgtk

# Get the engine instance that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the pre created Sgtk instance from the current engine.
tk = current_engine.sgtk

# Get a context object from a Task, this Task must belong to a Shot for the future steps to work. 
context = tk.context_from_entity("Task", 13155)

# create the required folders based upon the task
tk.create_filesystem_structure("Task", context.task["id"])
```

You've now completed all the preparation steps and are ready to move onto [generating a path using a template](part-5-build-a-path.md).
