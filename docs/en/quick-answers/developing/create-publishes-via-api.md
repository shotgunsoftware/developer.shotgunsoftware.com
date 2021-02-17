---
layout: default
title: How can I create publishes via the API?
pagename: create-publishes-via-api
lang: en
---

# How can I create publishes via the API?

Our sgtk API provides a [convenience method](https://developer.shotgunsoftware.com/tk-core/utils.html#sgtk.util.register_publish) for registering `PublishedFiles` entities in Shotgun.

In addition we also have a Publish app, that comes with [its own API](https://developer.shotgunsoftware.com/tk-multi-publish2/). 
The Publish API ultimately uses the core sgtk API method to register the PublishedFile, but it also provides a framework around collection, validation, and publishing, which can be customized
In addition to the the Publish API documentation, we have examples of writing your own publish plugins in our [pipeline tutorial](https://developer.shotgunsoftware.com/cb8926fc/?title=Pipeline+Tutorial).

## Using the register_publish() API method
While it is possible to create publish records in {% include product %} using a raw {% include product %} API call, we would strongly recommend using Toolkit's convenience method.
All toolkit apps that create publishes are using a API utility method method called [`sgtk.util.register_publish()`](https://developer.shotgunsoftware.com/tk-core/utils.html#sgtk.util.register_publish).

Basically, this method will create a new PublishedFile entity in {% include product %} and is trying to make that easy by using toolkit concepts. Your code would need to do something along these lines:

```python
# Get access to the Toolkit API
import sgtk

# this is the file we want to publish.
file_to_publish = "/mnt/projects/proj/seq_abc/shot_123/comp/foreground.v034.nk"

# alternatively, for file sequences, we can just use
# a standard sequence token
# file_to_publish = "/mnt/projects/proj/seq_abc/shot_123/comp/renders/v034/foreground.%04d.exr"

# The name for the publish should be the filename
# without any version number or extension
name = "foreground"

# initialize an API object. If you have used the Toolkit folder creation 
# to create the folders where the published file resides, you can use this path
# to construct the API object. Alternatively you can create it from any Shotgun
# entity using the sgtk_from_entity() method.
tk = sgtk.sgtk_from_path(file_to_publish)

# use the file to extract the context. The context denotes the current work area in Toolkit
# and will control which entity and task the publish will be linked up to. If you have used the Toolkit
# folder creation to create the folders where the published file resides, you can use this path
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

There are several options you can populate in addition to the basic ones shown above. 
For a full list of parameters and what they do, see the [Core API documentation](https://developer.shotgunsoftware.com/tk-core/utils.html#sgtk.util.register_publish). 

{% include info title="Tip" content="If your code is running from within a Toolkit app you can grab the sgtk instance via `self.sgtk` and the context with `self.context`.
If it's not in an app, but will be running within software where a Toolkit integration is present, you can access the current context and sgtk instance with the following code:

```python
import sgtk
currentEngine = sgtk.platform.current_engine()
tk = currentEngine.sgtk
ctx = currentEngine.context
```
" %}