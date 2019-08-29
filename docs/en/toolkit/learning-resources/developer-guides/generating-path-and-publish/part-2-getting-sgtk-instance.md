---
layout: default
title: Part 2 Getting an Sgtk instance
pagename: part-2-sgtk-instance-guide
lang: en
---

# Part 2 - Getting an Sgtk instance

[Overview](./sgtk-developer-generating-path-and-publish.md)<br/>
[Previous step](./part-1-importing-sgtk.md)

Now you've imported the `sgtk` API the next step towards the end goal of being able to generate a path and publish it, is
to create an `Sgtk` instance.

[`Sgtk`](https://developer.shotgunsoftware.com/tk-core/core.html#sgtk) is a class in the `sgtk` package that acts 
as the main interface to the API. Once we create an instance of `Sgtk` you will be able to do things like get a context,
create folders, or access the templates.

As the API documentation states you don't create an instance of `Sgtk` directly. Here are some options for getting a `Sgtk` instance.

1. You can get a `Sgtk` instance from the current engine, if you are running the Python code within an environment where
 the Shotgun integrations are already started. For example in Maya you could run the following:
 
    ```python
    # Get the engine that is currently running.
    current_engine = sgtk.platform.current_engine()
    
    # Grab the already created Sgtk instance from the current engine.
    tk = current_engine.sgtk
    ```

    You can access the `Sgtk` through the [`engine.sgtk`](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Engine.sgtk) parameter.
    You should note that sometimes pointers to the `Sgtk` instance as referred to by `sgtk` which is not to be confused 
    with `sgtk` the package which you imported the step before. In this guide it will be stored in a variable called `tk`.
    If your using the Shotgun Python console then you will in fact have a pre defined variable called `tk` which you can use.

2. [`sgtk.sgtk_from_entity`](https://developer.shotgunsoftware.com/tk-core/initializing.html#sgtk.sgtk_from_entity) - 
    if you are running in a environment where an engine hasn't already been started you can use this method to get a `Sgtk` instance based upon an entity id.
    The entity who's id you are supplying must belong to the same project that the `sgtk` API was imported from. 
 
3. [`sgtk.sgtk_from_path`](https://developer.shotgunsoftware.com/tk-core/initializing.html#sgtk.sgtk_from_path) -
    much like the `sgtk_from_entity` except this will accept a path to a configuration or a path inside the project root.


You now have a `Sgtk` instance and your ready to start using the API.
In conclusion our publish script now looks like this

```python
import sgtk

# Get the engine that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the already created Sgtk instance from the current engine.
tk = current_engine.sgtk
```

The next step is [getting a context](part-3-getting-context.md).