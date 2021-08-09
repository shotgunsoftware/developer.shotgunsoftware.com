---
layout: default
title: TankError Tried to Resolve a Path From The Template
pagename: tank-error-tried-to-resolve-a-path
lang: en
---

# TankError: Tried to resolve a path from the template

## Use case 1

When setting up a new configuration for SGTK, trying to create a new file through the File Open dialog (in tk-multi-workfiles2), you get the following error:

```
TankError: Tried to resolve a path from the template <Sgtk TemplatePath asset_work_area_maya:
```

## Use case 2

When trying to save in certain tasks, you get the error:

```
TankError: Tried to resolve a path from the template <Sgtk TemplatePath nuke_shot_work:
```


## How to fix

For case 1: Check the `asset.yml` file, it may be missing a filter:

` - { "path": "sg_asset_type", "relation": "is", "values": [ "$asset_type"] }`

For case 2: This can be caused by a Sequence getting renamed, and leaving behind a few FilesystemLocations, which were confusing toolkit.  

The fix:

- Delete stale FilesystemLocations in Shotgun
- Unregister folders related to stale FilesystemLocations from Toolkit
- Register folders again from Toolkit


## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/6468/10)
[and](https://community.shotgridsoftware.com/t/9686)