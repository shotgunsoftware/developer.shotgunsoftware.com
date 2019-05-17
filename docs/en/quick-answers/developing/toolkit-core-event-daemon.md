---
layout: default
title: How can I load different Toolkit Core modules using the shotgunEvent daemon?
pagename: toolkit-core-event-daemon
lang: en
---

# How can I load different Toolkit Core modules using the shotgunEvent daemon?

**Huge thanks to [Benoit Leveau @ Milk VFX](https://github.com/benoit-leveau) for sharing this.**

## The Problem

If you're using the [shotgunEvents daemon](https://github.com/shotgunsoftware/shotgunEvents), you may want to perform Toolkit actions inside of a plugin for certain events. This can be tricky since Python only imports a module once. So if your Toolkit Core API for Project A is imported the first time the plugin is run, that is the version that will remain imported for the life of the daemon. This means if the next event dispatched to the plugin is for Project B, you may get an error from Toolkit if you try and instantiate a new Toolkit object for Project B using the core API from Project A.

Since Toolkit is project-centric, you'll have different versions of the Toolkit core and configuration for each Project. Depending on the Project that the event was generated from, you may need to import a different version of the sgtk module from a different location in order to create the correct Toolkit instance. As mentioned, by default Python will only import a module once. So even if you modify the sys.path to point to a new location for your sgtk module and try to import it, Python will see that it has already imported an sgtk module and won't replace it. This will then cause errors when you try and perform Toolkit actions on a project that is different from the one your core API was loaded from.

**Example:**

- Event 123 is for Project A
- The core API for Project A is located at `/mnt/toolkit/projectA/install/core/python`
- Prepend `sys.path` with this directory
- `import sgtk` imports it from this location
- instantiate a Toolkit instance with this core API and perform some action(s)
- pop the core API directory off of `sys.path`
- Event 234 is for Project B
- The core API for Project B is located at `/mnt/toolkit/projectB/install/core/python`
- Prepend `sys.path` with this directory
- `import sgtk` won't do anything since Python sees it's already imported sgtk
- instantiate a Toolkit instance with this core API and perform some action(s)
- This will cause errors since the Toolkit core is for a different Project (A) than the Project (B) you're trying to perform actions on.
 

## The Solution

In a general, the example below shows you how you can import the correct version of the sgtk core in a script or plugin when a different version of the module may have already been imported. The original import is unloaded and removed from memory in Python so the new instance of the module can be imported and used successfully.

```
"""
Example of how to import the correct sgtk core code in a script where
a different instance of the module may have already been imported. The
original import is unloaded and removed from memory in Python so the new
instance of the module can be imported and used successfully.
    
Thanks to Benoit Leveau @ Milk VFX for sharing this.
"""

import os
import sys


def import_sgtk(project):
    """
    Import and return the sgtk module related to a Project.
    This will check where the Core API is located on disk (in case it's localized or shared).
    It shouldn't be used to get several instances of the sgtk module at different places.
    This should be seen as a kind of 'reload(sgtk)' command.

    :param project: (str) project name on disk for to import the Toolkit Core API for.
    """
    # where all our pipeline configurations are located
    shotgun_base = os.getenv("SHOTGUN_BASE", "/mnt/sgtk/configs")
    
    # delete existing core modules in the environment
    for mod in filter(lambda mod: mod.startswith("tank") or mod.startswith("sgtk"), sys.modules):
        sys.modules.pop(mod)
        del mod

    # check which location to use to import the core
    python_subfolder = os.path.join("install", "core", "python")
    is_core_localized = os.path.exists(os.path.join(shotgun_base, project, "install", "core", "_core_upgrader.py"))
    if is_core_localized:
        # the core API is located inside the configuration
        core_python_path = os.path.join(shotgun_base, project, python_subfolder)
    else:
        # the core API can still be localized through the share_core/attach_to_core commands
        # so look in the core_Linux.cfg file which will give us the proper location (modify this
        # to match your primary platform)
        core_cfg = os.path.join(shotgun_base, project, "install", "core", "core_Linux.cfg")
        if os.path.exists(core_cfg):
            core_python_path = os.path.join(open(core_cfg).read(), python_subfolder)
        else:
            # use the studio default one
            # this assumes you have a shared studio core installed.
            # See https://support.shotgunsoftware.com/entries/96141707
            core_python_path = os.path.join(shotgun_base, "studio", python_subfolder)

    # tweak sys.path to add the core API to the beginning so it will be picked up
    if sys.path[0] != "":
        sys.path.pop(0)
    sys.path = [core_python_path] + sys.path 

    # Remove the TANK_CURRENT_PC env variable so that it can be populated by the new import
    if "TANK_CURRENT_PC" in os.environ:
        del os.environ["TANK_CURRENT_PC"]

    # now import the sgtk module, it should be found at the 'core_python_path' location above
    import sgtk
    return sgtk
```
