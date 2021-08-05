---
layout: default
title: ShotGrid
pagename: tk-shotgun
lang: en
---

# {% include product %}

![Engine](../images/engines/sg_shotgrid_engine_1.png)

The {% include product %} engine manages apps that can be launched from within {% include product %}. Sometimes we refer to these Toolkit Apps as *Actions*. They typically appear as items on menus inside of {% include product %}.

## Using {% include product %} Pipeline Toolkit Actions

Actions are visible on the {% include product %} Home page:

![action1](../images/engines/shotgun-action1.png)

They can also be found on the standard {% include product %} context menu, which can be shown by right clicking
on an object or a selection:

![action1](../images/engines/shotgun-action2.png)

When you click on an action, processing will immediately start. Once the app has completed, a message is typically displayed with some status information, or an error message if things didn't work.

## Developing Apps for {% include product %}

Developing apps that run inside of {% include product %} is easy! If you are not familiar with how app development works in general, head over to the Platform documentation and read the introductory material over there. In this section we will just cover the {% include product %} specific aspects of the app development process!

As of Core v0.13, you can use all the multi apps with the {% include product %} Engine. Technically speaking there is little difference between the {% include product %} engine and other engines. There are, however, some subtle differences:

* You will need to manually install PySide or PyQt into your standard python environment if you want to 
  execute QT based apps in the {% include product %} Engine.
* It is possible in the {% include product %} engine to make an action visible to a user depending on which 
  permissions group they belong to. This is useful if you want example want to add a command to 
  the {% include product %} Action menu and you only want admins to see it.

A hello-world style {% include product %} App, only visible to admins, would look something like this:

```python
from tank.platform import Application

class LaunchPublish(Application):
    
    def init_app(self):
        """
        Register menu items with {% include product %}
        """        
        params = {
            "title": "Hello, World!",
            "deny_permissions": ["Artist"],
        }
        
        self.engine.register_command("hello_world_cmd", self.do_stuff, params)
        

    def do_stuff(self, entity_type, entity_ids):
        # this message will be displayed to the user
        self.engine.log_info("Hello, World!")    
```

## Installation and Updates

### Adding this Engine to the {% include product %} Pipeline Toolkit

If you want to add this engine to Project XYZ, and an environment named asset, execute the following command:

```
> tank Project XYZ install_engine asset tk-shotgun
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
	
If you have access to the {% include product %} Pipeline Toolkit, you also have access to the source code for all apps, engines and frameworks in Github where we store and manage them. Feel free to evolve these items; use them as a base for further independent development, make changes (and submit pull requests back to us!) or simply tinker with them to see how they have been built and how the toolkit works. You can access this code repository at https://github.com/shotgunsoftware/tk-shotgun.

## Special Requirements

You need {% include product %} Pipeline Toolkit Core API version v0.19.5 or higher to use this.