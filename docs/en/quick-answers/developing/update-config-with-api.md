---
layout: default
title: How do I update my Toolkit config programmatically with the API?
pagename: update-config-with-api
lang: en
---

# How do I update my Toolkit config programmatically with the API?

## Updating apps, engines, and frameworks
If you want to programmatically update all of the engines, apps, and frameworks to their latest versions, you can do so using the following code:

```python
import sys
sys.path.append("<path_to_your_config>/install/core/python")
import sgtk

# substitute your Project id here or alternatively use sgtk_from_path()
tk = sgtk.sgtk_from_entity('Project', 161)
c=tk.get_command("updates")

# setup authentication
if hasattr(sgtk, "set_authenticated_user"): 
     from tank_vendor.shotgun_authentication import ShotgunAuthenticator
     user = ShotgunAuthenticator(sgtk.util.CoreDefaultsManager()).get_default_user() 
     sgtk.set_authenticated_user(user)

# finally, execute the command
c.execute({})
```

{% include warning title="Caution" content="This will update all of the engines, apps, and frameworks in this pipeline configuration to the latest version without any further interaction or confirmation. Be sure you’re aware of this before proceeding." %}

## Updating the core

If you want to update your Project's core version from a script in order to run it non-interactively, you can do so using the following code:

```python
import sys
sys.path.append("<path_to_your_config>/install/core/python")
import sgtk

# substitute your Project id here or alternatively use sgtk_from_path()
tk = sgtk.sgtk_from_entity('Project', 161)
c=tk.get_command("core")

# setup authentication
if hasattr(sgtk, "set_authenticated_user"): 
    from tank_vendor.shotgun_authentication import ShotgunAuthenticator
    user = ShotgunAuthenticator(sgtk.util.CoreDefaultsManager()).get_default_user() 
    sgtk.set_authenticated_user(user)

# finally, execute the command
c.execute({})
```

{% include warning title="Caution" content="This will update the Toolkit core to the latest version without any further interaction or confirmation. If the core you are running this from is a shared core, this will update the core version that is used by all projects sharing this core version! Be sure you're aware of this before proceeding." %}

See also:

- [Authentication and login credentials in custom scripts](https://developer.shotgridsoftware.com/724152ce/)
