---
layout: default
title: How do I set environment variables before launching software?
pagename: setting_software_environment_variables
lang: en
---

# How do I set environment variables before launching software?

Shotgun Toolkit allows you to use hooks during the launch process to configure the environment and run custom code.

When you launch software, for example Nuke or Maya, via Shotgun Desktop or through the browser integration, the `tk-multi-launchapp` will be run.
This app is responsible for launching the software and ensuring the Shotgun integrations start up as expected. There are two points during this process that are exposed via hooks to allow custom code to be run.

## before_app_launch.py

The [`before_app_launch.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/6a884aa144851148e8369e9f35a2471087f98d16/hooks/before_app_launch.py) hook is called just before the software is launched. 
This provides a perfect opportunity to set any custom environment variables to be passed onto the launched software.

Example:

```python
import os
import tank

class BeforeAppLaunch(tank.Hook):

    def execute(self, app_path, app_args, version, engine_name, **kwargs):
        
        if engine_name == "tk-maya":
            os.environ["MY_CUSTOM_MAYA_ENV_VAR"] = "Some Maya specific setting"
```

{% include warning title="Warning" content="Be careful not to completely redefine environment variables set by Shotgun. 
For example, if you need to add a path to `NUKE_PATH` (for Nuke), or `PYTHONPATH` (for Maya), make sure you append your path to the existing value, rather than replace it.
You can use our convenience method for this:

```python
tank.util.append_path_to_env_var(\"NUKE_PATH\", \"/my/custom/path\")
```
" %}

## app_launch.py
 
The [`app_launch.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/6a884aa144851148e8369e9f35a2471087f98d16/hooks/app_launch.py) hook is called at the point in the process where the software's executable is run.
You can modify this to change how the software is launched. 

For example you might wish to remove the `/b` from the Windows start command so that it doesn't suppress any popups, such as Nuke's command output window.
