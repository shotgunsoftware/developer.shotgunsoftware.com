---
layout: default
title: How can I load different Toolkit Core modules using the Shotgun Event Daemon?
pagename: toolkit-core-event-daemon
lang: en
---

# How can I load different Toolkit Core modules using the shotgunEvent daemon?

**Huge thanks to [Benoit Leveau @ Milk VFX](https://github.com/benoit-leveau) for sharing this.**

## The problem

Toolkit's sgtk API is project-centric. In other words, you must import it specifically from the project you wish to use it on.
This means that if you use sgtk API operations for multiple projects in a single Python session, then you will run into a problem, as Python only allows a module with the same name to be imported once.

If you're using the [{% include product %} event daemon](https://github.com/shotgunsoftware/shotgunEvents), you may want to perform Toolkit actions inside of a plugin for certain events. This can be tricky since Python only imports a module once. So if your Toolkit Core API for Project A is imported the first time the plugin is run, that is the version that will remain imported for the life of the daemon. This means if the next event dispatched to the plugin is for Project B, you may get an error from Toolkit if you try and instantiate a new Toolkit object for Project B using the core API from Project A.

**Example of the problem using centralized configs:**

- Event 123 is for Project A.
- The core API for Project A is located at `/mnt/toolkit/projectA/install/core/python`.
- Prepend `sys.path` with this directory.
- `import sgtk` imports it from this location.
- Instantiate a Toolkit instance with this core API and perform some action(s).
- Pop the core API directory off of `sys.path`.
- Event 234 is for Project B.
- The core API for Project B is located at `/mnt/toolkit/projectB/install/core/python`.
- Prepend `sys.path` with this directory.
- `import sgtk` won't do anything since Python sees it's already imported sgtk.
- Instantiate a Toolkit instance with this core API and perform some action(s).
- This will cause errors since the Toolkit core is for a different Project (A) than the Project (B) you're trying to perform actions on.

## The solution

The example below shows you how you can import the correct version of the sgtk core in a script or plugin when a different version of the module may have already been imported. The original import is unloaded and removed from memory in Python so the new instance of the module can be imported and used successfully.

```python
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

## Distributed Configs

The above example is assuming you are using a [centralized config](https://developer.shotgridsoftware.com/tk-core/initializing.html#centralized-configurations), however, things are a bit different if you are using a [distributed config](https://developer.shotgridsoftware.com/tk-core/initializing.html#distributed-configurations). Importing the sgtk API for a distributed config requires you to use the [bootstrap API](https://developer.shotgridsoftware.com/tk-core/initializing.html#bootstrap-api). When using the bootstrap API, you usually start by importing a non-project centric sgtk API and then use that to bootstrap an engine for a given project. 
The bootstrap process handles the swapping out of the sgtk modules so that at the end of the bootstrap process you have an engine object. If you import sgtk after bootstrap, it will import the relevant sgtk module appropriate to your project. Given the example above of needing to load sgtk for multiple projects, you would need to bootstrap for multiple projects instead. The small catch here is that you can only have one engine running at a time, so you must destroy it before you load another.

{% include warning title="Warning" content="Bootstrapping a config can be slow, as the process needs to ensure the config is cached locally and all the dependencies are downloaded. Bootstrapping in an Event Daemon plugin could severely affect performance. One potential approach would be to spawn off separate Python instances for each project bootstrap to communicate and send commands from the plugins. This will avoid needing to re-bootstrap a project each time it is needed." %}


Here is an example: 

```python
# insert the path to the non project centric sgtk API
sys.path.insert(0,"/path/to/non/project/centric/sgtk")
import sgtk

sa = sgtk.authentication.ShotgunAuthenticator()
# Use the authenticator to create a user object.
user = sa.create_script_user(api_script="SCRIPTNAME",
                            api_key="SCRIPTKEY",
                            host="https://SITENAME.shotgunstudio.com")

sgtk.set_authenticated_user(user)

mgr = sgtk.bootstrap.ToolkitManager(sg_user=user)
mgr.plugin_id = "basic."

engine = mgr.bootstrap_engine("tk-shell", entity={"type": "Project", "id": 176})
# import sgtk again for the newly bootstrapped project, (we don't need to handle setting sys paths)
import sgtk
# perform any required operations on Project 176 ...

# Destroy the engine to allow us to bootstrap into another project/engine.
engine.destroy()

# now repeat the process for the next project, although we don't need to do the initial non-project centric sgtk import this time.
# We can reuse the already import sgtk API to bootstrap the next
...
```

{% include info title="Note" content="Centralized configs can be bootstrapped as well, so you don't need a different method if you're using a mix." %}