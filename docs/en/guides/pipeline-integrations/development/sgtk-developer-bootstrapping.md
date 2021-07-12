---
layout: default
title: Bootstrapping and running an app
pagename: sgtk-developer-bootstrapping
lang: en
---

# Bootstrapping and running an app

This guide walks you through the process of initializing a Toolkit engine so that you can run custom code or launch apps, also known as bootstrapping.

Bootstrapping is useful in situations where a Toolkit engine has not already been started and you need to use the API.
For example, you might have a processing script that runs on a render farm and needs to utilize the Toolkit API to handle paths and context.
Or you may wish to be able to run your Toolkit app from your favorite IDE.

{% include info title="Note" content="If you are using a [distributed config](https://developer.shotgridsoftware.com/tk-core/initializing.html#distributed-configurations), a Toolkit engine must be initialized before running Toolkit API methods. It is possible to use the API without bootstrapping an engine if you are using a [centralized config](https://developer.shotgridsoftware.com/tk-core/initializing.html#centralized-configurations), using the [factory methods](https://developer.shotgridsoftware.com/tk-core/initializing.html#factory-methods), however, you will need to manually find the path to the correct core API for your project when importing `sgtk`." %}

### Requirements

- An understanding of Python programming fundamentals.
- A project with an advanced configuration. If you haven't set up a configuration before you can follow the ["Getting started with configurations"](../getting-started/advanced_config.md) guide.

### Steps

1. [Importing the Toolkit API for bootstrapping](#part-1-importing-the-toolkit-api-for-bootstrapping)
2. [Logging](#part-2-logging)
3. [Authentication](#part-3-authentication)
4. [Bootstrapping an engine](#part-4-bootstrapping-an-engine)
5. [launching an app](#part-5-launching-an-app)
6. [Complete script](#part-6-the-complete-script)

## Part 1: Importing the Toolkit API for bootstrapping

### Where should I import sgtk from?

If you've followed the ["generating a path and publishing it"](sgtk-developer-generating-path-and-publish.md) guide then you'll have covered the step of importing `sgtk`.
That guide states that you must import the `sgtk` package from the project configuration you wish to work with.
With bootstrapping, this is still true, however, it doesn't matter which initial `sgtk` package you import, as any Toolkit API can perform the bootstrap operation into a different project configuration.
The bootstrap process will swap out the currently imported sgtk package for the new project config's Toolkit API.

### Downloading a standalone Toolkit core API

To start, you need to import an `sgtk` API package which is found in [`tk-core`](https://github.com/shotgunsoftware/tk-core/tree/v0.18.172/python).
You could import one from an existing project, however, this might be tricky to conveniently locate.
A recommended approach would be to download a standalone copy
of the [latest core API](https://github.com/shotgunsoftware/tk-core/releases) which will be used purely for the purpose of bootstrapping.
You should store it in a convenient place where it can be imported.
Make sure that the path you add points to the `python` folder inside the `tk-core` folder as this is where the `sgtk` package is located.

### Code

```python
# If your sgtk package is not located in a location where Python will automatically look
# then add the path to sys.path.
import sys
sys.path.insert(0, "/path/to/tk-core/python")

import sgtk
```

## Part 2: Logging

If you are running this script via an IDE or shell, then you will most likely want to enable the logging to be output.
To do this you need to run [`LogManager().initialize_custom_handler()`](https://developer.shotgridsoftware.com/tk-core/utils.html#sgtk.log.LogManager.initialize_custom_handler).
You don't need to provide a custom handler for this purpose, as not providing one will set up a standard stream-based logging handler.

Optionally you can also set the [`LogManager().global_debug = True`](https://developer.shotgridsoftware.com/tk-core/utils.html#sgtk.log.LogManager.global_debug) to give you more verbose output.
This means that any `logger.debug()` calls in our code or yours will now be output.
Logging can have an impact on performance, so you should only enable debug logging when developing, and try to limit the amount of `logger.info()` method calls to those that are important to have visibility over during normal operation.

```python
import sgtk

# Initialize the logger so we get output to our terminal.
sgtk.LogManager().initialize_custom_handler()
# Set debugging to true so that we get more verbose output, (should only be used for testing).
sgtk.LogManager().global_debug = True
```

## Part 3: Authentication

When running a script that uses the Toolkit API outside of an environment where {% include product %} Toolkit has already been started, you will always need to authenticate.
So before you can perform the bootstrapping, you need to authenticate the Toolkit API with your {% include product %} site.

You can authenticate with user credentials or with script credentials.

- If the purpose is to bootstrap for a user-facing process like launching an app, or running some code that will require user input,
  then user authentication is the best way to go, (This is how all our integrations work by default).
- If you're writing a script to automate something and a user is not present to authenticate then you should use script credentials.

Authentication is handled via the [`{% include product %}Authenticator`](https://developer.shotgridsoftware.com/tk-core/authentication.html?highlight=shotgunauthenticator#sgtk.authentication.ShotgunAuthenticator) class.
Here is an example of both user and script authentication.

### User Authentication

```python
# Import Toolkit so we can access to Toolkit specific features.
import sgtk

# Instantiate the authenticator object.
authenticator = sgtk.authentication.ShotgunAuthenticator()

# Optionally you can clear any previously cached sessions. This will force you to enter credentials each time.
authenticator.clear_default_user()

# The user will be prompted for their username,
# password, and optional 2-factor authentication code. If a QApplication is
# available, a UI will pop-up. If not, the credentials will be prompted
# on the command line. The user object returned encapsulates the login
# information.
user = authenticator.get_user()

# Tells Toolkit which user to use for connecting to ShotGrid. Note that this should
# always take place before creating an `Sgtk` instance.
sgtk.set_authenticated_user(user)
```

### Script Authentication

```python
# Import Toolkit so we can access to Toolkit specific features.
import sgtk

# Instantiate the authenticator object.
authenticator = sgtk.authentication.ShotgunAuthenticator()

# Create a user programmatically using the script's key.
user = authenticator.create_script_user(
 api_script="Script Name",
 api_key="4e48f....<use the key from your ShotGrid site>",
 host="https://yoursite.shotgunstudio.com"
)

# Tells Toolkit which user to use for connecting to ShotGrid.
sgtk.set_authenticated_user(user)
```

## Part 4: Bootstrapping an engine

Now that you have authenticated the Toolkit API for the session, you can start the bootstrapping process.
You can find a lot of information on the bootstrap API in our [reference docs](https://developer.shotgridsoftware.com/tk-core/initializing.html#bootstrap-api).

The bootstrapping process at a high level essentially performs the following steps:

1. Retrieves or locates the Toolkit configuration folder.
2. Ensures that the configuration dependencies such as the apps and engines are present in the [bundle cache](../../../quick-answers/administering/where-is-my-cache.md#bundle-cache).
   If they are not present, and they are using cloud-based descriptors such as [`app_store`](https://developer.shotgridsoftware.com/tk-core/descriptor.html#the-shotgun-app-store), or [`{% include product %}`](https://developer.shotgridsoftware.com/tk-core/descriptor.html#pointing-at-a-file-attachment-in-shotgun) then it will download them to the bundle cache.
3. Swaps out the current loaded sgtk core for the one appropriate to the config.
4. Initializes the engine, apps, and frameworks.

{% include info title="Note" content="Usually bootstrapping should take care of everything that is needed for that engine to run successfully.
However, in some situations, the engine may have specific setup requirements that fall outside of the bootstrap process, and must be handled separately." %}

### Bootstrap Preparation

To bootstrap, you must first create a [`ToolkitManager`](https://developer.shotgridsoftware.com/tk-core/initializing.html#toolkitmanager) instance.

```python
mgr = sgtk.bootstrap.ToolkitManager()
```

For Toolkit to bootstrap, it needs to know at least the entity, plugin id, and engine.
This guide won't cover all the available parameters and options, as they are covered in the [reference documentation](https://developer.shotgridsoftware.com/tk-core/initializing.html#bootstrap-api).

#### Plugin ID

You can define the plugin id by passing a string to the `ToolkitManager.plugin_id` parameter before calling the bootstrap method.
In this guide, you will be bootstrapping the `tk-shell` engine so you should provide a suitable plugin id name following the conventions described in the reference docs.

```python
mgr.plugin_id = "basic.shell"
```

#### Engine

If your goal is to launch an app or run Toolkit code in a standalone python environment outside of software such as Maya or Nuke, then `tk-shell` is the engine you will want to bootstrap into.

If you are wanting to run Toolkit apps within supported Software, then you will want to pick the appropriate engine, such as `tk-maya` or `tk-nuke`.
This parameter is passed directly to the [`ToolkitManager.bootstrap_engine()`](https://developer.shotgridsoftware.com/tk-core/initializing.html#sgtk.bootstrap.ToolkitManager.bootstrap_engine) method. See the example in the [entity section](#entity) bellow.

#### Entity

The [`ToolkitManager.bootstrap_engine()`](https://developer.shotgridsoftware.com/tk-core/initializing.html#sgtk.bootstrap.ToolkitManager.bootstrap_engine) methods `entity` parameter, is used to set the [context](https://developer.shotgridsoftware.com/tk-core/core.html#context) and therefore [environment](https://developer.shotgridsoftware.com/tk-core/core.html?highlight=environment#module-pick_environment) for the launched engine.
The entity can be of any entity type that the configuration is set up to work with.
For example, if you provide a `Project` entity, the engine will start up in a project context, using the project environment settings.
Likewise, you could provide a `Task` entity (where the task is linked to an `Asset`), and it will start up using the `asset_step.yml` environment.
This is based on the default configuration behavior, [the environment that is chosen](https://developer.shotgridsoftware.com/487a9f2c/?title=Environment+Configuration+Reference#how-toolkit-determines-the-current-environment) is controlled via the core hook, [`pick_environment.py`](https://github.com/shotgunsoftware/tk-config-default2/blob/v1.2.11/core/hooks/pick_environment.py), and so could be changed to pick a different environment based on the context or other parameters.

You need to provide the entity in the format of a {% include product %} entity dictionary which must contain at least the type and id:

```python
task = {"type": "Task", "id": 17264}
engine = mgr.bootstrap_engine("tk-shell", entity=task)
```

If you bootstrap into an entity type other than `Project`, you may need to ensure your [path cache](https://developer.shotgridsoftware.com/cbbf99a4/) is in sync, otherwise, it may not be able to load the environment if, for example, it tries to resolve a template.
Since you don't have an `Sgtk` instance before bootstrapping, you will need to tell the bootstrap process to perform the synchronization after it's created an `Sgtk` instance but before it starts the engine.
You can do this by setting the [`ToolkitManager.pre_engine_start_callback`](https://developer.shotgridsoftware.com/tk-core/initializing.html#sgtk.bootstrap.ToolkitManager.pre_engine_start_callback) property to point to a custom method.
In that method you can then run the synchronization:

```python
def pre_engine_start_callback(ctx):
    '''
    Called before the engine is started.

    :param :class:"~sgtk.Context" ctx: Context into
        which the engine will be launched. This can also be used
        to access the Toolkit instance.
    '''
    ctx.sgtk.synchronize_filesystem_structure()

mgr.pre_engine_start_callback = pre_engine_start_callback
```

#### Choice of configuration

You have the choice of explicitly defining which configuration to bootstrap, or leaving the bootstrap logic to [autodetect an appropriate configuration](https://developer.shotgridsoftware.com/tk-core/initializing.html#managing-distributed-configurations).
You can even set a fallback configuration in case one is not automatically found.
In this guide, we assume that your project has a configuration already setup and that it will be found automatically.

### Bootstrapping

Once all the [`ToolkitManager`](https://developer.shotgridsoftware.com/tk-core/initializing.html#toolkitmanager) parameters have been set, and you call the [`ToolkitManager.bootstrap_engine()`](https://developer.shotgridsoftware.com/tk-core/initializing.html#sgtk.bootstrap.ToolkitManager.bootstrap_engine) method, it will start the engine, and return a pointer to the engine instance.

Here is a recap of the code so far:

```python
# Import Toolkit so we can access to Toolkit specific features.
import sgtk

# Initialize the logger so we get output to our terminal.
sgtk.LogManager().initialize_custom_handler()
# Set debugging to true so that we get more verbose output, (should only be used for testing).
sgtk.LogManager().global_debug = True

# Authentication
################

# Instantiate the authenticator object.
authenticator = sgtk.authentication.ShotgunAuthenticator()

# Create a user programmatically using the script's key.
user = authenticator.create_script_user(
 api_script="Script Name",
 api_key="4e48f....<use the key from your ShotGrid site>",
 host="https://yoursite.shotgunstudio.com"
)

# Tells Toolkit which user to use for connecting to ShotGrid.
sgtk.set_authenticated_user(user)

# Bootstrap
###########

# create an instance of the ToolkitManager which we will use to set a bunch of settings before initiating the bootstrap.
mgr = sgtk.bootstrap.ToolkitManager()
mgr.plugin_id = "basic.shell"

project = {"type": "Project", "id": 176}

engine = mgr.bootstrap_engine("tk-shell", entity=project)
```

## Part 5: Launching an app

Now that you have an engine instance, you're ready to start using the Toolkit API.

Before covering how to launch the app, it's worth pointing out you can get hold of the [current context](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.Engine.context), [Sgtk instance](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.Engine.sgtk), and [{% include product %} API instance](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.Engine.shotgun) via the engine.

```python
engine.context
engine.sgtk
engine.shotgun
```

Whilst the end goal of this guide is to show you how to launch an app, you could from this point make use of the above attributes and test some code snippets or run some automation that makes use of the Toolkit API.

### Launching the App

When the engine starts, it initializes all the apps defined for the environment.
The apps in turn register commands with the engine, and the engine usually displays these as actions in a menu, if running in Software like Maya.

#### Finding the commands

To first see what commands have been registered, you can print out the [`Engine.commands`](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.Engine.commands) property:

```python
# use pprint to give us a nicely formatted output.
import pprint
pprint.pprint(engine.commands.keys())

>> ['houdini_fx_17.5.360',
 'nukestudio_11.2v5',
 'nukestudio_11.3v2',
 'after_effects_cc_2019',
 'maya_2019',
 'maya_2018',
 'Jump to Screening Room Web Player',
 'Publish...',
...]
```

With that list, you can see which commands have been registered and can be run.

#### Running the command

How you run the command will be different depending on the engine, as there is currently no standardized method.
For the `tk-shell` engine, you can use the convenience method: `Engine.execute_command()`.
It expects a command string name, which we listed out earlier, and a list of parameters that the app's command expects to be passed.

```python
if "Publish..." in engine.commands:
    # Launch the Publish app, and it doesn't require any arguments to run so provide an empty list.
    engine.execute_command("Publish...",[])
```

If you're not running in the `tk-shell` engine, then you can fallback to calling the registered callback directly.

```python
# now find the command we specifically want to execute
app_command = engine.commands.get("Publish...")

if app_command:
    # now run the command, which in this case will launch the Publish app.
    app_command["callback"]()
```

Your app should now have started, and if you're running the `tk-shell` engine then the output should be appearing in the terminal/console.

## Part 6: The complete script

```python
# Import Toolkit so we can access to Toolkit specific features.
import sgtk

# Initialize the logger so we get output to our terminal
sgtk.LogManager().initialize_custom_handler()
# Set debugging to true so that we get more verbose output, (should only be used for testing)
sgtk.LogManager().global_debug = True

# Authentication
################

# Instantiate the authenticator object.
authenticator = sgtk.authentication.ShotgunAuthenticator()

# Create a user programmatically using the script's key.
user = authenticator.create_script_user(
 api_script="Script Name",
 api_key="4e48f....<use the key from your ShotGrid site>",
 host="https://yoursite.shotgunstudio.com"
)

# Tells Toolkit which user to use for connecting to ShotGrid.
sgtk.set_authenticated_user(user)

# Bootstrap
###########

# create an instance of the ToolkitManager which we will use to set a bunch of settings before initiating the bootstrap.
mgr = sgtk.bootstrap.ToolkitManager()
mgr.plugin_id = "basic.shell"

project = {"type": "Project", "id": 176}

engine = mgr.bootstrap_engine("tk-shell", entity=project)

# Optionally print out the list of registered commands:
# use pprint to give us a nicely formatted output.
# import pprint
# pprint.pprint(engine.commands.keys())

if "Publish..." in engine.commands:
    # Launch the Publish app, and it doesn't require any arguments to run so provide an empty list.
    engine.execute_command("Publish...",[])
```
