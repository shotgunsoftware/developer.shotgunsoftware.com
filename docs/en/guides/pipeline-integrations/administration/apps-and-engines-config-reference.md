---
layout: default
title: Apps and Engines Configuration Reference
pagename: toolkit-apps-and-engines-config-ref
lang: en
---

# Apps and Engines Configuration Reference

This document contains an overview of all the different options that you can include when creating configurations for Apps, Engines and Frameworks in the {% include product %} Pipeline Toolkit. It can be useful when doing advanced configuration of Apps, and it is important when you are doing development and need to add parameters to your App Configuration Manifest.  

_This document describes functionality only available if you have taken control over a Toolkit configuration. For more info, see [{% include product %} Integrations Admin Guide](https://support.shotgunsoftware.com/hc/en-us/articles/115000067493)._

# Introduction

This document contains specifications for the various file formats that Sgtk uses for its configuration and settings. Please note that this is a reference document which outlines all the various options and parameters available. For best practices on how to manage your configuration, please see the following document:

[Configuration Management best practices.](https://support.shotgunsoftware.com/hc/en-us/articles/219033168)

# {% include product %} Pipeline Toolkit Environments

Three major components exists in Toolkit:

-   _An engine_ provides a translation layer or an adapter between a host application (such as Maya or Nuke) and Sgtk Apps. Apps typically use python and PySide, and it is the responsibility of the engine to present the host application in a standardized fashion and for example add pyside on top of the host application if this doesn't exist already.
-   _An app_ provides a piece of business logic, it is essentially a tool that does something. Apps can be hand crafted to work in a specific host application, or they can be designed to run in more than one host application.
-   _A framework_ is a library which can be used by engines, apps or other frameworks. A framework makes it possible to more easily manage code or behaviour which is shared between multiple apps.
    
An _environment file_ contains the configuration settings for a collection of engines, apps and frameworks. Such a collection is called an Environment. Sgtk launches different environments for different files or different people. You can for example have an environment for Shot production and environment for Rigging. Each environment is a single yaml file.

Environment files are located at `/<sgtk_root>/software/shotgun/<project_name>/config/env`

The yaml file has the following basic format:

```yaml
    engines:
        tk-maya:
            location
            engine settings
    
            apps:
                tk-maya-publish:
                    location
                    app settings
    
                tk-maya-revolver:
                    location
                    app settings
    
        tk-nuke:
            location
            engine settings
    
            apps:
                tk-nuke-setframerange:
                    location
                    app settings
    
                tk-nuke-nukepub:
                    location
                    app settings
    
    frameworks:
        tk-framework-tools:
            location
            framework settings
```

Each app and engine can be configured via settings. These settings correspond with the list of settings that the app/engine exposes in its manifest file called `info.yml`. As of `v0.18.x` of Sgtk Core, settings only need to be specified if they differ from the default values specified in the manifest file. In addition to the manifest file, the configurable settings can typically be found on the app/engine page within the Toolkit App Store.

In addition to the various settings that can be defined for each item, each app, engine and framework also needs to define where its code is located. This is done using a special `location` parameter.

## Code Locations

Each app, engine or framework defined in the environment file has got a `location` parameter which defines which version of the app to run and where to download it from. Most of the time this is handled automatically by the `tank updates` and `tank install` commands. However, if you are doing hand editing of configurations, a variety of options are available for you to help deploy and structure Toolkit:

Toolkit currently supports app installation and management using the following location _descriptors_:

-   An **app_store** descriptor represents an item in the Toolkit App Store
-   A **{% include product %}** descriptor represents an item stored in {% include product %}
-   A **git** descriptor represents a tag in a git repository
-   A **git_branch** descriptor represents a commit in a git branch
-   A **path** descriptor represents a location on disk
-   A **dev** descriptor represents a developer sandbox
-   A **manual** descriptor that is used for custom deployment and rollout

For documentation on how to use the different descriptors, please see the [Toolkit reference documentation](http://developer.shotgridsoftware.com/tk-core/descriptor.html#descriptor-types).

## Disabling Apps and Engines

Sometimes it can be useful to temporarily disable an app or an engine. The recommended way of doing this is to to add a `disabled: true` parameter to the location dictionary that specifies where the app or engine should be loaded from. This syntax is supported by all the different location types. It may look like this for example:

```yaml
location: {"type": "app_store", "name": "tk-nukepublish", "version": "v0.5.0", "disabled": true}
```

Alternatively, if you want an app to only run on certain platforms, you can specify this using the special `deny_platforms` setting:

```yaml
location: {"type": "app_store", "name": "tk-nukepublish", "version": "v0.5.0", "deny_platforms": [windows, linux]}
```

Possible values for the  _deny_platforms_  parameter are `windows`, `linux`, and `mac`.

## Settings and parameters

Each app, engine or framework explicitly defines a number of settings which you can override in the configuration file. These settings are strongly typed into strings, integers, lists, etc. For details, see the [Toolkit reference documentation](http://developer.shotgridsoftware.com/tk-core/platform.html#configuration-and-info-yml-manifest).
