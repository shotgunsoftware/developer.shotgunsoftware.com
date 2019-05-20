---
layout: default
title: How do I uninstall an app or engine?
pagename: uninstalling-an-app-or-engine
lang: en
---

# How do I uninstall an app or engine?

You can remove an app or engine by editing your configuration's environment yml files, so that the app or engine is no longer present. 
As the environment files allow you to configure apps to only be available in certain contexts or engines instead of removing them entirely.
To find out more about editing environment in general, take a look at [this guide](.../.../toolkit/learning-resources/guides/editing_app_setting.md).

## Example 

Here is an example on how to entirely remove the publish app from our default configuration.
The publisher is an app, and apps are added to engines inside the environment settings, so we must remove the publish app from all engines that include it.

### Removing the App from the engines

Each engine has it's own yml file inside [`.../env/includes/settings`](https://github.com/shotgunsoftware/tk-config-default2/tree/master/env/includes/settings), as the publisher is included in all engines you will need to modify each engine yml. Taking the Maya engine as an example you would open up [tk-maya.yml](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/settings/tk-maya.yml) and remove all references to the publish2 app.

The first you have a reference to it in the includes section:<br/>
https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/settings/tk-maya.yml#L18

After that we have the app being included in the Maya engine when in an Asset Step context:<br/>
https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/settings/tk-maya.yml#L47<br/>
As well as a line adding it to the menu favourites:<br/>
https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/settings/tk-maya.yml#L56

Then you have a repeat of these lines under the Shot Step settings:<br/>
https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/settings/tk-maya.yml#L106<br/>
https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/settings/tk-maya.yml#L115

You would then repeat these steps for all the other engine environment yml files, such as `tk-nuke`, `tk-3dsmaxplus`, `tk-desktop` and so on.

{% include info title="Important" content="At this point you have done enough to stop the app from appearing in the integrations for your users, so this is as far as you need to go, but if you want to completely remove reference to the app from your configuration for the sake of keeping it clean you would need to complete the remaining steps." %}

### Removing the App settings

All those engines were including [the `tk-multi-publish2.yml`](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/settings/tk-multi-publish2.yml) settings file. Now you have removed reference to it in your engine ymls you can remove this file entirely.

{% include warning title="Important" content="If you remove the `tk-multi-publish2.yml` but still have engine files pointing at it then you will likely get an error along the lines of this: 

    Error
    Include resolve error in '/configs/my_project/env/./includes/settings/tk-desktop2.yml': './tk-multi-publish2.yml' resolved to '/configs/my_project/env/./includes/settings/./tk-multi-publish2.yml' which does not exist!
" %}

### Removing the App Location

All the apps store their location descriptor in [this](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/app_locations.yml) file. The `tk-multi-publish2.yml` referenced this so you would need to remove [these lines](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/app_locations.yml#L52-L56).