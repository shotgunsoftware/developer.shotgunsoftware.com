---
layout: default
title: Finding the latest version number
pagename: part-6-find-latest-version
lang: en
---

# Finding existing files and getting the latest version number

There two methods you could use here. 

1. Since in this particular example you are resolving a publish file, you could use the Shotgun API to query for the
next available version number on `PublishedFile` entities.
2. You can scan the files on disk and work out what versions already exist, and extract the next version number. 
This is helpful if the files your working with aren't tracked in Shotgun (such as work files).

Whilst the first option would probably be most suitable for the example in this guide, both approaches have their uses so we'll cover them both.
Also if you had work files as well and only considered the publish 

## Querying Shotgun for the next version number.

```python
def get_next_version_number(task_id, file_name):
    sg = engine.shotgun
    # run a Shotgun API query to summarize the maximum version number on PublishedFiles that
    # are linked to the task and match the provided name.
    r = sg.summarize(entity_type="PublishedFile",
                 filters = [["task", "is", {"type":"Task", "id": task_id}],
                            ["name","is",file_name]],
                 summary_fields=[{"field":"version_number", "type":"maximum"}])

    # now extract the version number and add 1 to it.
    # In scenarios where there are no files already this summary will return 0.
    return r["summaries"]["version_number"] + 1
    
get_next_version_number(context.task["id"], "scene.ma")
```

## Searching the file system for the next version number.

