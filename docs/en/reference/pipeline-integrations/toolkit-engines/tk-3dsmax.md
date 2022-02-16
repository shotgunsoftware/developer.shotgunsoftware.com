---
layout: default
title: 3ds Max
pagename: tk-3dsmax
lang: en
---

# 3dsMax

The {% include product %} engine for 3dsMax contains a standard platform for integrating {% include product %} Toolkit (Sgtk) Apps into 3dsMax. It is light weight, straight forward and adds a {% include product %} menu to the main menu.

![Engine](../images/engines/3dsmax_engine.png)

## Supported Application Versions

This item has been tested and is known to be working on the following application versions: 

{% include tk-3dsmax %}

## Documenation

The {% include product %} engine for 3dsMax contains a standard platform for integrating {% include product %} Pipeline Toolkit (Sgtk) Apps into 3dsMax. It is light weight, straight forward and adds a {% include product %} menu to the main menu.

## Installation and Updates

### Adding this Engine to the {% include product %} Pipeline Toolkit

If you want to add this engine to Project XYZ, and an environment named asset, execute the following command:

```
> tank Project XYZ install_engine asset tk-3dsmax
```

### Updating to the latest version

If you already have this item installed in a project and you want to get the latest version, you can run the update command. You can either navigate to the tank command that comes with that specific project, and run it there:

```
> cd /my_tank_configs/project_xyz
> ./tank updates
```

Alternatively, you can run your studio tank command and specify the project name to tell it which project to run the update check for:

```
> tank Project XYZ updates
```
## Collaboration and Evolution

If you have access to the {% include product %} Pipeline Toolkit, you also have access to the source code for all apps, engines and frameworks in Github where we store and manage them. Feel free to evolve these items; use them as a base for further independent development, make changes (and submit pull requests back to us!) or simply tinker with them to see how they have been built and how the toolkit works. You can access this code repository at https://github.com/shotgunsoftware/tk-3dsmax.

## Special Requirements

You need {% include product %} Pipeline Toolkit Core API version v0.19.18 or higher to use this.
