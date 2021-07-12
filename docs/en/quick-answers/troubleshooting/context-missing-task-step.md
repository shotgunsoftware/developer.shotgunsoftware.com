---
layout: default
title: Why is my context missing the Task/Step when it exists as part of the filename?
pagename: context-missing-task-step
lang: en
---

# Why is my context missing the Task/Step when it exists as part of the filename?

When you create folders via Toolkit it [registers the path](../administering/what-is-path-cache.md) against the entity so that a lookup may be performed. This means that given a path, you can determine the correct context.
Toolkit will only create registries for folders generated from the schema, and so it doesn't consider things like file names or folders that were defined solely in the `templates.yml` file.
If you don't have a `Task` folder in your schema then you can get in a situation where Toolkit needs to know the task of the file but is unable to work out the task from the path alone.

**Example**

Take the default schema structure below; `Asset` and `Step` folders will be registered during the folder creation process:

![Default Asset schema](./images/asset-schema.png)

If you generated a file path using a template like this:

    assets/{sg_asset_type}/{Asset}/{Step}/work/maya/{task_name}_{name}.v{version}.{maya_extension}`

And then attempted to figure out the context from that generated path, it would only be able to establish the `Asset` and the `Step` and **not** the `Task` despite the task's name being in the file path.

**Solution**

Having a `Step` folder and no `Task` folder in your schema is fine for most workflows. Normally you would use the Workfiles app to open your scene file by selecting the task you want to work on and then selecting the file. The task you select in the UI is then used to drive the context rather than trying to figure it out from the path of the opened file.

However, there are situations where it may be important to be able to get the context from a path such as:

- Using our automatic context switching feature; this is a feature that allows Toolkit to detect when you open a file in a software's native open dialog (rather than via the Workfiles app) and switch the current context accordingly.
- Using the API in a standalone process where it needs to figure out the context for a given file.

The solution in these situations would be to either introduce a `Task` folder into your schema or not use automatic context switching, or in the case of the API script, ensure that your process already has the required context information up front, to save it from having to do this lookup.
