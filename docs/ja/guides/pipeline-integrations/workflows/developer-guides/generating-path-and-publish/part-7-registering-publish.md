---
layout: default
title: Part 7 Registering a published file
pagename: part-7-registering-publish
lang: ja
---

# Part 7 - Registering a published file

[Overview](./sgtk-developer-generating-path-and-publish.md)<br/>
[Previous step](./part-6-find-latest-version.md)

Now that you have a path your ready to publish it. To do this we can use the utility method
[`sgtk.util.register_publish()` method](https://developer.shotgunsoftware.com/tk-core/utils.html?#sgtk.util.register_publish).

It is possible to use the Shotgun API's `create` method to create a `PublishedFile` entity as well, but we strongly
recommend using the Toolkit API for this as it will ensure all the required fields are provided and filled in correctly.

```python
# So as to match the publish app's default behaviour, we are adding the extension to the end of the publish name.
# This is optional however.
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

At this point it's also worth noting that our [Publish app](https://support.shotgunsoftware.com/hc/en-us/articles/115000097513-Publishing-your-work)
also comes with [it's own API](https://developer.shotgunsoftware.com/tk-multi-publish2/) as well. 
Although that is still essentially using this same `register_publish` method. 
It builds upon the publishing process by providing a framework to handle collection, validation and publishing.

The final step is to bring it all together in a [complete script](part-8-generating-path-and-publish-complete-script.md).