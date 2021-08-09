---
layout: default
title: Folder creation aborded
pagename: folder-creation-aborded
lang: en
---

# Failed to create folders: Folder creation aborded

## Use Case

Currently we create new project on the web interface and then use {% include product %} desktop to configure Toolkit as centralized setup. However when try to edit an asset name, it’s no longer working (artist cannot open the file to edit in CCD such as Maya), and the error returned was “Failed to create folders”. {% include product %} asks to rerun tank commands to unregister the asset and reregister it to fix but we don’t know where to run those.

## How to fix

Once the advanced setup wizard has been run on a project, the option to run it is intentionally removed. It is possible to [re setup a project](https://developer.shotgunsoftware.com/fb5544b1/) however if you wish.

You will need to run the tank command mentioned in the error message:

```
tank.bat Asset ch03_rockat_drummer unregister_folders
```

The `tank.bat` can be found at the root of the configuration you set up, if you’re not sure where that is, [this topic](https://community.shotgridsoftware.com/t/how-do-i-find-my-pipeline-configuration/191) should help you find it.

## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/error-in-toolkit-after-renaming-asset/4108)