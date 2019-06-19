---
layout: default
title: How do I uninstall an app or engine?
pagename: uninstalling-an-app-or-engine
lang: en
---

# How do I uninstall an app or engine?

You can remove an app or engine by editing your configuration's environment yml files, so that the app or engine is no longer present. 
The environment files allow you to configure apps to only be available in certain contexts or engines instead of removing them entirely.
To find out more about editing environment files in general, take a look at [this guide](../../toolkit/learning-resources/guides/editing_app_setting.md).

## Example 

Here is an example on how to entirely remove the Publish app from our Default Configuration.
Apps are added to engines inside the environment settings, so we must remove the Publish app from all engines that its been added to.

### Removing the App from the engines

Each engine has its own YAML file inside [`.../env/includes/settings`](https://github.com/shotgunsoftware/tk-config-default2/tree/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings); as the Publish app is included in all engines you will need to modify each engine yml. Taking the Maya engine as an example you would open up [tk-maya.yml](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/settings/tk-maya.yml) and remove all references to the Publish app.

First there is a reference to it in the includes section:<br/>
[`.../env/includes/settings/tk-maya.yml L18`](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-maya.yml#L18)

The app is also being included in the Maya engine when in an Asset Step context:<br/>
[`.../env/includes/settings/tk-maya.yml L47`](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-maya.yml#L47)<br/>
As well as a line adding it to the menu favourites:<br/>
[`.../env/includes/settings/tk-maya.yml L56`](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-maya.yml#L56)


Then you have a repeat of these lines under the Shot Step settings:<br/>
[`.../env/includes/settings/tk-maya.yml L106`](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-maya.yml#L106)<br/>
[`.../env/includes/settings/tk-maya.yml L115`](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-maya.yml#L115)

You would then repeat these steps for all the other engine environment yml files, such as `tk-nuke`, `tk-3dsmaxplus`, `tk-desktop`, and so on.

{% include info title="Important" content="At this point you have done enough to stop the app from appearing in the integrations for your users, so this is as far as you need to go, but if you want to completely remove reference to the app from your configuration for the sake of keeping it clean you would need to complete the remaining steps." %}

### Removing the App settings

All those engines yml files were including [the `tk-multi-publish2.yml`](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-multi-publish2.yml) settings file. Now that you have removed reference to it in your engine ymls you can remove this file entirely.

{% include warning title="Important" content="If you remove the `tk-multi-publish2.yml` but still have engine files pointing at it then you will likely get an error along the lines of this: 

    Error
    Include resolve error in '/configs/my_project/env/./includes/settings/tk-desktop2.yml': './tk-multi-publish2.yml' resolved to '/configs/my_project/env/./includes/settings/./tk-multi-publish2.yml' which does not exist!
" %}

### Removing the App Location

All the apps store their location descriptor in the [.../env/includes/app_locations.yml](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/app_locations.yml) file. The `tk-multi-publish2.yml` referenced this so you would need to remove the [the descriptor lines](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/app_locations.yml#L52-L56).