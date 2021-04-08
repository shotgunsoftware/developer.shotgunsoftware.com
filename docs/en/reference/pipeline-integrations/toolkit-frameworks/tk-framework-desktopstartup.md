---
layout: default
title: Desktop Startup
pagename: tk-framework-desktopstartup
lang: en
---

# Toolkit Desktop Startup Framework
The Desktop Startup framework implements the startup logic of the {% include product %} Desktop. Its main function is to:

1. initialize the browser integration
2. log the user in
3. download Toolkit
4. configure the site configuration
5. auto update itself and the site configuration when necessary
6. launch the `tk-desktop` engine.

> This is an internal Toolkit framework and therefore the interface it implements is subject to change. We advise that you do not use this framework in your projects.

### Locking-down the startup logic

> Note, this requires the {% include product %} Desktop app version `1.3.4`. If you are unsure of your application version, launch the {% include product %} Desktop. Once you are logged in, click on the user icon at the bottom right and click `About...`. The `App Version` should be `1.3.4` or greater.

By default, {% include product %} Desktop downloads `tk-framework-desktopstartup` updates locally on the user's machine and uses it during the launch sequence of the application. When you launch the application, Toolkit automatically checks for updates to the framework. If an update is available, it will also download and install it automatically. 

Alternately, you can configure the {% include product %} Desktop to use a specific copy of the framework instead of using the local copy. This will disable the auto-update function and you will now be responsible for updating your the startup logic. In order to be kept up to date with updates, we suggest you subscribe to [this page](https://support.shotgunsoftware.com/entries/97454918).

#### Download a specific release from GitHub

You will need to download updates from GitHub manually. The bundles can easily be downloaded from the [Releases](https://github.com/shotgunsoftware/tk-framework-desktopstartup/releases) page and you can find more information about each official release [here](https://support.shotgunsoftware.com/entries/97454918#toc_release_notes).

#### Configure the {% include product %} Desktop to use a specific copy

The only way to lock down the startup logic is to use an environment variable. By setting `SGTK_DESKTOP_STARTUP_LOCATION` to the root folder of a copy of the framework, you will tell the {% include product %} Desktop to use this copy of the code when starting up. Once the variable is set, you can launch the {% include product %} Desktop and it will use this specific copy of the startup logic.

> Note that as of this writing the `Startup Version` field in the `About...` box will be `Undefined` when locking the startup logic due to a technical limitation.

#### Reverting to the old behaviour

To revert back your changes, simply unset the environment variable and launch the {% include product %} Desktop.
