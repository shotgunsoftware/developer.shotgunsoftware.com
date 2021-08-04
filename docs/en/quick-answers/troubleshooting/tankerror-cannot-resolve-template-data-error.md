---
layout: default
title: Cannot resolve template data for context
pagename: tankerror-cannot-resolve-template-data-error
lang: en
---

# TankError: Cannot resolve template data for context

## Use Case

When doing an advanced project setup on a new project and using the standalone Publisher app from {% include product %} Desktop to publish some images for a new asset task I’ve created, after selecting the context to validate the publish, the following error is presented:


```
creation for %s and try again!" % (self, self.shotgun_url))
TankError: Cannot resolve template data for context ‘concept, Asset door-01’ - this context does not have any associated folders created on disk yet and therefore no template data can be extracted. Please run the folder creation for and try again!
```

Running `tank.bat Asset door-01 folders` in a terminal resolved this. However, this has never happened on any previous projects.

## How to fix

This may have happened due to this being the first time attempting to standalone publish for a new entity/task without going through a DCC first.

The reason it probably did not happened before is because you’ve started work on the asset in a Software prior to using the standalone publisher, so the folders have already been created/synced. Launching a Software (via Toolkit) will create the folders for the context you launch in, and the open app will create the folders for the context you start a new file in. So usually you don’t need to specifically create folders.

A common practice is that studios generally create folders manually after the shots/assets have been added in {% include product %}. 

Keep in mind also that this is affected by your “folder schema”, which can cause weird issues if it doesn’t completely match the templates.

## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/tank-folder-creation/8674/5)