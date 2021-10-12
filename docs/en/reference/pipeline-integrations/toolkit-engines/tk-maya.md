---
layout: default
title: Maya
pagename: tk-maya
lang: en
---

# Maya

The {% include product %} engine for Maya contains a standard platform for integrating {% include product %} Apps into Maya. It is lightweight and straight forward and adds a {% include product %} menu to the Maya menu bar.

![Engine](../images/engines/maya_menu.png)

## Supported Application Versions

This item has been tested and is known to be working on the following application versions: 

{% include tk-maya %}

Please note that it is perfectly possible, even likely, that it will work with more recent releases, however it has not yet been formally tested with these versions.

## Pyside

The {% include product %} engine for Maya contains a PySide installation, and will activate this whenever this is necessary.

## Maya Project Management

Whenever the {% include product %} engine for Maya starts, it will set the Maya Project to point at a location defined in the settings for this engine. This means that the Project may also change when a new file is opened. The details relating to how the maya project is set based on a file can be configured in the configuration file, using the template system.

## Installation and Updates

Adding this Engine to the {% include product %} Pipeline Toolkit
If you want to add this engine to Project XYZ, and an environment named asset, execute the following command:

```
> tank Project XYZ install_engine asset tk-maya
```

### Updating to the latest version

If you already have this item installed in a project and you want to get the latest version, you can run the `update` command. You can either navigate to the tank command that comes with that specific project, and run it there:

```
> cd /my_tank_configs/project_xyz
> ./tank updates
```

Alternatively, you can run your studio tank command and specify the project name to tell it which project to run the update check for:

```
> tank Project XYZ updates
```

## Collaboration and Evolution

If you have access to the {% include product %} Pipeline Toolkit, you also have access to the source code for all apps, engines and frameworks in Github where we store and manage them. Feel free to evolve these items; use them as a base for further independent development, make changes (and submit pull requests back to us!) or simply tinker with them to see how they have been built and how the toolkit works. You can access this code repository at https://github.com/shotgunsoftware/tk-maya.





