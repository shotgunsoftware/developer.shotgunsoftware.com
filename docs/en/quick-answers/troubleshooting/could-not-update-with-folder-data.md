---
layout: default
title: Critical! Could not update ShotGrid with folder data.
pagename: could-not-update-with-folder-data
lang: en
---

# TankError: Could not create folders on disk. Error reported: Critical! Could not update {% include product %} with folder data.

## Use Case

We are using centralized configs and are adding Linux support for existing projects, but there are issues with the filsystem configuration.

We already

- added the corresponding roots to roots.yml
- added a linux path in the pipeline configuration, install_location.yml, etc.
- added linux paths for Software entities

Now {% include product %} desktop starts successfully, but when trying to launch a program we get:

```
TankError: Could not create folders on disk. Error reported: Critical! Could not update Shotgun with folder data. Please contact support. Error details: API batch() request with index 0 failed.  All requests rolled back.
API create() CRUD ERROR #6: Create failed for [Attachment]: Path /mnt/cache/btltest3 doesn't match any defined Local Storage.
```

Likewise, when trying to run tank folders and other commands, the same error is printed.

I believe we have added linux paths in all places necessary. Is this a matter of synchronizing the database?

`tank synchronize_folders` prints among other things.

- The path is not associated with any {% include product %} object.

## How to fix

Under Site Preferences > File Management, add your Linux path to your Local storage in {% include product %}.


## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/first-time-setting-up-shotgun-and-i-have-this-error/9384)