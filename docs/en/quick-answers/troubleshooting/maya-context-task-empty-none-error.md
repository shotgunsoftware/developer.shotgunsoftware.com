---
layout: default
title: In Maya, when I print context.task, it is empty “None”
pagename: maya-context-task-empty-none-error
lang: en
---

# In Maya, when I print context.task, it is empty “None”

## Use Case

When in Maya, after printing `context.task`, it is `empty “None”`, but when trying other layout files from a different step/task, shows up the `context.task` details. It's also possible to print `context.task` details when navigating through `Open > Layout > new file`, but when saving the file via File Save, the `context.task` is None.

## How to fix

Try [unregistering the folders](https://community.shotgridsoftware.com/t/how-can-i-unregister-folders-when-using-a-distributed-config/189) for one of the Shots that doesn’t work, and then run the folder creation for it again.


## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/context-task-none/3705)