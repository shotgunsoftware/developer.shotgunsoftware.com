---
layout: default
title: ERROR 18:13:28.365:Hiero(34236) Error! Task type
pagename: hiero-task-type-error-message
lang: en
---

# ERROR 18:13:28.365:Hiero(34236): Error! Task type

## Use case:
After updating to `config_default2`, nuke_studio does not initialize. Under Nuke 12.0 studio I get no errors in the script editor, but in Nuke 11.1v3 I get:

```
ERROR 18:13:28.365:Hiero(34236): Error! Task type tk_hiero_export.sg_shot_processor.ShotgunShotProcessor Not recognised
```

Without fail after a rollback, it still does not initialize the tk-nuke engine, and {% include product %} fails to load anything…

The [community post](https://community.shotgridsoftware.com/t/cant-get-shotgun-toolkit-to-work-with-nuke-studio-config-default2/4586) includes a full log for further details.

## What’s causing the error?
It’s not treating it as a NukeStudio launch, and is probably instead treating it as a standard Nuke launch.

The defined a Nuke Studio Software entity, with a path, and set the args to `-studio`. The arg needs to be `--studio`.

## How to fix
The args on the software entity need to be set to `-studio`.

[See the full thread in the community](https://community.shotgridsoftware.com/t/cant-get-shotgun-toolkit-to-work-with-nuke-studio-config-default2/4586).

