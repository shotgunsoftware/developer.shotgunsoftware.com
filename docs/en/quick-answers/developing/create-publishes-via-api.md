---
layout: default
title: How can I create publishes via the API?
pagename: create-publishes-via-api
lang: en
---

# How can I create publishes via the API?

Our sgtk API provides a [convenience method](https://developer.shotgunsoftware.com/tk-core/utils.html#sgtk.util.register_publish) for registering `PublishedFiles` entities in Shotgun.

In addition we also have a publish app, that comes with [it's own API](https://developer.shotgunsoftware.com/tk-multi-publish2/). 
This ultimately uses the core sgtk API method to register the PublishedFile, but it also provides a framework around collection, validation and publishing, that can be customized.
As well as the publish API documentation, we have examples of writing your own publish plugins in our [pipeline turorial](https://developer.shotgunsoftware.com/cb8926fc/?title=Pipeline+Tutorial).

## Using the register_publish() API method
While it is possible to create publish records in Shotgun using a raw shotgun API call, we would strongly recommend using Toolkit's convenience methods.
All toolkit apps that create publishes are using a API utility method method called [`sgtk.util.register_publish()`](https://developer.shotgunsoftware.com/tk-core/utils.html#sgtk.util.register_publish).

Basically, this method will create a new  PublishedFile entity in Shotgun and is trying to make that easy by using toolkit concepts. Your code would need to do something along these lines:

```python
# Get access to the toolkit API
import sgtk

# this is the file we want to publish.
file_to_publish = "/mnt/projects/proj/seq_abc/shot_123/comp/foreground.v034.nk"

# alternatively, for file sequences, we can just use
# a standard sequence token
# file_to_publish = "/mnt/projects/proj/seq_abc/shot_123/comp/renders/v034/foreground.%04d.exr"

# The name for the publish should be the filename
# without any version number or extension
name = "foreground"

# initialize an API object. If you have used the toolkit folder creation 
# to create the folders where the publish file resides, you can use this path
# to construct the API object. Alternatively you can create it from any Shotgun
# entity using the sgtk_from_entity() method.
tk = sgtk.sgtk_from_path(file_to_publish)

# use the file to extract the context. The context denotes the current work area in toolkit
# and will control which entity and task the publish will be linked up to. If you have used the toolkit
# folder creation to create the folders where the publish file resides, you can use this path
# to construct the context.
ctx = tk.context_from_path(file_to_publish)

# alternatively, if the file you are trying to publish is not in a location that is
# recognized by toolkit, you could create a context directly from a Shotgun entity instead:
ctx = tk.context_from_entity("Shot", 123)
ctx = tk.context_from_entity("Task", 123)

# Finally, run the publish command.
# the third parameter (file.nk) is typically the file name, without a version number.
# this makes grouping inside of Shotgun easy. The last parameter is the version number.
sgtk.util.register_publish(
  tk, 
  ctx, 
  file_to_publish, 
  name, 
  published_file_type="Nuke Script",
  version_number=34
)
```

Note that there are also several additional options you can populate in addition to the basic ones shown above:

- The **publish name** should be without any version number and extension. When Toolkit and Shotgun groups publishes together into version "streams", it typically groups items by publish name and entity link.
- The **publish file type** parameter in the example above will set a Published File Type property on the publish. This allows you to categorize different types of content. In Toolkit apps and other places this can then be used to distinguish between different types of data. We recommend a brief description of the content of the file rather than a repetition of the file extension (which can be accessed separately). Examples: `Nuke Script`, `Rendered Sequence`, `Background Plates`, `Diffuse Texture Map`, `Maya Rig`, `Alembic Geometry`. 
- To register dependencies, pass a **dependency_ids=[123, 456]** parameter with a list of all the publish ids that the file you are publishing depends on. For example, if you are publishing a nuke script, scan your nuke scene and find all the read nodes - in this particular case, these are your dependencies.
- Alternatively, if you don't have the publish ids, you can instead pass a list of paths using the **dependency_paths** parameter.
- To associate a thumbnail with the publish, pass a **thumbnail_path** parameter.
- If the publish is associated with a particular version that is to be reviewed, pass in its id via the **version_entity** parameter.
- Add a short description of what the publish contains using the **comment** parameter.

For a full list of parameters, see the Core API documentation. 

{% include info title="Tip" content="If your code is running from within a Toolkit app you can grab the sgtk instance via `self.sgtk` and the context with `self.context`.
If it's not in an app, but will be running within software where a Toolkit integration is present, you can access the current context and sgtk instance with the following code:

```python
import sgtk
currentEngine = sgtk.platform.current_engine()
tk = currentEngine.sgtk
ctx = currentEngine.context
```
" %}