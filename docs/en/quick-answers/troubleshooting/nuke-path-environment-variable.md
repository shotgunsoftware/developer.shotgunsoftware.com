---
layout: default
title: Why does the Nuke integration fail to start when I set the NUKE_PATH environment variable?
pagename: nuke-path-environment-variable
lang: en
---

# Why does the Nuke integration fail to start when I set the NUKE_PATH environment variable?

Our integrations set the `NUKE_PATH` environment variable when launching Nuke so that our bootstrap script runs during the Nuke startup process.
It's the [`tk-multi-launchapp`](https://developer.shotgridsoftware.com/1b9c259a/#set-environment-variables-and-automate-behavior-at-launch) that specifically defines the `NUKE_PATH` prior to it executing the [`before_launch_app.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/6a884aa144851148e8369e9f35a2471087f98d16/hooks/before_app_launch.py) hook. 

If you're setting this environment variable during the launch process using something like `os.environ['NUKE_PATH'] = "/my/custom/path"`, then the {% include product %} integration won't ever be started, because you'll have removed our startup script path from the environment variable.

Use this function in `tank.util` to append or prepend your path to the `NUKE_PATH` environment variable, while preserving the path to the Toolkit bootstrap:

```python
tank.util.append_path_to_env_var("NUKE_PATH", "/my/custom/path")
```

Alternately, you can prepend your path using `prepend_path_to_env_var()`.