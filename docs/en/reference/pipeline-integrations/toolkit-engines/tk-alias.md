---
layout: default
title: Alias
pagename: tk-alias
lang: en
---

# Alias

The {% include product %} engine for Alias contains a standard platform for integrating {% include product %} Apps into Alias. It is lightweight and straight forward and adds a {% include product %} menu to the Alias menu.

# Information for App Developers
    
## PySide

The {% include product %} engine for Alias uses a PySide installation shipped with the {% include product %} Desktop and will activate this whenever this is necessary. 

## Alias Project Management

Whenever the {% include product %} engine for Alias starts, it will set the Alias Project to point at a location defined in the settings for this engine. This means that the Project may also change when a new file is opened. The details relating to how the Alias project is set based on a file can be configured in the configuration file, using the template system.

***

# Working with tk-alias

This {% include product %} integration supports the Alias application family (Concept, Surface, and AutoStudio).

When Alias opens, a {% include product %} menu (the Alias engine) is added to the menu bar.

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunOtherApps.png)


### File Open and Save

Use the My Tasks and Assets tabs to see all your assigned tasks and browse for assets. To the right, use these tabs to view all files, working or published files associated with what is selected to the left.

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunFileOpen.png)

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunFileSave.png)


### Snapshot

Opens the Snapshot dialog to create a quick backup of the current scene. 

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunSnapshot.png)


### Publish

Opens the Publish dialog for publishing the file to {% include product %}, which can then be used by artists downstream. For more information, see [Publishing in Alias](https://github.com/shotgunsoftware/tk-alias/wiki/Publishing). 

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunPublish.png)


### Loader

Opens the Content Loader app, allowing you to load data into Alias. For more information see [Loading in Alias](https://github.com/shotgunsoftware/tk-alias/wiki/Loading)

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunLoader.png)

### Scene Breakdown

Opens the Breakdown dialog, which displays a list of referenced (WREF References) content, along with what in the scene is out-of-date. Select one or more items and click Update Selected to switch and use the latest version of the content. For more information see [Scene Breakdown in Alias](https://github.com/shotgunsoftware/tk-alias/wiki/Scene-Breakdown)

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunBreakdown.png)

