---
layout: default
title: How do I update engines, apps, and frameworks programmatically with the API?
pagename: nuke-path-environment-variable
lang: en
---

# Toolkit Fails to Start When I Set the NUKE_PATH Environment Variable

The Launch app sets the `NUKE_PATH` environment variable prior to the `before_launch_app` hook is executed in order to point Nuke to the Toolkit bootstrap code. So if you're setting this environment variable using something like `os.environ['NUKE_PATH'] = "/my/custom/path"`, then the Toolkit won't ever be started.

Use this function in `tank.util` which will append or prepend your path to the `NUKE_PATH` environment variable while preserving the path to the Toolkit bootstrap:

```
tank.util.append_path_to_env_var("NUKE_PATH", "/my/custom/path")
```

Alternately, you can preprend your path using prepend_path_to_env_var()