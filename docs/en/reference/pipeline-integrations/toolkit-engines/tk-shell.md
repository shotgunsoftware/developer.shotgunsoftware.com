---
layout: default
title: Shell
pagename: tk-shell
lang: en
---

# Shell

The {% include product %} engine for the shell handles command line interaction and is tightly integrated with the `tank` command which is distributed as part of the Core API. When you execute the `tank` command in a terminal, Toolkit launches the engine to handle app execution.

For more information about the tank command, please see our [Advanced Toolkit Administration documentation](https://developer.shotgridsoftware.com/425b1da4/?title=Advanced+Toolkit+Administration#using-the-tank-command).

![Engine](../images/engines/sg_shell_1.png)

## Installation and Updates

### Adding this Engine to the {% include product %} Pipeline Toolkit

If you want to add this engine to Project XYZ, and an environment named asset, execute the following command:


```
> tank Project XYZ install_engine asset tk-shell
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
	
If you have access to the {% include product %} Pipeline Toolkit, you also have access to the source code for all apps, engines and frameworks in Github where we store and manage them. Feel free to evolve these items; use them as a base for further independent development, make changes (and submit pull requests back to us!) or simply tinker with them to see how they have been built and how the toolkit works. You can access this code repository at https://github.com/shotgunsoftware/tk-shell.