---
layout: default
title: Softimage
pagename: tk-softimage
lang: en
---

# Softimage

> **Warning:** The Softimage engine has been end of lifed as of February 13th, 2021. [Learn more here](https://community.shotgridsoftware.com/t/end-of-life-for-softimage-support-on-february-13th-2021/10694).

![](../images/engines/sg_softimage_1.png)

The {% include product %} engine for Softimage establishes a bridge between the {% include product %} Pipeline Toolkit apps and Softimage. It contains PySide/Qt distributions, making it possible to write apps using Python and PySide that run right inside the engine. This document refers to more advanced configuration setups.

The {% include product %} engine for Softimage contains a standard platform for integrating {% include product %} Apps into Softimage. The engine supports the usual suite of apps providing automatic file management, a well defined work-area/publish workflow, snapshot, etc.

When the engine is loaded, a {% include product %} Menu is provided in the main Softimage menubar:

![](../images/engines/softimage_menu.png)

## Supported Application Versions

This item has been tested and is known to be working on the following application versions: 2012, 2013. Please note that it is perfectly possible, even likely, that it will work with more recent releases, however it has not yet been formally tested with these versions.

Available Toolkit commands are displayed here.

Please note that the {% include product %} engine for Softimage is in beta and there are a few known issues - please see below for a full list.

## Information for App Developers

### Supported platforms

The {% include product %} engine for Softimage currently supports Softimage 2012 & 2013 on Windows and 2013 on Linux.

Softimage 2014 is not currently supported on Linux and whilst it can be run on Windows, there are some instability issues so it's use is definitely not recommended!

### PySide

#### Windows

Under Windows, Softimage can be configured to use either the built-in Python distribution or an external distribution - see http://download.autodesk.com/global/docs/softimage2013/en_us/userguide/index.html?url=files/userprefs528.htm,topicNumber=d30e797817 for further details.

The engine is bundled with versions of PySide & Qt for the installed versions of Python for Softimage, versions 2012 (Python 2.6 x64), 2013 (Python 2.6 x64) & 2014 (Python 2.7 x64). However, if you are using an external distribution of Python then you should be sure to provide a binary compatible version of PySide & Qt as well.

A good resource for Windows PySide distributions can be found here: http://www.lfd.uci.edu/~gohlke/pythonlibs/

#### Linux

Under Linux, Softimage has to use the built-in version of Python. For Softimage 2013, a pre-built distribution of PySide & Qt is required and provided by [tk-framework-softimageqt](https://github.com/shotgunsoftware/tk-framework-softimageqt). This distribution has been built using GCC 4.1.2 for Python 2.5.2, the same versions used by Softimage 2013.

Because of the many different Linux distributions, there isn't a guarantee that this will work with every one so it may be necessary to rebuild these yourself to get things working. Full details of how the version was built can be found in the README included with the framework, here:

https://github.com/shotgunsoftware/tk-framework-softimageqt/tree/master/resources/pyside121_py25_qt485_linux

### Known Issues (Windows)

#### Softimage 2014 Instability

Although the engine will run under Softimage 2014 on Windows there are known issues and it hasn't been fully tested. Opening the Publish dialog will cause Softimage to crash!

#### SSL Bug in Softimage 2014

The `_ssl.pyd` file distributed with Softimage 2014 contains a known bug which may cause slowdowns at startup. We recommend backing up and then overwriting this file with the `_ssl.pyd` file you can find in Maya 2014 in order to resolve these issues. If you need more help or advice with this, don't hesitate to contact the toolkit support.

#### Window Parenting

Qt windows created without a parent and without using the engine's `show_modal` or `show_dialog` methods will not be parented correctly to the main Softimage application.

### Known Issues (Linux)

#### Missing ssl & sqlite3 Libraries

In addition to requiring a very specific version of PySide (detailed above), Softimage is also missing ssl and sqlite3 libraries required by the {% include product %} Python API and Toolkit.

We have included these as part of the `tk-multi-launchapp` app which also adds them to the LD_LIBRARY_PATH & PYTHONPATH prior to launching Softimage. Again though, if you have problems with these then detailed instructions for how to build them for your system can be found in the README included with the app, here:

https://github.com/shotgunsoftware/tk-multi-launchapp/blob/master/app_specific/softimage/linux/lib/README

#### Segmentation Faults In libX11.

Softimage on Linux contains an optional hack to address speed issues on certain linux distributions. This is detailed here:

http://xsisupport.com/2011/01/19/the-case-of-the-slow-2011-startup-on-fedora-14/

This tells Softimage to use a different version of the libX11 library found in:

/usr/Softimage/Softimage_2013/Application/mainwin/mw/lib-amd64_linux_optimized/X11

If you are using this hack then you will probably get segmentation faults during calls by Qt to the libX11 library (SIGSEGV in the call stack) resulting in frequent crashing. This is because the hack version of the libX11 library is quite old and not compatible with the version Qt was built against!

To resolve this, a new version of Qt will need to be built against a version of libX11 compatible with the Softimage hack version...

#### Segmentation Faults In libssl

If you are using a recent version of openssl, not built using the correct version of GCC (4.1.2) you may see Segmentation faults (SIGSEGV) when the {% include product %} API is used.

This isn't specific to Qt/PySide but worth mentioning here as it's the second most common problem!

Please see:

https://github.com/shotgunsoftware/tk-multi-launchapp/blob/master/app_specific/softimage/linux/lib/README

for instructions on how to build a compatible version of openssl for Softimage 2013.

#### Window Parenting

Currently, Toolkit windows are not parented to the main Softimage application window on Linux. As a work-around they are created to be topmost but this can sometimes mean that other windows (particularly confirmation dialogs) can be hidden behind them.

If Softimage seems to have hung, try moving any open Toolkit windows to see if there is a dialog hiding behind it!

#### Softimage/Toolkit Freezes After Moving Window

You will find that when you move a modeless dialog (e.g. the {% include product %} File Manager), the contents of both Softimage and the dialog will appear to freeze/hang. This is an issue to do with the way the Qt message queue is currently implemented but unfortunately we are yet to find an alternative solution!

As a simple workaround, when this happens if you just click in the main Softimage Viewport, you will find that everything starts working correctly again!

## Installation and Updates

### Adding this Engine to the {% include product %} Pipeline Toolkit

If you want to add this engine to Project XYZ, and an environment named asset, execute the following command:

```
> tank Project XYZ install_engine asset tk-softimage
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
	
If you have access to the {% include product %} Pipeline Toolkit, you also have access to the source code for all apps, engines and frameworks in Github where we store and manage them. Feel free to evolve these items; use them as a base for further independent development, make changes (and submit pull requests back to us!) or simply tinker with them to see how they have been built and how the toolkit works. You can access this code repository at https://github.com/shotgunsoftware/tk-softimage.

## Special Requirements

You need {% include product %} Pipeline Toolkit Core API version v0.14.56 or higher to use this.