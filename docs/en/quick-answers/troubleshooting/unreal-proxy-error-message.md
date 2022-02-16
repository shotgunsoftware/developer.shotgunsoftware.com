---
layout: default
title: Error calling __commands::unreal_engine
pagename: unreal-proxy-error-message
lang: en
---

# `[ERROR] [PROXY]` Error calling __commands::unreal_engine]

## Use case:

After setting up the {% include product %} desktop app, now after being able to get UE4 to show in the {% include product %} app, once I try to Launch Unreal I get these messages:

```
2020-06-06 03:22:24,246 [ ERROR] [PROXY] Error calling __commands::unreal_engine_4.24.3((), {}):
Traceback (most recent call last):
File “C:\Users\USER0\AppData\Roaming\Shotgun\bundle_cache\app_store\tk-desktop\v2.4.12\python\tk_desktop\desktop_engine_project_implementation.py”, line 164, in _trigger_callback
callback(*args, **kwargs)
File “C:\Users\USER0\AppData\Roaming\Shotgun\babilgames\p91c38.basic.desktop\cfg\install\core\python\tank\platform\engine.py”, line 1084, in callback_wrapper
return callback(*args, **kwargs)
File “C:\Users\USER0\AppData\Roaming\Shotgun\bundle_cache\app_store\tk-multi-launchapp\v0.10.2\python\tk_multi_launchapp\base_launcher.py”, line 125, in launch_version
*args, **kwargs
File “C:\Users\USER0\AppData\Roaming\Shotgun\bundle_cache\app_store\tk-multi-launchapp\v0.10.2\python\tk_multi_launchapp\base_launcher.py”, line 343, in _launch_callback
“Could not create folders on disk. Error reported: %s” % err
TankError: Could not create folders on disk. Error reported: Could not resolve row id for path! Please contact support! trying to resolve path ‘D:\UEProjects\SON\D:\UEProjects\SON’. Source data set: [{‘path_cache_row_id’: 2, ‘path’: ‘D:\UEProjects\SON’, ‘metadata’: {‘root_name’: ‘primary’, ‘type’: ‘project’}, ‘primary’: True, ‘entity’: {‘type’: ‘Project’, ‘id’: 91, ‘name’: ‘SON’}}]

```

## What’s causing the error?

The path of the UE4’s Project on disk which was `D:\UEProjects\PROJECT_NAME\` incorrect. 

## How to fix

Creating a new folder for {% include product %}'s settings solves the issue.

[See the full thread in the community](https://community.shotgridsoftware.com/t/error-launching-ue4-from-shotgun/8938).

