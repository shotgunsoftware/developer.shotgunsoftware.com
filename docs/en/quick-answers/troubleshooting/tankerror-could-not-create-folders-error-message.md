---
layout: default
title: TankError Could Not Create Folders On Disk
pagename: tankerror-could-not-create-folders-error-message
lang: en
---

# TankError: Could Not Create Folders On Disk

## Use Case

When adding an operating system for an existing project, Shotgun Desktop can start, but launching a program produces the error:

```
TankError: Could not create folders on disk. Error reported: Critical! Could not update Shotgun with folder data. Please contact support. Error details: API batch() request with index 0 failed.  All requests rolled back.
API create() CRUD ERROR #6: Create failed for [Attachment]: Path /mnt/cache/btltest3 doesn't match any defined Local Storage.
```

Running `tank folders` and other commands produces the same error.

## How to fix

Make sure the filesystem is configured correctly:

- add the corresponding roots to roots.yml
- add an os path in the pipeline configuration, install_location.yml, etc.
- add os paths for Software entities

And importantly:

- add your os path in your Local Storage in Shotgun under Shotgun Site Preferences > File Management.


## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/adding-an-operating-system-for-existing-project/10129)