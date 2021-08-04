---
layout: default
title: Mari
pagename: tk-mari
lang: en
---

# Mari

The {% include product %} engine for Mari contains a standard platform for integrating {% include product %} Toolkit Apps into Mari. It is light weight and straight forward and adds a {% include product %} menu to the main menu.

## Supported Application Versions

This item has been tested and is known to be working on the following application versions: 2.6 - 4.6. Please note that it is perfectly possible, even likely, that it will work with more recent releases, however it has not yet been formally tested with these versions.

## Overview Video

See the overview video [here](https://youtu.be/xIP7ChBWzrY).

## Installation and Updates

### Adding this Engine to the {% include product %} Pipeline Toolkit

If you want to add this engine to Project XYZ, and an environment named asset, execute the following command:

```
> tank Project XYZ install_engine asset tk-mari
```

### Updating to the latest version

If you already have this item installed in a project and you want to get the latest version, you can run the `update` command. You can either navigate to the tank command that comes with that specific project, and run it there:

```
> cd /my_tank_configs/project_xyz
> ./tank updates
```

Alternatively, you can run your studio `tank` command and specify the project name to tell it which project to run the update check for:

```
> tank Project XYZ updates
```

## Collaboration and Evolution

If you have access to the {% include product %} Pipeline Toolkit, you also have access to the source code for all apps, engines and {% include product %} in Github where we store and manage them. Feel free to evolve these items; use them as a base for further independent development, make changes (and submit pull requests back to us!) or simply tinker with them to see how they have been built and how the toolkit works. You can access this code repository at https://github.com/shotgunsoftware/tk-mari.





