---
layout: default
title: Developing your own engine
pagename: sgtk-developer-engine
lang: en
---

# Developing your own engine

## Introduction
This document outlines some of the technical details relating to Toolkit Engine development.

Table of Contents:
- [What is a Toolkit engine?](#what-is-a-toolkit-engine)
- [Before you start](#before-you-start)
- [Approaches to Engine Integration](#approaches-to-engine-integration)
    - [Host application includes QT, PyQt/PySide and Python](#host-application-includes-qt-pyqtpyside-and-python)
    - [Host application includes QT and Python but not PySide/PyQt](#host-application-includes-qt-and-python-but-not-pysidepyqt)
    - [Host application includes Python](#host-application-includes-python)
    - [Host application does not contain Python but you can write plugins](#host-application-does-not-contain-python-but-you-can-write-plugins)
    - [Host application provides no scriptability at all](#host-application-provides-no-scriptability-at-all)
- [QT Window Parenting](#qt-window-parenting)
- [Startup behavior](#startup-behavior)
- [Host application wish list](#host-application-wish-list)

## What is a Toolkit engine?
When developing an engine, you effectively establish a bridge between the host application and the various apps and frameworks that are loaded into the engine. 
The engine makes it possible to abstract the differences between applications so that apps can be written in more of a software agnostic manner using Python and QT.

The engine is a collection of files, [similar in structure to an app](sgtk-developer-app.md#anatomy-of-the-template-starter-app). It has an `engine.py` file and this must derive from the Tank Core Engine [Base class](https://github.com/shotgunsoftware/tk-core/blob/master/python/tank/platform/engine.py). 
Different engines then re-implement various aspect of this base class depending on their internal complexity. 
An engine typically handles or provides the following services:

- Menu management. At engine startup, once the apps have been loaded, the engine needs to create its Shotgun menu and add the various apps to this menu.
- Logging methods are typically overridden to write to the application log/console.
- Methods for displaying UI dialogs and windows. These methods are usually overridden, if the way the engine handles QT is different from the default base class behavior, to ensure seamless integration of windows launched by Toolkit apps and the underlying host application window management setup.
- Provides a `commands` dictionary containing all the command objects registered by apps. This is typically accessed when menu entries are created.
- The base class exposes various init and destroy methods which are executed at various points in the startup process. These can be overridden to control startup and shutdown execution.
- Start up logic that gets called by the `tk-multi-launchapp` at launch time, as well as automatic software discovery.

Engines are launched by the Tank Core Platform using the `stgk.platform.start_engine()` command. 
This command will read the configuration files, launch the engines, load all apps etc.
The goal with the engine is that once it has launched, it will provide a consistent Python/QT interface to the apps. 
Since all engines implement the same base class, apps can call methods on the engines, for example, to create UIs. 
It is up to each engine to implement these methods so that they work nicely inside the host application.

## Before you start

We provide a bunch of [integrations](https://support.shotgunsoftware.com/hc/en-us/articles/219039798-Integrations-Apps-and-Engines) already.
There are also [engines that Toolkit Community members have built and shared back](https://support.shotgunsoftware.com/hc/en-us/articles/219039828-Community-Shared-Integrations). But sometimes you'll need pipeline integrations for software that doesn't have a Toolkit engine yet. 

If you have the time and resources, we encourage you to help the Toolkit Community (and yourselves) in writing a missing engine you would like to use!

Before embarking on writing code, [talk to us!](toolkitsupport@shotgunsoftware.com) We can't promise anything, but we will be happy to discuss your plans with you. 
We may also be able to connect you to other users who are interested in or have done work on the same engine.
If you can, open a channel of communication with a technical contact or developer of the software you are looking to integrate Toolkit into. 
This helps gain insight into what the possibilities and/or roadblocks are for getting something going. 
Once you establish a contact and talk through the basics of what you are trying to do, you can bring us into the conversation and setup a meeting with all of us to talk through some of the specifics of the engine.
Also you can engage directly with the Toolkit community in the [Shotgun community forum](https://community.shotgunsoftware.com/c/pipeline). 

We love to see new integrations, and are always eternally grateful for people's generous contributions to the Toolkit Community!

{% include info title="Tip" content="The [Developing your own app](sgtk-developer-app.md) contains a step by step guide to developing an app, which contains principles that apply to developing an engine as well, which are not covered in this guide." %}

## Approaches to Engine Integration

Depending on what the capabilities of the host app are, engine development may be more or less complex. 
This section outlines a couple of different complexity levels that we have noticed during engine development.


### Host application includes QT, PyQt/PySide and Python
This is the best setup for Toolkit and implementing an engine on top of a host application which supports QT, Python and PySide is very straight forward. 
The nuke engine is a good example of this. Integration is merely a matter of hooking up some log file management and write code to set up the Shotgun menu.


### Host application includes QT and Python but not PySide/PyQt
This class of applications includes for example Maya and Motionbuilder and is relatively easy to integrate. 
Since the host application itself was written in QT and contains a Python interpreter, it is possible to compile a version of PySide or PyQt and distribute with the engine.
This PySide is then added to the Python environment and will allow access of the QT objects using Python. 
It is common that the exact compiler settings that were used when compiling the shot application must be used when compiling PySide, in order to guarantee for it to work.


### Host application includes Python
This class includes Houdini and Softimage. These host applications have a non-QT UI but contain a Python interpreter. 
This means that Python code can execute inside of the environment, but there is no existing QT event loop running. 
In this case, QT and PySide will need to be included with the engine and the QT message pump (event) loop must be hooked up with the main event loop in the UI. 
Sometimes host applications contain special methods for doing precisely this. 
If not, arrangements must be made so that the QT event loop runs regularly, for example via an on-idle call.


### Host application does not contain Python but you can write plugins
This class includes Photoshop. There is no Python scripting, but C++ plugins can be created. 
In this case, the strategy is often to create a plugin which contains an IPC layer and launches QT and Python in a separate process at startup.
 Once the secondary process is running, commands are sent back and forth using the IPC layer. 
 This type of host application usually means significant work in order to get a working engine solution.


### Host application provides no scriptability at all
If the host application cannot be accessed programmatically in any way, it is not possible to create an engine for it.


## QT Window Parenting
Special attention typically needs to be paid to window parenting. 
Usually, the PySide windows will not have a natural parent in the widget hierarchy and this needs to be explicitly called out. 
The window parenting is important in order to provide a consistent experience and without it implemented, Toolkit app windows may appear behind the main window, which can be quite confusing.

## Startup Behavior
The engine is also responsible for handling how the software is launched and it's own integration is started. 
This logic will be called when the `tk-multi-launchapp` tries to launch the software with your engine.
You can read more about how this is setup in the [core documentaiton](https://developer.shotgunsoftware.com/tk-core/initializing.html?highlight=create_engine_launcher#launching-software).

## Host application wish list
The following host application traits can be taken advantage of by Toolkit Engines. 
The more of them that are supported, the better the engine experience will be!

- Built in Python interpreter, QT and PySide!
- Ability to run code at application startup/init.
- Ability to access and auto-run code at two places: once when the application is up and running and once when the UI has fully initialized.
- API commands that wrap filesystem interaction: Open, Save, Save As, Add reference, etc.
- API commands to add UI elements

    - Add a custom Qt widget as a panel to the app (ideally via a bundled PySide)
    - Add custom Menu / Context Menu items
    - Custom nodes in node based packages (with easy way to roll own UI for interaction)
    - Introspection to get at things like selected items/nodes
- Flexible event system
    - "Interesting" events can trigger custom code
- Support for running UI asynchronously
    - For example, pop up a dialog when a custom menu item is triggered that does not lock up the interface
    - Provide a handle to a top level window so custom UI windows can be parented correctly