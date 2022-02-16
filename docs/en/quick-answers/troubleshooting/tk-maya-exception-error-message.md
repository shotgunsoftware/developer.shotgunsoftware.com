---
layout: default
title: Error {% include product %} tk-maya An exception was raised from Toolkit
pagename: tk-maya-exception-error-message
lang: en
---

# Error: {% include product %} tk-maya: An exception was raised from Toolkit

## Use case

It is possible for the Toolkit App to be set up to receive custom arguments when it is triggered to run.

For example, when you run an app, you may want to provide some kind of state flag which causes the app to launch differently depending on the state.

Here are a couple of examples of where this is already used:

- The `tk-shotgun-folders` app, (which creates folders based on the selected entities in the Shotgun web app,) will get passed the Shotgun entity/s and the entity type that the user selected in the Shotgun web app and ran the action on:
https://github.com/shotgunsoftware/tk-shotgun-folders/blob/v0.1.7/app.py#L86
- The `tk-multi-launchapp` (which is responsible for launching software with the Shotgun integrations) can be passed a `file_to_open` arg, which it will then use to open the file once the software is launched:
https://github.com/shotgunsoftware/tk-multi-launchapp/blob/v0.11.2/python/tk_multi_launchapp/base_launcher.py#L157
Normally when you launch the software through {% include product %} Desktop it won't provide a `file_to_open` argument, however, you can call the app via the tank command if you are using a centralized config (`tank maya_2019 /path/to/maya/file.mb`). 
Also our `tk-shotgun-launchpublish` app, in turn, launches the `tk-multi-launchapp` and provides the published file as the `file_to_open` arg.
https://github.com/shotgunsoftware/tk-shotgun-launchpublish/blob/v0.3.2/hooks/shotgun_launch_publish.py#L126-L133

## Programming your app to accept args

If you're [writing a custom app](https://developer.shotgridsoftware.com/2e5ed7bb/), all you need to do is set the callback method that gets registered with the engine to accept the args you need. 
Here is a simple app set up to require two args, accept any additional ones, and print them:

```python
from sgtk.platform import Application


class AnimalApp(Application):

    def init_app(self):
        self.engine.register_command("print_animal", self.run_method)

    def run_method(self, animal, age, *args):
        print ("",animal)
        print ("age",age)
        print ("args", args)
```

### Running from the tank command

Now if you run the following tank command in a shell:

```
 ./tank print_animal cat 7 Tortoiseshell large
```

it will result in the following being output:

```
...

----------------------------------------------------------------------
Command: Print animal
----------------------------------------------------------------------

libpng warning: iCCP: known incorrect sRGB profile
('animal', 'cat')
('age', '7')
('args', ('Tortoiseshell', 'large'))
```
### Running from a script

If you wanted to call your app from a script on the `tk-shell` engine you could do the following:

```python
# This assumes you have a reference to the `tk-shell` engine.
engine.execute_command("print_animal", ["dog", "3", "needs a bath"])
>>
# ('animal', 'dog')
# ('age', '3')
# ('args', ('needs a bath',))
```

if you were in Maya you would do something like:

```python
import sgtk

# get the engine we are currently running in.
engine = sgtk.platform.current_engine()
# Run the app.
engine.commands['print_animal']['callback']("unicorn",4,"it's soooo fluffy!!!!")

>>
# ('animal', 'unicorn')
# ('age', 4)
# ('args', ("it's soooo fluffy!!!!",))
```

## Error message

If you tried to launch the app from the menu in Maya you would get an error like this:

```
// Error: Shotgun tk-maya: An exception was raised from Toolkit
Traceback (most recent call last):
  File "/Users/philips1/Library/Caches/Shotgun/bundle_cache/app_store/tk-maya/v0.10.1/python/tk_maya/menu_generation.py", line 234, in _execute_within_exception_trap
    self.callback()
  File "/Users/philips1/Library/Caches/Shotgun/mysite/p89c1.basic.maya/cfg/install/core/python/tank/platform/engine.py", line 1082, in callback_wrapper
    return callback(*args, **kwargs)
TypeError: run_method() takes at least 3 arguments (1 given) // 
```

And that is because the app is set to require the arguments, and the menu button doesn't know to provide them. 

## How to fix

It is better to write your app's `run_method` to use keyword arguments like this:

```python
    def run_method(self, animal=None, age=None, *args):
        print ("",animal)
        print ("age",age)
        print ("args", args)
```
Then you can handle what happens if the args are not provided and implement a fallback behavior.

[See the full thread in the community](https://community.shotgridsoftware.com/t/custom-app-args/8893).

