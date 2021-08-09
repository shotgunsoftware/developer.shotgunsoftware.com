---
layout: default
title: You are loading the Toolkit platform from the pipeline configuration located in
pagename: tankinit-error-pipeline-config-located-in
lang: en
---

# TankInitError: You are loading the Toolkit platform from the pipeline configuration located in

## Use Case

When running some code to publish files from an app, there are times the files belong to a different project.

Is it possible to get around the `TankInitError: You are loading the Toolkit platform from the pipeline configuration located in` error?

Ideally, it's possible to find the context from the path to properly register these files (even if they belong in a different project).

## How to fix

Use the following function:

```
def get_sgtk(proj_name, script_name):
    """ Load sgtk path and import module
    If sgtk was previously loaded, replace include paths and reimport
    """
    project_path = get_proj_tank_dir(proj_name)

    sys.path.insert(1, project_path)
    sys.path.insert(1, os.path.join(
        project_path,
        "install", "core", "python"
    ))

    # unload old core
    for mod in filter(lambda m: m.startswith("sgtk") or m.startswith("tank"), sys.modules):
        sys.modules.pop(mod)
        del mod

    if "TANK_CURRENT_PC" in os.environ:
        del os.environ["TANK_CURRENT_PC"]

    import sgtk
    setup_sgtk_auth(sgtk, script_name)
    return sgtk
```
 The key is deleting all sgtk-related modules from `sys.modules` and removing `TANK_CURRENT_PC` from the environment. This is outlined in [How can I load different Toolkit Core modules using the shotgunEvent daemon?](https://developer.shotgridsoftware.com/3520ad2e/)

## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/tankiniterror-loading-toolkit-platform-from-a-different-project/9342)