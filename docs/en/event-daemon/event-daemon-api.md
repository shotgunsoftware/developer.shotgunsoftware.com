---
layout: default
title: API
pagename: event-daemon-api
lang: en
---

# API

<a id="registerCallbacks"></a>
## registerCallbacks

A global level function in all plugins that is used to tell the framework about event processing entry points in the plugin.

**registerCallbacks(reg)**

* reg: The [`Registrar`](#Registrar) you will interact with to tell the framework which functions to call.


<a id="Registrar"></a>
## Registrar

The Registrar is the object used to tell the framework how to interact with a plugin. It is passed to the [`registerCallbacks`](#registerCallbacks) function.

### Attributes

<a id="logger"></a>
**logger**

See [`getLogger`](#getLogger).

### Methods

<a id="getLogger"></a>
**getLogger**

Get the python Logger object used to log messages from within the plugin.



__setEmails(*emails)__

Set the emails that should receive error and critical notices when something bad happens in this plugin or any of its callbacks.

To send emails to default addresses as specified in the configuration file (default)

```python
reg.setEmails(True)
```

To disable emails (this is not suggested as you won't get error messages)

```python
reg.setEmails(False)
```

To send emails to specific addresses use

```python
reg.setEmails('user1@domain.com')
```

or

```python
reg.setEmails('user1@domain.com', 'user2@domain.com')
```

<a id="registerCallback"></a>
**registerCallback(sgScriptName, sgScriptKey, callback, matchEvents=None, args=None, stopOnError=True)**

Register a callback into the engine for this plugin.

* `sgScriptName`: The name of the script taken from the {% include product %}  scripts page.
* `sgScriptKey`: The application key for the script taken from a {% include product %}  script page.
* `callback`: A function or an object with a `__call__` method. See [`exampleCallback`](#exampleCallback).
* `matchEvents`: A filter of events you want to have passed to your callback.
* `args`: Any object you want the framework to pass back into your callback.
* `stopOnError`: Boolean, should an exception in this callback halt processing of events by all callbacks in this plugin. Default is `True`.

The `sgScriptName` is used to identify the plugin to {% include product %}. Any name can be shared across any number of callbacks or be unique for a single callback.

The `sgScriptKey` is used to identify the plugin to {% include product %} and should be the appropriate key for the specified `sgScriptName`.

The specified callback object will be invoked when an event that matches your filter needs processing. Although any callable should be able to run, using a class here is not suggested. Use of a function or an instance with a `__call__` method is more appropriate.

The `matchEvent` argument is a filter that allows you to specify which events the callback being registered is interrested in. If `matchEvents` is not specified or None is specified, all events will be passed to the callback. Otherwise each key in the `matchEvents` filter is an event type while each value is a list of possible attribute names.

```python
matchEvents = {
    'Shotgun_Task_Change': ['sg_status_list'],
}
```

You can have multiple event types or attribute names

```python
matchEvents = {
    'Shotgun_Task_Change': ['sg_status_list'],
    'Shotgun_Version_Change': ['description', 'sg_status_list']
}
```

You can filter on any event type that has a given attribute name

```python
matchEvents = {
    '*': ['sg_status_list'],
}
```

You can also filter on any attribute name for a given event type

```python
matchEvents = {
    'Shotgun_Version_Change': ['*']
}
```

Although the following is valid and functionally equivalent to specifying nothing, it's just really useless

```python
matchEvents = {
    '*': ['*']
}
```

When matching against non field specific event types such as "_New" or "_Retirement", you don't provide a list, instead you pass `None` as the value.

```python
matchEvents = {
    'Shotgun_Version_New': None
}
```

The `args` argument will not be used by the event framework itself but will simply be passed back to your callback without any modification.

{% include info title="Note" content="The point of the `args` argument is for you to be able to process time consuming stuff in the [`registerCallbacks`](#registerCallbacks) function and have it passed back to you at event processing time." %}

Another use of the `args` argument could be to pass in a common mutable, a `dict` for example, to multiple callbacks to have them share data.

The `stopOnError` argument tells the system if an exception in this callback can cause event processing to stop for all callbacks in the plugin. By default this is `True` but can be switched to `False`. You will still get mail notifications of errors should there be any but processing of events will not stop. Being a per callback setting you can have some critical callbacks for whom this is `True` but others for whom this is `False`.

<a id="Callback"></a>
## Callback

Any plugin entry point registered by [`Registrar.registerCallback`](#registerCallback) is generally a global level function that looks like this:

<a id="exampleCallback"></a>
**exampleCallback(sg, logger, event, args)**

* `sg`: A {% include product %} connection instance.
* `logger`: A Python logging.Logger object preconfigured for you.
* `event`: A {% include product %} event to process.
* `args`: The args argument specified at callback registration time.

{% include info title="Note" content="Implementing a callback as a `__call__` method on an object instance is possible but left as an exercise for the user." %}
