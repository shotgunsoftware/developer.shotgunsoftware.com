---
layout: default
title: Generating a path and publishing it
pagename: sgtk-developer-generating-path-and-publish
lang: en
---

# Generating a path and publishing it

This guide covers getting started with the {% include product %} Toolkit Python API, which is what our pipeline integrations are built with.

The purpose of this guide is to walk through a basic example of how you can use the API, and by the end, you will be able to import the Toolkit API and generate a path and publish it.

### Requirements

- An understanding of Python programming fundamentals. 
- A project with an advanced configuration. If you haven't set up a configuration before you can follow the [Getting started with configurations](https://developer.shotgridsoftware.com/5d83a936/) guide.

### Steps

1. [Importing sgtk](#part-1-importing-sgtk)
2. [Getting an Sgtk instance](#part-2-getting-an-sgtk-instance)
3. [Getting context](#part-3-getting-context)
4. [Creating folders](#part-4-creating-folders)
5. [Using a template to build a path](#part-5-using-a-template-to-build-a-path)
6. [Finding existing files and getting the latest version number](#part-6-finding-existing-files-and-getting-the-latest-version-number)
7. [Registering a published file](#part-7-registering-a-published-file)
8. [Pulling it all together into a complete script](#part-8-the-complete-script)

## Part 1: Importing sgtk

The Toolkit API is contained in a python package called `sgtk`. 
Each Toolkit configuration has its own copy of the API, which comes as part of [`tk-core`](https://developer.shotgridsoftware.com/tk-core/overview.html).
To use the API on a project's configuration, you must import the `sgtk` package from the configuration you wish to work with; importing it from a different configuration will lead to errors.

{% include info title="Note" content="You may sometimes come across references to a `tank` package. This is the legacy name for the same thing. While both work `sgtk` is the correct name to use going forward." %}

To import the API you need to make sure that the path to the [core's python folder](https://github.com/shotgunsoftware/tk-core/tree/v0.18.167/python) exists in the [`sys.path`](https://docs.python.org/3/library/sys.html#sys.path).
However, for this example, we recommend that you run this code in the {% include product %} Desktop's Python console.
This will mean that the correct `sgtk` package path is already added to your `sys.path`.
Equally, you don't need to add the path if you are running this code within software where the {% include product %} integration is already running.

When running your code in an environment where {% include product %} is already started you can import the API by simply writing:

```python
import sgtk
``` 
If you want to use the API outside of a {% include product %} integration, for example, if you're testing it in your favorite IDE, then you will need to set the path to the API first:

```python
import sys
sys.path.append("/shotgun/configs/my_project_config/install/core/python")

import sgtk
```

{% include info title="Note" content="If you're using distributed configs and you want to import `sgtk` in an environment where Toolkit hasn't already been bootstrapped, you will need to take a different approach. Please see the [bootstrapping guide](sgtk-developer-bootstrapping.md) for more details." %}

## Part 2: Getting an Sgtk instance

In order to start using the Toolkit API, you'll need to create an instance of the [`Sgtk`](https://developer.shotgridsoftware.com/tk-core/core.html#sgtk) class.

[`Sgtk`](https://developer.shotgridsoftware.com/tk-core/core.html#sgtk) is a class in the `sgtk` package that acts as the main interface to the API.
Once you create an instance of `Sgtk`, you will be able to do things like get a context, create folders, or access the templates.

As the API documentation states, you don't create an instance of `Sgtk` directly. Here are some options for getting an `Sgtk` instance.

1. You can get an `Sgtk` instance from the current engine, if you are running the Python code within an environment where the {% include product %} integrations are already running, (such as the Maya Python console, if Maya was launched from {% include product %}.)
   The `Engine.sgtk` property holds the engine's `Sgtk` instance.
   So for example, in Maya, you could run the following:
 
    ```python
    # Get the engine that is currently running.
    current_engine = sgtk.platform.current_engine()
    
    # Grab the already created Sgtk instance from the current engine.
    tk = current_engine.sgtk
    ```

    You can access the `Sgtk` instance through the [`Engine.sgtk`](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.Engine.sgtk) property.
    
    *Note: The `Engine.sgtk` property should not be confused with or considered the same as the `sgtk` package that you imported in part 1.*

2. [`sgtk.sgtk_from_entity()`](https://developer.shotgridsoftware.com/tk-core/initializing.html#sgtk.sgtk_from_entity) - 
    If you are running in an environment where an engine hasn't already been started, you can use this method to get an `Sgtk` instance based upon an entity id.
    The entity whose id you are supplying must belong to the project that the `sgtk` API was imported from.
    *This doesn't work with distributed configs, please see the [bootstrapping guide](sgtk-developer-bootstrapping.md) for more details.*
 
3. [`sgtk.sgtk_from_path()`](https://developer.shotgridsoftware.com/tk-core/initializing.html#sgtk.sgtk_from_path) -
    much like the `sgtk_from_entity()` except this will accept a path to a configuration or a path to or inside the project root folder, for example, a work file or shot folder.
    *This doesn't work with distributed configs, please see the [bootstrapping guide](sgtk-developer-bootstrapping.md) for more details.*

Throughout this guide we will assume you are running this code in an environment where an engine has already been started, so we'll use option 1.
Also you will store the `Sgtk` class instance in a variable called `tk`.
If you're using the {% include product %} Python Console then the `tk` variable is already pre-defined as a global variable.

You now have an `Sgtk` instance and you're ready to start using the API.
Your publish script should now look like this:

```python
import sgtk

# Get the engine that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the already created Sgtk instance from the current engine.
tk = current_engine.sgtk
```

## Part 3: Getting context

### What is a context and why do I need it?

A lot of what happens in Toolkit revolves around context, in other words knowing what you are working on and being able to act accordingly.
With the Toolkit API, you will need to be able to store important details about the entities you are working with, and share them with apps or other processes so they can operate in a contextually aware way.
For example, when Toolkit knows what task you're working on, it can automatically link your published files to that task in ShotGrid.

The [`Context` class](https://developer.shotgridsoftware.com/tk-core/core.html#context) acts as a container for this information.
You can store the `Task`, `Step`, `entity` (such as a `Shot` or `Asset`), `Project`, and current `HumanUser` within an instance of the class, among a few other things.

You can create as many different context objects as you like in a given session. However, when there is an engine present, there is a concept of a single current context, which the engine keeps track of.
This is the context that the user is currently working in, and that the apps should be working with.

In a later step, you will be using the context to help resolve a path that can be used for saving or copying a file.

### Acquiring a Context

To create a context you must use one of the following constructor methods `Sgtk.context_from_entity()`, `Sgtk.context_from_entity_dictionary()` or `Sgtk.context_from_path()`.
You access these methods through the `Sgtk` instance you created in the previous step, which you stored in the `tk` variable.

{% include info title="Note" content="To get a context from a path, you must have already created folders, which is covered in the next step of this guide." %}

Instead of creating a new context however, you could [grab the current context from the engine](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.Engine.context), that you gathered in [part 2](#part-2-getting-an-sgtk-instance), like this:

```python
context = current_engine.context
```
Since you will be using the context to help resolve a file path for a Task on a Shot in later steps, you need to be certain the context contains the relevant information.  

If your code was running as part of a Toolkit app, and your app was configured to only run in a shot_step environment then you could safely assume you would get an appropriate current context.
However, for the sake of avoiding ambiguity in this guide, you will create a context explicitly from a `Task`, (that must belong to a `Shot`), using the `Sgtk.context_from_entity()`.

When you create a context you provide the deepest level required for your operations.
For example, you could create a context from a Task and Toolkit will work out the rest of the context parameters for you.

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

The publish script should now look like this:

```python 
import sgtk

# Get the engine instance that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the pre-created Sgtk instance from the current engine.
tk = current_engine.sgtk

# Get a context object from a Task. This Task must belong to a Shot for the future steps to work. 
context = tk.context_from_entity("Task", 13155)
```

## Part 4: Creating Folders

Toolkit can dynamically generate a folder structure on disk based upon your project entities.

This fulfills two purposes.

1. You get an organized structure created on disk where you can place your files.
2. It allows Toolkit to programmatically understand your structure, derive context from it, and know where to place files.

You need to ensure that the folders exist on disk so that you can resolve the path in a later step.
You will use the [Sgtk.create_filesystem_structure()](https://developer.shotgridsoftware.com/tk-core/core.html?#sgtk.Sgtk.create_filesystem_structure) method to achieve this:

```python
tk.create_filesystem_structure("Task", context.task["id"])
```
You can use the context object to get the task id to generate the folders.

Your code should now look like this:

```python
import sgtk

# Get the engine instance that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the pre-created Sgtk instance from the current engine.
tk = current_engine.sgtk

# Get a context object from a Task, this Task must belong to a Shot for the future steps to work. 
context = tk.context_from_entity("Task", 13155)

# Create the required folders based upon the task.
tk.create_filesystem_structure("Task", context.task["id"])
```

You've now completed all the preparation steps and are ready to move onto generating a path using a template.

## Part 5: Using a template to build a path

### Generating the path

Whenever you need to know where a file should be placed or found in Toolkit you can use the templates to resolve an absolute path on disk.

[Templates](https://developer.shotgridsoftware.com/tk-core/core.html#templates) are essentially tokenized strings that when you apply the context and other data to, can be resolved into filesystem paths.
They are customizable via your [project's pipeline configuration](https://developer.shotgridsoftware.com/82ff76f7/#part-2---configuring-file-system-templates), and their purpose is to provide a standardized method for working out where files should be stored. 

The first thing you need to do is get a template instance for the path you wish to generate.
Using the `Sgtk` instance you created, you can access the desired `Template` instance via the `Sgtk.templates` attribute, which is a dictionary where the keys are the template names, and the values are [`Template`](https://developer.shotgridsoftware.com/tk-core/core.html#template) instances.

```python
template = tk.templates["maya_shot_publish"]
```

In this example, you will use the `maya_shot_publish` template. 
In the [Default Configuration](https://github.com/shotgunsoftware/tk-config-default2/blob/v1.2.12/core/templates.yml#L305-L306) the unresolved template path looks like this:

```yaml
'sequences/{Sequence}/{Shot}/{Step}/work/maya/{name}.v{version}.{maya_extension}'
```

The template is made up of keys that you will need to resolve into actual values.
Since the context contains enough information for the majority of the keys, you can start by using that to extract values:

```python
fields = context.as_template_fields(template)

>> {'Sequence': 'seq01_chase', 'Shot': 'shot01_running_away', 'Step': 'comp'}
```
The [`Context.as_template_fields()`](https://developer.shotgridsoftware.com/tk-core/core.html#sgtk.Context.as_template_fields) method gives you a dictionary with the correct values to resolve the template keys. 
However, it hasn't provided values for all the keys. The `name`, `version` and `maya_extension` are still missing.

The `maya_extension` key [defines a default value](https://github.com/shotgunsoftware/tk-config-default2/blob/v1.2.8/core/templates.yml#L139) in the template keys section so you don't need to provide a value for that, although you could if you wanted a value other than the default.

Which leaves the `name` and `version`. Since the name is a matter of choice, you can either hard code a default or provide an opportunity for the user to enter a value, for example, by popping up an interface.
For now, you will hard code both, but in the next step, we'll cover how to find the next available version number.

```python
fields["name"] = "myscene"
fields["version"] = 1
```

Now you have all the fields, you're ready to resolve the template into an absolute path using [`Template.apply_fields()`](https://developer.shotgridsoftware.com/tk-core/core.html#sgtk.Template.apply_fields):

```python
publish_path = template.apply_fields(fields)

>> /sg_toolkit/mysite.shotgunstudio.com/my_project/sequences/seq01_chase/shot01_running_away/comp/publish/maya/myscene.v001.ma
```

### Ensuring the folders exist

Although you ran the folder creation method earlier you may need to perform an additional step to ensure that all the folders exist.
This can be required if, for example, your template defines folders that are not present in the schema, and so were not created in the original `create_filesystem_structure()` call.

There are a couple of convenience methods you can use to do this.
If, your code is running in a Toolkit app or hook you can use the [`Application.ensure_folder_exists()`](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.Application.ensure_folder_exists) method.
If, there is an engine present you can use [`Engine.ensure_folder_exists()`](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.Engine.ensure_folder_exists) method.
Or if you're running code outside of an engine, there's [`sgtk.util.filesystem.ensure_folder_exists()`](https://developer.shotgridsoftware.com/tk-core/utils.html#sgtk.util.filesystem.ensure_folder_exists).
Make sure to only create the folders for the directory and not the full file path.
You can import the [`os`](https://docs.python.org/3/library/os.html) module and run [`os.path.dirname(publish_path)`](https://docs.python.org/3/library/os.path.html#os.path.dirname) to extract the folder portion of the full file path.

### Creating or copying a file using the path
At this point you have a path, and you could use this, for example, to tell Maya to save a file there, or perhaps copy the file from a different location. 
It's not important for the sake of this guide that you implement any behavior that actually creates a file on disk in that location.
You can still publish the path even if there is no file there. 
However, you can use [`sgtk.util.filesystem.touch_file()`](https://developer.shotgridsoftware.com/tk-core/utils.html?#sgtk.util.filesystem.touch_file) to get Toolkit to create an empty file on disk.


### Bringing it all together so far

```python
import sgtk
import os

# Get the engine instance that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the pre-created Sgtk instance from the current engine.
tk = current_engine.sgtk

# Get a context object from a Task. This Task must belong to a Shot for the future steps to work. 
context = tk.context_from_entity("Task", 13155)

# Create the required folders based upon the task.
tk.create_filesystem_structure("Task", context.task["id"])

# Get a template instance by providing a name of a valid template in your config's templates.yml.
template = tk.templates["maya_shot_publish"]

# Use the context to resolve as many of the template fields as possible.
fields = context.as_template_fields(template)

# Manually resolve the remaining fields that can't be figured out automatically from context.
fields["name"] = "myscene"
fields["version"] = 1

# Use the fields to resolve the template path into an absolute path.
publish_path = template.apply_fields(fields)

# Make sure we create any missing folders.
current_engine.ensure_folder_exists(os.path.dirname(publish_path))

# Create an empty file on disk. (optional - should be replaced by actual file save or copy logic)
sgtk.util.filesystem.touch_file(publish_path)
```

The next step is to dynamically work out the next version number rather than hard coding it.

## Part 6: Finding existing files and getting the latest version number

There two methods you could use here. 

1. Since in this particular example you are resolving a publish file, you could use the [{% include product %} API](https://developer.shotgridsoftware.com/python-api/) to query for the next available version number on `PublishedFile` entities.
2. You can scan the files on disk and work out what versions already exist, and extract the next version number. 
This is helpful if the files you're working with aren't tracked in {% include product %} (such as work files).

While the first option would probably be most suitable for the example in this guide, both approaches have their uses so we'll cover them both.

### Querying {% include product %} for the next version number.

Using the {% include product %} API and the [`summarize()` method](https://developer.shotgridsoftware.com/python-api/reference.html#shotgun_api3.shotgun.Shotgun.summarize) you can get the highest version number amongst the `PublishedFile` entities, that share the same name and task, and then add 1.

```python
r = sg.summarize(entity_type="PublishedFile",
                 filters = [["task", "is", {"type":"Task", "id": context.task["id"]}],
                            ["name","is", fields["name"] + ".ma"]],
                 summary_fields=[{"field":"version_number", "type":"maximum"}])

# Extract the version number and add 1 to it.
# In scenarios where there are no files already this summary will return 0.
# Apply the version number to the fields dictionary, that will be used to resolve the template into a path.
fields["version"] = r["summaries"]["version_number"] + 1
```

### Searching the file system for the next version number.

Using the Toolkit API you can gather a list of existing files, extract the template field values from them, and then figure out the next version.

In the example below, it's gathering the latest version from the work file template. 
Assuming the work file template and publish file template have the same fields, you could call the method below twice with the same fields to work out the highest publish and work file version and decide using a combination of the two.

```python
def get_next_version_number(tk, template_name, fields):
    template = tk.templates[template_name]

    # Get a list of existing file paths on disk that match the template and provided fields
    # Skip the version field as we want to find all versions, not a specific version.
    skip_fields = ["version"]
    file_paths = tk.paths_from_template(
                 template,
                 fields,
                 skip_fields,
                 skip_missing_optional_keys=True
             )

    versions = []
    for a_file in file_paths:
        # extract the values from the path so we can read the version.
        path_fields = template.get_fields(a_file)
        versions.append(path_fields["version"])
    
    # find the highest version in the list and add one.
    return max(versions) + 1

# Set the version number in the fields dictionary, that will be used to resolve the template into a path. 
fields["version"] = get_next_version_number(tk, "maya_shot_work", fields)
```

The [`sgtk.paths_from_template()`](https://developer.shotgridsoftware.com/tk-core/core.html?highlight=paths_from_template#sgtk.Sgtk.paths_from_template) method will gather all the files on disk that match the provided template and fields.
This is method is also useful for scenarios where you want to find and display a list of files to the user.

You can chose to use either option, but the guide will use the code from option one however to keep it simple.

## Part 7: Registering a published file

Now that you have a path you're ready to publish it. To do this you can use the utility method [`sgtk.util.register_publish()`](https://developer.shotgridsoftware.com/tk-core/utils.html?#sgtk.util.register_publish).

It is possible to use the {% include product %} API's [`{% include product %}.create()`](https://developer.shotgridsoftware.com/python-api/reference.html#shotgun_api3.shotgun.Shotgun.create) method to create a `PublishedFile` entity as well, but we strongly recommend using the Toolkit API for this as it will ensure all the required fields are provided and filled in correctly.

```python
# So as to match the Publish app's default behavior, we are adding the extension to the end of the publish name.
# This is optional, however.
publish_name = fields["name"] + ".ma"
version_number = fields["version"]

# Now register the publish
sgtk.util.register_publish(tk,
                           context,
                           publish_path,
                           publish_name,
                           version_number,
                           published_file_type = "Maya Scene")
```

At this point, it's also worth noting that our [Publish app](https://developer.shotgridsoftware.com/bc718491/) also comes with [its own API](https://developer.shotgridsoftware.com/tk-multi-publish2/) as well.
Although that is still essentially using this same [`sgtk.util.register_publish()`](https://developer.shotgridsoftware.com/tk-core/utils.html?#sgtk.util.register_publish) method, it builds upon the publishing process by providing a framework to handle collection, validation, and publishing.

## Part 8: The complete script

```python
# Initialization
# ==============

import sgtk
import os

# Get the engine instance that is currently running.
current_engine = sgtk.platform.current_engine()

# Grab the pre-created Sgtk instance from the current engine.
tk = current_engine.sgtk

# Get a context object from a Task. This Task must belong to a Shot for the future steps to work. 
context = tk.context_from_entity("Task", 13155)

# Create the required folders based upon the task
tk.create_filesystem_structure("Task", context.task["id"])

# Generating a Path
# =================

# Get a template instance by providing a name of a valid template in your config's templates.yml
template = tk.templates["maya_shot_publish"]

# Use the context to resolve as many of the template fields as possible.
fields = context.as_template_fields(template)

# Manually resolve the remaining fields that can't be figured out automatically from context.
fields["name"] = "myscene"

# Get an authenticated Shotgun API instance from the engine
sg = current_engine.shotgun

# Run a Shotgun API query to summarize the maximum version number on PublishedFiles that
# are linked to the task and match the provided name.
# Since PublishedFiles generated by the Publish app have the extension on the end of the name we need to add the
# extension in our filter.
r = sg.summarize(entity_type="PublishedFile",
                 filters = [["task", "is", {"type":"Task", "id": context.task["id"]}],
                            ["name","is", fields["name"] + ".ma"]],
                 summary_fields=[{"field":"version_number", "type":"maximum"}])

# Extract the version number and add 1 to it.
# In scenarios where there are no files already this summary will return 0.
# Apply the version number to the fields dictionary, that will be used to resolve the template into a path.
fields["version"] = r["summaries"]["version_number"] + 1

# Use the fields to resolve the template path into an absolute path.
publish_path = template.apply_fields(fields)

# Make sure we create any missing folders
current_engine.ensure_folder_exists(os.path.dirname(publish_path))

# Creating a file
# ===============

# This is the bit where you would add your own logic to copy or save a file using the path.
# In the absence of any file saving in the example, we'll use the following to create an empty file on disk.
sgtk.util.filesystem.touch_file(publish_path)

# Publishing
# ==========

# So as to match publishes created by the Publish app's, we are adding the extension to the end of the publish name.
publish_name = fields["name"] + ".ma"
version_number = fields["version"]

# Now register the publish
sgtk.util.register_publish(tk,
                           context,
                           publish_path,
                           publish_name,
                           version_number,
                           published_file_type = "Maya Scene")
```

{% include info title="Tip" content="By this point, the code is getting a bit long, so a recommended next step would be to tidy it up a bit and break things into methods." %}

### Final Thoughts

This guide has hopefully left you with a foundational understanding of how to get started with the Toolkit API.
There are of course many other uses for the API, so we recommend reading through the [tk-core API](https://developer.shotgridsoftware.com/tk-core/index.html) for more information.

Also our [forums](https://community.shotgridsoftware.com/c/pipeline/6) are an excellent place to discuss API questions and get answers, and even leave feedback for us about the this guide.