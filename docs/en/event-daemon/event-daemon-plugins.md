---
layout: default
title: Plugins
pagename: event-daemon-plugins
lang: en
---

# Plugins Overview

A plugin file is any *.py* file in a plugin path as specified in the config file.

There are some example plugins provided in the `src/examplePlugins` folder in your download of the code. These provide simple examples of how to build your own plugins to look for specific events generated, and act on them, changing other values on your {% include product %} instance.

You do not need to restart the daemon each time you make updates to a plugin, the daemon will detect that the plugin has been updated and reload it automatically. 

If a plugin generates an error, it will not cause the daemon to crash. The plugin will be disabled until it is updated again (hopefully fixed). Any other plugins will continue to run and events will continue to be processed. The daemon will keep track of the last event id that the broken plugin processed successfully. When it is updated (and fixed, hopefully), the daemon will reload it and attempt to process events starting from where that plugin left off. Assuming all is well again, the daemon will catch the plugin up to the current event and then continue to process events with all plugins as normal.
  
A {% include product %} event processing plugin has two main parts: a callback registration function and any number of callbacks.

<a id="registerCallbacks_function"></a>
## registerCallbacks function

To be loaded by the framework, your plugin should at least implement the following function:

```python
def registerCallbacks(reg):
    pass
```

This function will be used to tell the event processing system which functions to call to process events.

This function should take one argument which is a [`Registrar`](./event-daemon-api.md#Registrar) object.

The [`Registrar`](./event-daemon-api.md#Registrar) has one critically important method:[`Registrar.registerCallback`](./event-daemon-api.md#registercallback).

For each of your functions that should process {% include product %} events, call [`Registrar.registerCallback`](./event-daemon-api.md#registerCallback) once with the appropriate arguments.

You can register as many functions as you wish and not all functions in the file need to be registered as event processing callbacks.

<a id="Callbacks"></a>
## Callbacks

A callback that will be registered with the system must take four arguments:

- A {% include product %} connection instance if you need to query {% include product %} for additional information.
- A Python Logger object that should be used for reporting. Error and Critical messages will be sent via email to any configured user.
- The {% include product %} event to be processed.
- The `args` value passed in at callback registration time. (See [`Registrar.registerCallback`](./event-daemon-api.md#wiki-registerCallback))

{% include info title="Warning" content="You can do whatever you want in a plugin but if any exception raises back to the framework, the plugin within which the offending callback lives (and all contained callbacks) will be deactivated until the file on disk is changed (read: fixed)." %}

<a id="Logging"></a>
## Logging

Using the print statement in an event plugin is not recommended. It is prefered you use the standard logging module from the Python standard library. A logger object will be provided to your various functions

```python
def registerCallbacks(reg):
    reg.setEmails('root@domain.com', 'tech@domain.com') # Optional
    reg.logger.info('Info')
    reg.logger.error('Error') # ERROR and above will be sent via email in default config
```

and

```python
def exampleCallback(sg, logger, event, args):
    logger.info('Info message')
```

If the event framework is running as a daemon this will be logged to a file otherwise it will be logged to stdout.

<a id="Robust"></a>
## Building Robust plugins

The daemon runs queries against {% include product %} but has built in functionality to retry find() commands should they fail, giving the daemon itself a certain degree of robustness.

[https://github.com/shotgunsoftware/shotgunEvents/blob/master/src/shotgunEventDaemon.py#L456](https://github.com/shotgunsoftware/shotgunEvents/blob/master/src/shotgunEventDaemon.py#L456)

If a plugin needs network resources (be that {% include product %} or some other resource), it needs to provide its own retry mechanisms / robustness. In the case of {% include product %} access you could riff off what's in the daemon and make a helper function or class that could provide that functionality to your plugins.

The {% include product %} Python API does already do some level of retrying on network issues but should you hit a {% include product %} maintenance window that can run a few minutes, or be unlucky enough to hit a network blip, that might not be enough.

[https://github.com/shotgunsoftware/python-api/blob/master/shotgun_api3/shotgun.py#L1554](https://github.com/shotgunsoftware/python-api/blob/master/shotgun_api3/shotgun.py#L1554)

Depending on what your plugin does, you can also register it to just keep trucking should it encounter issues while processing events. Look at the stopOnError argument of the registerCallback function:

[https://github.com/shotgunsoftware/shotgunEvents/wiki/API#wiki-registerCallback](https://github.com/shotgunsoftware/shotgunEvents/wiki/API#wiki-registerCallback)

{% include info title="Note" content="The plugin won't stop but any failed attempts won't be retried." %}
