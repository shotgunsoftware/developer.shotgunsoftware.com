---
layout: default
title: Part 2 Authentication
pagename: part-2-authentication
lang: en
---

# Part 2 - Authentication

[Overview](./sgtk-developer-bootstrapping.md)<br/>
[Previous step](./part-1-importing-sgtk-for-bootstrapping.md)

Before you can perform the bootstrapping you need to authenticate the API against your Shotgun site.

You can either authenticate using user credentials or with script credentials. Which you should use will depend on your
use case.

If the purpose is to bootstrap for a user facing process like launching an app, or running some code that will require user input,
then user authentication is probably the best way to go (This is how all our integrations work by default).
If your writing a script to automate something and a user is not present to authenticate then you should use script credentials.

## User Authentication

```python
# Import Toolkit so we can access to Toolkit specific features.
import sgtk

# Import the ShotgunAuthenticator from the tank_vendor.shotgun_authentication
# module. This class allows you to authenticate either programmatically or, in this
# case, interactively.
from tank_vendor.shotgun_authentication import ShotgunAuthenticator

# Instantiate the authenticator object, passing in the defaults manager.
authenticator = ShotgunAuthenticator()

# Optionally you can clear any previously cached sessions. This will force you to enter credentials each time.
authenticator.clear_default_user()

# The user will be prompted for their username,
# password and optional 2-factor authentication code. If a QApplication is
# available, a UI will pop-up. If not, the credentials will be prompted
# on the command line. The user object returned encapsulates the login
# information.
user = authenticator.get_user()

# Tells Toolkit which user to use for connecting to Shotgun. Note that this should
# always take place before creating a Sgtk instance.
sgtk.set_authenticated_user(user)
```

## Script Authentication

```python
# Import Toolkit so we can access to Toolkit specific features.
import sgtk

# Import the ShotgunAuthenticator from the tank_vendor.shotgun_authentication
# module. This class allows you to authenticate either interactively or, in this
# case, programmatically.
from tank_vendor.shotgun_authentication import ShotgunAuthenticator

# Instantiate the CoreDefaultsManager. This allows the ShotgunAuthenticator to
# retrieve the site, proxy and optional script_user credentials from shotgun.yml
cdm = sgtk.util.CoreDefaultsManager()

# Instantiate the authenticator object, passing in the defaults manager.
authenticator = ShotgunAuthenticator(cdm)

# Create a user programmatically using the script's key.
user = authenticator.create_script_user(
 api_script="Script Name",
 api_key="4e48f....<use the key from your Shotgun site>"
)

# Tells Toolkit which user to use for connecting to Shotgun.
sgtk.set_authenticated_user(user)
```

Next step [bootstrapping!](#part-3-bootstrapping.md)