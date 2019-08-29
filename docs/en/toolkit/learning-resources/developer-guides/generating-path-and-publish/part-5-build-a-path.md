---
layout: default
title: Part 5 Using a template to build a path
pagename: part-5-build-a-path
lang: en
---

# Part 5 - Using a template to build a path

[Overview](./sgtk-developer-generating-path-and-publish.md)<br/>
[Previous step](./part-4-creating-folders.md)

When ever you need to know where a file should be placed or found in Toolkit you can use the templates to resolve an absolute path on disk.

The first thing you need to do is get a template instance for the path you wish to generate.

```python
template = tk.templates["maya_shot_publish"]
```

In this example you will use the `maya_shot_publish` template. 
In the default configuration the unresolved template path looks like this:

```yaml
'sequences/{Sequence}/{Shot}/{Step}/work/maya/{name}.v{version}.{maya_extension}'
```

The template is made up of keys that you will need to resolve into actual values.
Since the context contains enough information for majority of the keys, you can start by using that to extract values:

```python
fields = context.as_template_fields(template)

>> {'Sequence': 'seq01_chase', 'Shot': 'shot01_running_away', 'Step': 'comp'}
```
The [`Context.as_template_fields()`](https://developer.shotgunsoftware.com/tk-core/core.html#sgtk.Context.as_template_fields) gives you a dictionary with the correct values to resolve the template keys. 
However it's not provided values for all the keys. The `name`, `version` and `maya_extension` are still missing.

The `maya_extension` key [defines a default value](https://github.com/shotgunsoftware/tk-config-default2/blob/v1.2.8/core/templates.yml#L139) in the template keys section
so you don't actually need to provide a value for that, although you could if you wished.

Which leaves the `name` and `version`. Since the name is a matter of choice, you can either hard code a default or pop up an interface asking the user to provide a value.
For now you will hard code both, but in the next step we'll cover how to find the next available version number.

```python
fields["name"] = "myscene"
fields["version"] = 1
```

Now you have all the fields, your ready to resolve the template into an absolute path using [`Template.apply_fields()`](https://developer.shotgunsoftware.com/tk-core/core.html#sgtk.Template.apply_fields):

```python
publish_path = template.apply_fields(fields)

>> /sg_toolkit/mysite.shotgunstudio.com/my_project/sequences/seq01_chase/shot01_running_away/comp/publish/maya/myscene.v001.ma
```

Although you ran the folder creation method earlier you may need perform an additonal step to ensure that all the folders exist.
This can be required if for example your template defines folders that are not present in the schema, and so were not created
in the original `create_filesystem_structure()` call.

There are a couple of convenience methods you can use to do this.
If you code is running in a Toolkit app or hook you can use the [`Application.ensure_folder_exists()`](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Application.ensure_folder_exists) method.
If there is an engine present you can use [`Engine.ensure_folder_exists()`](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Engine.ensure_folder_exists)
method. 
Or if your running code outside of an engine, there's [`sgtk.util.filesystem.ensure_folder_exists()`](https://developer.shotgunsoftware.com/tk-core/utils.html#sgtk.util.filesystem.ensure_folder_exists)

At this point you have a path, and you could use this to say tell Maya to save a file there, 
or perhaps copy file from a different location. 
It's not important for the sake of this guide that you implement any behaviour that actually creates a file on disk in that location.
You can still publish the path even if there is no file there.

Recap, this is what your code should look like now:

```python
import sgtk

# Get the engine instance that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the pre created Sgtk instance from the current engine.
tk = current_engine.sgtk

# Get a context object from a Task, this Task must belong to a Shot for the future steps to work. 
context = tk.context_from_entity("Task", 13155)

# Create the required folders based upon the task
tk.create_filesystem_structure("Task", context.task["id"])

# Get a template instance by providing a name of a valid template in your config's templates.yml
template = tk.templates["maya_shot_publish"]

# Use the context to resolve as many of the template fields as possible.
fields = context.as_template_fields(template)

# Manually resolve the remaining fields that can't be figured out automatically from context.
fields["name"] = "myscene"
fields["version"] = 1

# Use the fields to resolve the template path into an absolute path.
publish_path = template.apply_fields(fields)

# Make sure we create any missing folders
current_engine.ensure_folder_exists(publish_path)
```

Next step is to [dynamically work out the next version number](part-6-find-latest-version.md) rather than hard coding it.