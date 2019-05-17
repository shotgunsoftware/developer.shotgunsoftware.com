---
layout: default
title: How do I update engines, apps, and frameworks programmatically with the API?
pagename: update-config-with-api
lang: en
---

# How do I update engines, apps, and frameworks programmatically with the API?

If you want to programmatically update all of the engines, apps, and frameworks to their latest versions, you can do so using the following code:

```
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

This will update all of the engines, apps, and frameworks in this pipelne configuration to the latest version without any further interaction or confirmation. Just be sure you're aware of this before proceeding.

See also:

- [Authentication and login credentials in custom scripts](https://support.shotgunsoftware.com/entries/95445997-How-do-I-work-with-authentication-and-login-credentials-in-custom-scripts-)
- [How do I update my Project's core programmatically?](https://support.shotgunsoftware.com/entries/98173938-How-do-I-update-my-Project-s-core-programmatically-)
