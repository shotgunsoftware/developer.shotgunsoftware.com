---
layout: default
title: Getting a context object
pagename: part-3-getting-context-guide
lang: en
---

# Getting context

## What is a context and why do I need it?

A lot of what happens in Toolkit revolves around context, in other words knowing what you are working on and being able to act accordingly.
In the sgtk API we need to be able to store important details about the entities we are working with, and share it with 
apps or other processes so they can operate in a contextually aware way. 

The [`Context` class](https://developer.shotgunsoftware.com/tk-core/core.html#context) fulfills this purpose, by acting as a container for this information.
You can store the `Task`, `Step`, `entity` (such as a `Shot` or `Asset`), `Project`, and current `HumanUser` within an instance of the class, among a few other things.

You can create as many different context objects as you like in a given session however when there is running engine present there is a concept of a single current context, which the engine keeps track of.
This is the context that the user is currently working in, and that currently running apps should be working with.

In a later step you will be using the context to help resolve a path that can be used for saving or copying a file.

## Acquiring a Context

To create a context you must use one of the following constructor methods `Sgtk.context_from_entity()`, `Sgtk.context_from_entity_dictionary()` or `Sgtk.context_from_path()`.
You access these methods through the sgtk instance we created in the previous step. 

{% include info title="Note" content="in order to get a context from a path you must have already created folders which is step after in this guide." %}

Instead of creating a new context however, we could [grab the current context from the engine](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Engine.context) like this:

```python
current_engine = sgtk.platform.current_engine()

context = current_engine.context
```
Since we will be using the context to help resolve a file path for a Task on a Shot in later steps we need to be certain the context contains the relevant information.  

If your code was running as part of a Toolkit app, 
and your app was configured to only run in a shot_step environment then you could safely assume you would get an appropriate current context.
However, for the sake of avoiding ambiguity in this guide, 
you will create a context explicitly from a `Task`, (that must belong to a `Shot`), using the `Sgtk.context_from_entity()`.

When you create a context you provide the deepest level required for your operations.
For example you could create a context from a Task and Toolkit will work out the rest of the context parameters for you.

```python
context = tk.context_from_entity("Task", 13155)
```

If you print out a representation of the context instance you will get something like this:
```python
print(repr(context))

>> <Sgtk Context:   Project: {'type': 'Project', 'name': 'My Project', 'id': 176}
  Entity: {'type': 'Shot', 'name': 'shot01_running_away', 'id': 1381}
  Step: {'type': 'Step', 'name': 'Comp', 'id': 8}
  Task: {'type': 'Task', 'name': 'Comp', 'id': 13155}
  User: None
  Shotgun URL: https://mysite.shotgunstudio.com/detail/Task/13155
  Additional Entities: []
  Source Entity: {'type': 'Shot', 'name': 'shot01_running_away', 'id': 1381}>

```

Even though you only provided the task, it should have filled in the other related details.  

We're now ready to make use of the context 
In conclusion our publish script now looks like this

```python
import sgtk

# Get the engine instance that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the pre created Sgtk instance from the current engine.
tk = current_engine.sgtk

# Get a context object from a Task, this Task must belong to a Shot for the future steps to work. 
context = sgtk.context_from_entity("Task", 13155)
```