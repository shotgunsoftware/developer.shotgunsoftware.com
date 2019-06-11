---
layout: default
title: How do I add a shelf button to launch a Toolkit app in Maya?
pagename: maya-shelf-app-launcher
lang: en
---

# How do I add a shelf button to launch a Toolkit app in Maya?

Adding a shelf button in Maya to launch Toolkit apps in Maya is pretty straightforward. Here is an example of how to add a custom shelf button that opens the [Loader app](https://support.shotgunsoftware.com/entries/95442527). 

{% include info title="Note" content="this assumes Toolkit is currently enabled in your Maya session, this does not bootstrap Toolkit." %}

Open your Script Editor in Maya and paste in the following Python code: 

```
import maya.cmds as cmds 

# The internal Toolkit app name
tk_app = "tk-multi-loader2"

# The public function that opens the app dialog. This function is located in the app's 
# app.py file in the top directory (eg. install/apps/app_store/tk-multi-loader2/app.py.
# The name of this function varies from app to app, but is generally easy to determine by
# looking at the code. 
call_func = "open_publish"

try: 
    import sgtk

    # get the current engine (e.g. tk-maya) 
    current_engine = sgtk.platform.current_engine() 
    if not current_engine: 
        cmds.error("Shotgun integration is not available!") 

    # find the current instance of the app: 
    app = current_engine.apps.get(tk_app) 
    if not app: 
        cmds.error("The Toolkit app '%s' is not available!" % tk_app) 

    # call the public method on the app to show the dialog: 
    app_open_func = getattr(app, call_func)
    app_open_func()
except Exception, e: 
    msg = "Unable to launch Toolkit app '%s': %s" % (tk_app, e)
    cmds.confirmDialog(title="Toolkit Error", icon="critical", message=msg)
    cmds.error(msg)
```

Select this code and drag it on to your custom shelf. See the [Maya docs for more info on how to work with custom shelf buttons](https://knowledge.autodesk.com/support/maya/learn-explore/caas/CloudHelp/cloudhelp/2016/ENU/Maya/files/GUID-C693E884-F81A-4858-B5D6-3856EB8F394E-htm.html).

You should be able to use this code example to launch any Toolkit apps that are enabled in Maya by modifying the `tk_app` and `call_func` variables at the top.
