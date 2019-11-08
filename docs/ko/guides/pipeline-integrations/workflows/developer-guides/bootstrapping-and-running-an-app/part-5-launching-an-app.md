---
layout: default
title: Part 4 Launching an app
pagename: part-4-launching-an-app
lang: ko
---

# Part 5 - Launching an app

Now you have an engine instance, your ready to start using the Toolkit API.

Before moving onto launching the app, it's worth pointing out you can get hold of the [current context](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Engine.context), [Sgtk instance](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Engine.sgtk), and [Shotgun API instance](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Engine.shotgun) via the engine.

```python
engine.context
engine.sgtk
engine.shotgun
```
With these you could instead of launching an app, test code snippets, or run some automation requiring the Toolkit API.

## Launching the App

When the engine starts, it initializes all the apps defined for the environment. 
The apps in turn register commands with the engine, and the engine usually displays these as actions in a menu, 
if running a Software like Maya.

### Finding the commands
To first see what commands have been registered you can print our the [`engine.commands`](https://developer.shotgunsoftware.com/tk-core/platform.html#sgtk.platform.Engine.commands)

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

With that list you can see which commands have been registered and can be run.

### Running the command

How you run the command will be different depending on the engine, as there is currently no standardized method.
For the `tk-shell` engine you can use `engine.execute_command` which expects a command string name, which we listed out earlier,
 and a list of parameters that the app's command expects to be passed.

```python
if "Publish..." in engine.commands:
    # Launch the Publish app, and it doesn't require any arguments to run so provide an empty list.
    engine.execute_command("Publish...",[])
```

If your not running in the `tk-shell` engine, then you can call the registered callback directly.

```python
# now find the command we specifically want to execute
app_command = engine.commands.get("Publish...")

if app_command:
    # now run the command, which in this case will launch the Work Area Info app.
    app_command["callback"]()
```

Your app should now have started, and if your running the `tk-shell` engine then the output should be appearing in the terminal/console.

[Overview](./sgtk-developer-bootstrapping.md)<br/>
[Previous step](part-4-bootstrapping.md)