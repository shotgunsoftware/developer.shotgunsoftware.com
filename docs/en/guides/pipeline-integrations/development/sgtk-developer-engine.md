---
layout: default
title: Developing engines
pagename: sgtk-developer-engine
lang: en
---

# Developing your own engine

## Introduction

This document outlines some of the technical details relating to Toolkit engine development.

Table of Contents:

- [What is a Toolkit engine?](#what-is-a-toolkit-engine)
- [Things to know before you start](#things-to-know-before-you-start)
- [Approaches to engine integration](#approaches-to-engine-integration)
  - [Host software includes Qt, PyQt/PySide and Python](#host-software-includes-qt-pyqtpyside-and-python)
  - [Host software includes Qt and Python but not PySide/PyQt](#host-software-includes-qt-and-python-but-not-pysidepyqt)
  - [Host software includes Python](#host-software-includes-python)
  - [Host software does not contain Python but you can write plugins](#host-software-does-not-contain-python-but-you-can-write-plugins)
  - [Host software provides no scriptability at all](#host-software-provides-no-scriptability-at-all)
- [Qt window parenting](#qt-window-parenting)
- [Startup behavior](#startup-behavior)
- [Host software wish list](#host-software-wish-list)

## What is a Toolkit engine?

When developing an engine, you effectively establish a bridge between the host software and the various Toolkit apps and frameworks that are loaded into the engine.
The engine makes it possible to abstract the differences between software so that apps can be written in more of a software-agnostic manner using Python and Qt.

The engine is a collection of files, [similar in structure to an app](sgtk-developer-app.md#anatomy-of-the-template-starter-app). It has an `engine.py` file and this must derive from the core [`Engine` base class](https://github.com/shotgunsoftware/tk-core/blob/master/python/tank/platform/engine.py).
Different engines then re-implement various aspects of this base class depending on their internal complexity.
An engine typically handles or provides the following services:

- Menu management. At engine startup, once the apps have been loaded, the engine needs to create its {% include product %} menu and add the various apps to this menu.
- Logging methods are typically overridden to write to the software's log/console.
- Methods for displaying UI dialogs and windows. These methods are usually overridden, if the way the engine handles Qt is different from the default base class behavior, to ensure seamless integration of windows launched by Toolkit apps and the underlying host software window management setup.
- Provides a `commands` dictionary containing all the command objects registered by apps. This is typically accessed when menu entries are created.
- The base class exposes various init and destroy methods that are executed at various points in the startup process. These can be overridden to control startup and shutdown execution.
- Startup logic that gets called by the `tk-multi-launchapp` at launch time, as well as automatic software discovery.

Engines are launched by the Toolkit platform using the [`sgtk.platform.start_engine()`](https://developer.shotgridsoftware.com/tk-core/platform.html#sgtk.platform.start_engine) or the [`sgtk.bootstrap.ToolkitManager.bootstrap_engine()`](https://developer.shotgridsoftware.com/tk-core/initializing.html#sgtk.bootstrap.ToolkitManager.bootstrap_engine) methods.
This command will read the configuration files, launch the engines, load all apps, etc.
The goal with the engine is that once it has launched, it will provide a consistent Python/Qt interface to the apps.
Since all engines implement the same base class, apps can call methods on the engines, for example, to create UIs.
It is up to each engine to implement these methods so that they work nicely inside the host software.

## Things to know before you start

we provide [integrations](https://support.shotgunsoftware.com/hc/en-us/articles/219039798-Integrations-Apps-and-Engines) for the most commonly used content creation software.
There are also [engines that Toolkit Community members have built and shared back](https://support.shotgunsoftware.com/hc/en-us/articles/219039828-Community-Shared-Integrations). But sometimes you'll need pipeline integrations for software that doesn't have a Toolkit engine yet.

If you have the time and resources, we encourage you to help the Toolkit Community (and yourselves) in writing a missing engine you would like to use!

Before embarking on writing code, [talk to us!](https://knowledge.autodesk.com/contact-support) We can't promise anything, but we will be happy to discuss your plans with you.
We may also be able to connect you to other users who are interested in or have done work on the same engine.
If you can, open a channel of communication with a technical contact or developer of the software you are looking to integrate Toolkit into.
This helps gain insight into what the possibilities and/or roadblocks are for getting something going.
Once you establish a contact and talk through the basics of what you are trying to do, you can bring us into the conversation and set up a meeting with all of us to talk through some of the specifics of the engine.
Also, you can engage directly with the Toolkit community in the [{% include product %} community forum](https://community.shotgridsoftware.com/c/pipeline).

We love to see new integrations, and are always eternally grateful for people's generous contributions to the Toolkit Community!

{% include info title="Tip" content="The [Developing your own app](sgtk-developer-app.md) contains a step by step guide to developing an app, which contains principles that apply to developing an engine as well that are not covered in this guide." %}

## Approaches to engine integration

Depending on what the capabilities of the host app are, engine development may be more or less complex.
This section outlines a couple of different complexity levels that we have noticed during engine development.

### Host software includes Qt, PyQt/PySide, and Python

This is the best setup for Toolkit and implementing an engine on top of a host software that supports Qt, Python, and PySide is very straight forward.
The [Nuke engine](https://github.com/shotgunsoftware/tk-nuke) or the [Maya engine](https://github.com/shotgunsoftware/tk-maya) is a good example of this. Integration is merely a matter of hooking up some log file management and write code to set up the {% include product %} menu.

### Host software includes Qt and Python but not PySide/PyQt

This class of software includes for example [Motionbuilder](https://github.com/shotgunsoftware/tk-motionbuilder) and is relatively easy to integrate.
Since the host software itself was written in Qt and contains a Python interpreter, it is possible to compile a version of PySide or PyQt and distribute it with the engine.
This PySide is then added to the Python environment and will allow access to the Qt objects using Python.
Commonly, the exact compiler settings that were used when compiling the shot application must be used when compiling PySide, to guarantee it to work.

### Host software includes Python

This class of software includes for example, the third party integration [Unreal](https://github.com/ue4plugins/tk-unreal).
These host software have a non-Qt UI but contain a Python interpreter.
This means that Python code can execute inside of the environment, but there is no existing Qt event loop running.
In this case, Qt and PySide will need to be included with the engine and the Qt message pump (event) loop must be hooked up with the main event loop in the UI.
Sometimes the host software may contain special methods for doing precisely this.
If not, arrangements must be made so that the Qt event loop runs regularly, for example via an on-idle call.

### Host software does not contain Python but you can write plugins

This class includes [Photoshop](https://github.com/shotgunsoftware/tk-photoshopcc) and [After Effects](https://github.com/shotgunsoftware/tk-aftereffects).
There is no Python scripting, but C++ plugins can be created.
In this case, the strategy is often to create a plugin that contains an IPC layer and launches Qt and Python in a separate process at startup.
Once the secondary process is running, commands are sent back and forth using the IPC layer.
This type of host software usually means significant work to get a working engine solution.

{% include info title="Tip" content="With the Photoshop and After Effects engines we actually created [a framework that handles the adobe plugin](https://github.com/shotgunsoftware/tk-framework-adobe).
  Both engine make use of the framework to communicate with the host software, and it makes it easier to build other engines for the rest of the adobe family." %}

### Host software provides no scriptability at all

If the host software cannot be accessed programmatically in any way, it is not possible to create an engine for it.

## Qt window parenting

Special attention typically needs to be paid to window parenting.
Usually, the PySide windows will not have a natural parent in the widget hierarchy and this needs to be explicitly called out.
The window parenting is important to provide a consistent experience and without it implemented, Toolkit app windows may appear behind the main window, which can be quite confusing.

## Startup behavior

The engine is also responsible for handling how the software is launched and its integration is started.
This logic will be called when the `tk-multi-launchapp` tries to launch the software with your engine.
You can read more about how this is set up in the [core documentation](https://developer.shotgridsoftware.com/tk-core/initializing.html?highlight=create_engine_launcher#launching-software).

## Host software wish list

The following host software traits can be taken advantage of by Toolkit engines.
The more of them that are supported, the better the engine experience will be!

- Built-in Python interpreter, Qt, and PySide!
- Ability to run code at software startup/init.
- Ability to access and auto-run code in two places: once when the software is up and running and once when the UI has fully initialized.
- API commands that wrap filesystem interaction: Open, Save, Save As, Add reference, etc.
- API commands to add UI elements

  - Add a custom Qt widget as a panel to the app (ideally via a bundled PySide)
  - Add custom Menu / Context Menu items
  - Custom nodes in node-based packages (with an easy way to integrate a custom UI for interaction)
  - Introspection to get at things like selected items/nodes

- Flexible event system
  - "Interesting" events can trigger custom code
- Support for running UI asynchronously
  - For example, pop up a dialog when a custom menu item is triggered that does not lock up the interface
  - Provide a handle to a top-level window so custom UI windows can be parented correctly
