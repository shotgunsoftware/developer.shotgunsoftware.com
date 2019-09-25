---
layout: default
title: How do I set environment variables before launching software?
pagename: setting-software-environment-variables
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

## Custom wrapper

Some studios have custom wrappers that handle setting the environment variables and launching the software. 
If you prefer to use custom code like this to set the environment, you can point the `Software` entity's [path fields](https://support.shotgunsoftware.com/hc/en-us/articles/115000067493-Integrations-Admin-Guide#Example:%20Add%20your%20own%20Software) to your executable wrapper, and `tk-multi-launchapp` will run that instead.

{% include warning title="Warning" content="Take care with this approach to preserve the environment variables set by Shotgun other wise the integration will not start." %}