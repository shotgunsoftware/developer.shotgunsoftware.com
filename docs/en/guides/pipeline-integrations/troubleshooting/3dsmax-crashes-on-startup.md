---
layout: default
title: Why does 3ds Max crash on startup when using ShotGrid Toolkit?
pagename: 3dsmax-crashes-on-startup
lang: en
---

# Why does 3ds Max crash on startup when using {% include product %} Toolkit?

When launching 3ds Max from {% include product %} Desktop or the {% include product %} website, it is possible that 3ds Max will freeze, leaving you with a frozen white dialog, or the following message will appear:

    Microsoft Visual C++ Runtime Library (Not Responding)
    Runtime Error!
    Program: C:\Program Files\Autodesk\3ds Max 2016\3dsmax.exe
    R6034
    An Application has made an attempt to load the C runtime library incorrectly.
    Please contact the application's support team for more information.

This is generally due to a version of `msvcr90.dll` in your path that conflicts with the version of Python that is bundled with 3ds Max. 

## Solution

First, go to your pipeline configuration’s `config/hooks` folder and create the file `before_app_launch.py`. In it, paste the following:

```python

"""
Before App Launch Hook
This hook is executed prior to application launch and is useful if you need
to set environment variables or run scripts as part of the app initialization.
"""
import os
import tank

class BeforeAppLaunch(tank.get_hook_baseclass()):
    """
    Hook to set up the system prior to app launch.
    """
    def execute(self, **kwargs):
        """
        The execute functon of the hook will be called to start the required application
        """
        env_path = os.environ["PATH"]
        paths = env_path.split(os.path.pathsep)
        # Remove folders which have msvcr90.dll from the PATH
        paths = [path for path in paths if "msvcr90.dll" not in map(
            str.lower, os.listdir(path))
        ]
        env_path = os.path.pathsep.join(paths)
        os.environ["PATH"] = env_path
```

Now save the file.

Then, open `config/env/includes/app_launchers.yml` in your pipeline configuration and find the `launch_3dsmax` entry. You should replace `hook_before_app_launch: default` to `hook_before_app_launch: '{config}/before_app_launch.py'`.

You should now be able to launch 3ds Max correctly from {% include product %} and {% include product %} Desktop. If you still have any issues, please visit our [support site](https://knowledge.autodesk.com/contact-support) for help.
