---
layout: default
title: Failed to change work area - Error during execution of MEL script
pagename: error-during-execution-mel-script
lang: en
---

# Failed to change work area - Error during execution of MEL script

## Use Case

When creating a new special pipeline configuration for freelancers who don’t have access to the network, we created a new root name and pointed it to another path. The production pipeline configuration has the roots paths pointed to our file server.

But when creating a new file with `tk-multi-workfiles` on Maya, the following error occurs:

```
Failed to change work area - Error during execution of MEL script: file: C:/Program files/Autodesk/Maya2019/scripts/others/setProject.mel line 332: New project location C:\VetorZero\work\Shotgun-workflow_completo\sequences\Seq_001\SH_010\ANIM\maya is not a valid directory, project not created.
Calling Procedure: setProject, in file “C:\Program Files\Shotgun\c” set project(“C:\Vetorzero\work\SHOTGUN-workflow_completo\sequences\Seq_001\SH_010\ANIM\maya”)
```

It created the folder, but it did not create the folder “maya”.

## How to fix

Check to make sure the the folder “maya” was not deleted by mistake. This error has been presented in cases where it was.

## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/new-file-maya-action-error/8225)