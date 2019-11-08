---
layout: default
title: Part 3 - How to bootstrap an engine
pagename: part-3-bootstrapping
lang: en
---

# Part 3 - Bootstrapping an engine

[Overview](./sgtk-developer-bootstrapping.md)<br/>
[Previous step](./part-2-authentication.md)

Now you have an authenticated sgtk API, you can start the bootstrapping process.
You can find a lot of information on the bootstrap API in our [reference docs](https://developer.shotgunsoftware.com/tk-core/initializing.html#bootstrap-api).

The bootstrapping process at a high level essentially performs the following steps:

1. Gets the configuration to use.
2. Ensures that the configuration dependencies such as the apps and engines are present in the bundle cache. 
If they are not present, and they are using cloud based descriptors such as app store, or Shotgun then it will download them to the bundle cache.
3. Swaps out the current loaded sgtk core for the one appropriate to the config.
4. Initializes the engine, apps and frameworks.


{% include info title="Note" content="Usually bootstrapping should take care of everything that is needed for that engine to run successfully.
However, in some situations, the engine may have specific setup requirements that fall outside of the bootstrap process, and must be handled separately." %}


## Bootstrap Preperation
To bootstrap you must first create a `ToolkitManager` instance.

```python
mgr = sgtk.bootstrap.ToolkitManager()
```

In order for Toolkit to bootstrap, it needs to know at least the entity, plugin id, and engine.
This guide wont cover all the available parameters and options, as that's covered in the [reference documentation](https://developer.shotgunsoftware.com/tk-core/initializing.html#bootstrap-api).

#### Plugin ID

You can define the plugin id by passing a string to the `ToolkitManager.plugin_id` parameter prior to calling the bootstrap method.
In this guide you will be bootstrapping the `tk-shell` engine so you should provide a suitable plugin id name following the conventions described in the reference docs. 
```python
mgr.plugin_id = "basic.shell"
```

#### Engine
If your goal is to launch an app or run Toolkit code in a standalone python environment out side of a software such as Maya or Nuke, 
then `tk-shell` is the engine you will want to bootstrap into. 

If you are wanting to run Toolkit apps within a supported Software then you will want to pick the appropriate engine, such as `tk-maya` or `tk-nuke`.
This parameter is passed directly to the `bootstrap_engine` method.

```python
engine = mgr.bootstrap_engine("tk-shell", ...
```

#### Entity
The entity can be of any entity type that the configuration is setup to work with. 
For example if you provide a `Project` entity, the engine will start up in a project context, using the project environment settings.
Like wise you could provide a `Task` entity (where the task is linked to an `Asset`), and it will start up using the asset_step environment.

You need to provide the entity in the format of a Shotgun entity dictionary which must contain at least the type and id: 

```python
task = {"type": "Task", "id": 17264}
engine = mgr.bootstrap_engine("tk-shell", entity=task)
```

# TODO: mention the perils of path cache not being sync'd and trying to load contexts other than Project. Mention callback to run sync during bootstrap.

#### Choice of configuration

You have the choice of explicitly defining which configuration to bootstrap, or leaving the bootstrap logic to [autodetect an appropriate configuration](https://developer.shotgunsoftware.com/tk-core/initializing.html#managing-distributed-configurations).
You can even set a fall back configuration in case one is not automatically found.
In this guide we assume that your project has a configuration already setup and that it will be found automatically. 

## Bootstrapping

Once all the `ToolkitManager` parameters have been set, and you call the `bootstrap_engine` engine method, it will start the
engine, and return back a pointer to the engine instance.

Here is a recap of the code so far:

```python
# Import Toolkit so we can access to Toolkit specific features.
import sgtk

# Authentication
################

# Import the ShotgunAuthenticator from the tank_vendor.shotgun_authentication
# module. This class allows you to authenticate either interactively or, in this
# case, programmatically.
from tank_vendor.shotgun_authentication import ShotgunAuthenticator

# Instantiate the CoreDefaultsManager. This allows the ShotgunAuthenticator to
# retrieve the site, proxy and optional script_user credentials from shotgun.yml
cdm = sgtk.util.CoreDefaultsManager()

# Instantiate the authenticator object, passing in the defaults manager.
authenticator = ShotgunAuthenticator(cdm)

# Create a user programmatically using the script's key.
user = authenticator.create_script_user(
 api_script="Script Name",
 api_key="4e48f....<use the key from your Shotgun site>"
)

# Tells Toolkit which user to use for connecting to Shotgun.
sgtk.set_authenticated_user(user)

# Bootstrap
###########

# create an instance of the ToolkitManager which we will use to set a bunch of settings before initiating the bootstrap. 
mgr = sgtk.bootstrap.ToolkitManager()
mgr.plugin_id = "basic.shell"

project = {"type": "Project", "id": 176}

engine = mgr.bootstrap_engine("tk-shell", entity=project)
```

# TODO: maybe move this to it's own section? 
Enabling Debug
```python
# initialize the logger so we get output to our terminal
sgtk.LogManager().initialize_custom_handler()
# set debugging to true
sgtk.LogManager().global_debug = True
```

Next step [launching an app](part-4-launching-an-app.md).