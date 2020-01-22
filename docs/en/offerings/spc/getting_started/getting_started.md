---
layout: default
title: Getting Started
pagename: spc-getting_started
lang: en
---

# Getting Started with Shotgun Private Cloud

## Introduction

At the heart of a Toolkit pipeline is the environment configuration. Within a Toolkit pipeline configuration, the environment configuration files are where you define which Toolkit apps are available within different DCCs and customize the settings for each. This document is a complete reference to the structure and function of the environment configuration files. It covers the Toolkit concept of *environments* for configuring different workflows within a project, configuration structure, file referencing, and ways to discover what customizations are available.

{% include info title="Note" content="While this document acts as a reference to the environment configuration files, you can  see a step-by-step example of editing a configuration setting in the [Toolkit Basics Guide on Editing a pipeline configuration](./learning-resources/guides/editing_app_setting.md)." %}

## What is an environment?

The Shotgun Toolkit platform provides a fully customizable set of integrations for commonly used content creation software with which you can build your studio pipeline. Within a project’s configuration, you can specify which software packages have integrations, which specific Toolkit apps are available in each, and your options for each app&mdash;building out artists workflows to suit your studio’s needs.

But often in studio pipelines, it’s common for different types of artists to have different workflows. As a simple example, for artists working on assets, you might want to make texture painting software such as Mari available, whereas for artists working on shots, you might want to make compositing software such as Nuke available. 

Beyond just software packages, you might have different settings for the same Toolkit app for different artists. For example, both shot artists and asset artists might use the [Workfiles app](https://support.shotgunsoftware.com/hc/en-us/articles/219033088), but you might want to limit the file navigation to files associated with Shot entities for the former and Asset entities for the latter. 

To support these different workflows within a project, Toolkit divides its app and engine configurations across environments. An environment contains the integrations and their settings for a set of software packages, all with a certain context in common. 

In the above example, artists working on assets would be working in an asset step environment, whereas artists working on shots would be working in a shot step environment. Each environment is configured independent of any others, allowing you to have distinct workflows within a project. 

## A note on Toolkit’s Default Configuration

Toolkit gives you a lot of freedom in the way you structure your environment configuration. This document is a reference for all of the options that are available to you, so that you’ll have the necessary knowledge to make choices that best suit the needs of your pipeline. 

This document will also occasionally cover some of the specific choices we’ve made in the pipeline configuration provided as a starting point, known as [the Default Configuration](https://github.com/shotgunsoftware/tk-config-default2). When you’re ready to customize your pipeline, the first step is to [create an editable pipeline configuration for your project](./learning-resources/guides/editing_app_setting.md). 

While these choices are only conventions and not hardcoded into the Toolkit workflow, it’s helpful to refer to the Default Configuration as an example for learning what features are available once you start customizing your pipeline and best practices for structuring your own configurations. And, since it's the suggested starting point for new Toolkit users, it’s helpful to know some of its conventions. We will always distinguish between general features of the Toolkit environment configuration and specific choices in the Default Configuration in this document. For specific details on the Default Configuration’s environment structure, see [its README file](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/README.md).

## File locations 

Within your Pipeline Configuration, the `config/` directory contains all the files and folders that are meant to be customized. In `config/`, you’ll find three sub-directories: `cache`, `core`, and `env`. The `env` directory holds the environment configuration files, so this document will refer to the files in `config/env`.

![env Folder Contents](./images/env_config_ref/1.png)

In the Default Configuration, you’ll see the following files in `config/env/`:

```
asset.yml
asset_step.yml
project.yml
sequence.yml
shot.yml
shot_step.yml
```

Each of these files corresponds to an environment; having separate files allows each environment to be configured separately.

## How Toolkit determines the current environment

Toolkit uses a core hook called [pick_environment](https://github.com/shotgunsoftware/tk-core/blob/master/hooks/pick_environment.py) to determine which environment file to use at a given time based on the current [context](https://developer.shotgunsoftware.com/tk-core/core.html#context). The `pick_environment` hook’s return values correspond to environment configuration files. For example, if `pick_environment` returns `shot_step`, Toolkit will use `config/env/shot_step.yml` to configure the Toolkit environment.

## Custom environments

The environment configuration files listed above are the ones provided with the Default Configuration. However, some studios may want to employ different or additional environments. For example, a studio might want different configuration settings for every stage in the pipeline&mdash;`asset_step_rig`, `asset_step_model`, `shot_step_anim`, `shot_step_light`, and so on. Fortunately, you can fully customize the available environments. 

To do so, add the desired environment config files to the `config/env` directory. Then, override the `pick_environment` core hook, adding to it the logic that defines when to use your new environments. 

## Basic structure

Toolkit’s configuration files are written in [YAML](https://yaml.org/). The general configuration structure for any bundle (an app, engine, or framework) is as follows:

```yaml
bundle_name:
  setting1: value
  setting2: value
  complex_setting:
    sub_setting1: value  
    Sub_setting2: value
  location: 
    type: descriptor_type
    descriptor_setting1: value
    descriptor_setting2: value
```

To demonstrate this structure, here is a very simple example: an environment in which there is a single engine, with a single app defined within it. The following might be the contents of `project.yml` in this config:

```yaml
engines:
  tk-maya:
    apps:
      tk-multi-workfiles2:
        location:
          type: app_store
          name: tk-multi-workfiles2
          version: v0.11.8
    location:
        type: app_store
        name: tk-maya
        version: v0.9.4
```

### The engines block

Every environment configuration file starts with an `engines` block. Nested within it are all of the engines defined for that environment.

In our example, only a single engine is defined, `tk-maya`. It has two settings listed, `apps` and `location`. 

`location` is a special setting that every bundle requires. The `apps` setting is a list of all the apps defined for the engine, each with its own settings. In this case, only one app is defined for the engine, `tk-multi-workfiles2`. 


### The location descriptor

Every Toolkit bundle has a `location` setting, which we refer to as the bundle’s *descriptor*. The descriptor tells Toolkit where to find the given bundle, and depending on its type, whether to access it directly or cache it locally. Some examples of locations that a Toolkit bundle can come from are the Shotgun App Store, a git repository, a path on disk, or a zip file uploaded to your Shotgun site. Each of these has a corresponding descriptor type, with settings specific to that type. Here again is the descriptor for the `tk-maya` engine from the example above:

```yaml
    location:
        type: app_store
        name: tk-maya
        version: v0.9.4
```

This is a descriptor of type `app_store`, which tells Toolkit to get the given bundle from the Shotgun App Store. Descriptors of type `app_store` have the settings `name` and `version`. 

In contrast, if you are actively developing a custom bundle&mdash;say you’re working on writing a Toolkit app for a specific workflow in your studio, you may want to get it directly from a path on disk. In this case you’d use a descriptor of type `dev`, which might look like this: 

```yaml
    location:
        type: dev
        path: /path/to/app
```

The `dev` descriptor has different settings from the `app_store` descriptor. While it can take other settings, it can be set up simply with a `path` setting pointing to where the app lives on disk.

See [the Descriptor section of the Toolkit Core API docs](https://developer.shotgunsoftware.com/tk-core/descriptor.html) for details on all available descriptor types and their settings.

### The apps block

Apps are Toolkit’s user tools, and each can run independently of any others. You can choose which apps you want to use based on your pipeline needs, and the `apps` setting within an engine block is where you define which apps are available in a given engine.

Here again is the `apps` setting from our example above:

```yaml
engines:
  tk-maya:
    apps:
      tk-multi-workfiles2:
        location:
          type: app_store
          name: tk-multi-workfiles2
          version: v0.11.8
```

You can see that we have a single app defined, the `tk-multi-workfiles2` app. It currently only has a single setting defined:  its descriptor.

If you wanted to make other apps available in the `tk-maya` engine in the `project` environment, you’d add them here. Let’s add the Panel, `tk-multi-shotgunpanel`, and the About app, `tk-multi-about`, to our engine. Our example `project.yml` file now looks like this:

```yaml
engines:
  tk-maya:
    apps:
      tk-multi-about:
        location:
          type: app_store
          name: tk-multi-about
          version: v0.2.8
      tk-multi-shotgunpanel:
        location:
          type: app_store
          name: tk-multi-shotgunpanel
          version: v1.6.3
      tk-multi-workfiles2:
        location:
          type: app_store
          name: tk-multi-workfiles2
          version: v0.11.8
    location:
        type: app_store
        name: tk-maya
        version: v0.9.4
```

There are a few important things to note at this time: 

* The Default Config lists bundles in alphabetical order, and this example follows that convention.
* The file is beginning to get long, and we haven’t even added any configuration settings yet. 
* You might imagine that you’ll be using these same apps in other engines and other environments. For example, you’ll probably have all three of these apps&mdash;the Panel, the About app, and the Workfiles app&mdash;in different engines (say, Houdini, Nuke, or Photoshop), and in different environments (like `asset_step` or `shot_step`). Defining common app settings in many places in your config means that when it comes time to make a change, you’ll have to make the modification in many places.

To mitigate the last two issues, Toolkit configurations support *includes*.

### Includes

*Includes* allow you to reference a section of one file in another file in your configuration. Using includes allows you set a configuration setting in one place, but use it in multiple environments. 

Includes consist of two parts:

* The `includes` list: a YAML dictionary whose key is `includes`, and whose value is a list of all files we want to include from. 
* A reference within your configuration settings, prefixed by the `@` symbol, and named to point to the name of the section you want to reference from the included file. 

To flesh out our above example, you might have a single file where you hold the location descriptors for all of your engines. Let’s put that file in an `includes` subfolder, and call it `engine_locations.yml`. 

The contents of `engine_locations.yml` would look like this:

`config/env/includes/engine_locations.yml`:

```yaml
engines.tk-maya.location:
  type: app_store
  name: tk-maya
  version: v0.9.4

engines.tk-nuke.location:
  type: app_store
  name: tk-nuke
  version: v0.11.5

...
```

This file can act as a single source for all engine locations, and all of your environment configurations can reference it. Using this include file, our example now looks like this:

`config/env/project.yml`:

```yaml
includes:
- includes/engine_locations.yml

engines:
  tk-maya:
    apps:
      tk-multi-about:
        location:
          type: app_store
          name: tk-multi-about
          version: v0.2.8
      tk-multi-shotgunpanel:
        location:
          type: app_store
          name: tk-multi-shotgunpanel
          version: v1.6.3
      tk-multi-workfiles2:
        location:
          type: app_store
          name: tk-multi-workfiles2
          version: v0.11.8
    location: @engines.tk-maya.location
```

![engine_locations include file](./images/env_config_ref/2.png)

You can see here that the value of the `location` setting for the `tk-maya` engine is now a reference to a key from the included YAML file. 

{% include info title="Note" content="Having all engine locations in a `config/env/includes/engine_locations.yml` file, as we do in this example, follows the convention of the Default Configuration." %}

You can add a second include file for app locations, and in fact, the Default Configuration does just that. Let’s expand our example:

`config/env/includes/app_locations.yml:`

```yaml
apps.tk-multi-about.location:
  type: app_store
  name: tk-multi-about
  version: v0.2.8

apps.tk-multi-shotgunpanel.location:
  type: app_store
  name: tk-multi-shotgunpanel
  version: v1.6.3

apps.tk-multi-workfiles2.location:
  type: app_store
  name: tk-multi-workfiles2
  version: v0.11.8
```


`config/env/project.yml`:

```yaml
includes:
- includes/app_locations.yml
- includes/engine_locations.yml

engines:
  tk-maya:
    apps:
      tk-multi-about:
        location: @apps.tk-multi-about.location
      tk-multi-shotgunpanel:
        location: @apps.tk-multi-about.shotgunpanel.location
      tk-multi-workfiles2:
        location: @apps.tk-multi-workfiles2.location
    location: @engines.tk-maya.location
```

We’re now getting the `tk-maya` engine’s descriptor from the included `engine_locations.yml` file, and the descriptor for each app defined for the `tk-maya` engine from the included `app_locations.yml` file.

{% include info title="Note" content="The Default Configuration employs a second level of nesting that’s not demonstrated here. Every app or engine that has settings beyond just a descriptor has a settings file in `includes/settings` (e.g., `includes/settings/tk-maya.yml`, `includes/settings/tk-multi-workfiles2.yml`). The engine settings files include app settings from the app settings files, and the environment configuration files include from the engine settings files. For details on the Default Configuration’s structure, see [its README file](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/README.md). For a detailed walkthrough of modifying a configuration setting, see the [Toolkit Basics Guide on Editing a Configuration Setting](./learning-resources/guides/editing_app_setting.md)." %}


## Sparse configurations

Every Toolkit bundle has a set of available configuration settings, with a default value for each. Toolkit allows *sparse* configurations: if a configuration setting is not explicitly specified in the environment config files (and/or the files they include), then the default value from the bundle will be used. 

In our example, we haven’t specified any settings for our apps aside from `location`. So, in our configuration’s current state, our three apps will use the default values for all of their settings. So, how do we know what configuration settings are available?

{% include info title="Note" content="While it’s not a requirement that Toolkit configurations be sparse, the Default Configuration is a sparse configuration." %}

## Discovering available configuration settings

With sparse configurations, it’s not immediately evident what configuration settings are available for an app simply by looking at your configuration files. To find out what configuration settings an app has available, you have two choices:

* **App documentation:** Each of our apps has its own documentation page, and each of these pages has a “Configuration Options” section. This section lists all of the available configuration settings for the app, with description and default values for each. You can [see the Workfiles documentation page](https://support.shotgunsoftware.com/hc/en-us/articles/219033088) as an example. The [Apps and Engines page](https://support.shotgunsoftware.com/hc/en-us/articles/219033088) lists the documentation pages for all apps and engines. 
* **The manifest:** Every Toolkit bundle includes a file called `info.yml` in its root directory. We refer to this file as the bundle’s *manifest*, and it defines all of the available configuration settings for the bundle, with a description and default value for each. You can find the manifest in your own cache of the bundle (e.g., `install/app_store/tk-multi-workfiles2/v0.11.8/info.yml` within your pipeline configuration), or in Github ([here it is for Workfiles as an example](https://github.com/shotgunsoftware/tk-multi-workfiles2/blob/master/info.yml)).

## Modifying configuration settings 

To modify a configuration from the default value, simply add it to the proper block, in the proper environment in your Pipeline Configuration, and set its value. 

Going back to our example, let’s say that we want to configure `tk-multi-workfiles2` so that it launches automatically when Maya is launched in the project environment. We can see [in the app’s manifest](https://github.com/shotgunsoftware/tk-multi-workfiles2/blob/v0.11.10/info.yml#L19-L25) that there is a `launch_at_startup` setting that controls whether to launch the Workfiles UI at application startup time, and that its default value is `False`. So, we’ll just add the `launch_at_startup` option, and set it to `True`. Our `project.yml` file now looks like this:

`config/env/project.yml`:

```yaml
includes:
- includes/app_locations.yml
- includes/engine_locations.yml

engines:
  tk-maya:
    apps:
      tk-multi-about:
        location: @apps.tk-multi-about.location
      tk-multi-shotgunpanel:
        location: @apps.tk-multi-about.shotgunpanel.location
      tk-multi-workfiles2:
        launch_at_startup: True
        location: @apps.tk-multi-workfiles2.location
    location: @engines.tk-maya.location
```

Note that if the settings for `tk-multi-workfiles2` were coming from an included file, we’d make this change in that file.


## Additional resources

* [Toolkit Basics Guide: Editing a pipeline configuration](./learning-resources/guides/editing_app_setting.md)
* [Toolkit Basics Guide: Adding an app](./learning-resources/guides/installing_app.md)
* [Animation pipeline tutorial](./learning-resources/tutorial.md)
* [Descriptor reference documentation](https://developer.shotgunsoftware.com/tk-core/descriptor.html#descriptors)
* [Webinar: Toolkit administration](https://youtu.be/7qZfy7KXXX0)
* [File system configuration reference](https://support.shotgunsoftware.com/hc/en-us/articles/219039868-Integrations-File-System-Reference)
* [Default Configuration environment structure README](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/README.md)
