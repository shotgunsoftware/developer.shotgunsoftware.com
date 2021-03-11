---
layout: default
title: VRed
pagename: tk-vred
lang: en
---

# VRed

The {% include product %} engine for VRED contains a standard platform for integrating {% include product %} Apps into VRED. It is lightweight and straight forward and adds a {% include product %} menu to the VRED menu.

## Information for App Developers
    
### PySide

The {% include product %} engine for VRED contains a PySide installation, and will activate this whenever this is necessary. 

### VRED Project Management

Whenever the {% include product %} engine for VRED starts, it will set the VRED Project to point at a location defined in the settings for this engine. This means that the Project may also change when a new file is opened. The details relating to how the VRED project is set based on a file can be configured in the configuration file, using the template system.

## Working with tk-vred

This {% include product %} integration supports the VRED product family (Pro & Design).

When VRED opens, a {% include product %} menu (the VRED engine) is added to the menu bar.
![](https://help.autodesk.com/cloudhelp/2020/ENU/VRED-Shotgun/images/ShotgunMenuVRED.png)


### File Open and Save

Use the My Tasks and Assets tabs to see all your assigned tasks and browse for assets. To the right, use these tabs to view all files, working or published files associated with what is selected to the left.
![](https://help.autodesk.com/cloudhelp/2020/ENU/VRED-Shotgun/images/ShotgunFileOpenVRED.png)

![](https://help.autodesk.com/cloudhelp/2020/ENU/VRED-Shotgun/images/ShotgunFileSaveVRED.png)


### Snapshot
Snapshot: Opens the Snapshot dialog to create a quick backup of the current scene. 
![](https://help.autodesk.com/cloudhelp/2020/ENU/VRED-Shotgun/images/ShotgunSnapshotVRED.png)


### Publish 
Publish: Opens the Publish dialog for publishing the file to {% include product %}, which can then be used by artists downstream. For more information on VRED Publishing, [see here](https://github.com/shotgunsoftware/tk-vred/wiki/Publishing)
![](https://help.autodesk.com/cloudhelp/2020/ENU/VRED-Shotgun/images/ShotgunPublishVRED.png)


### Loader 
Load: Opens the Content Loader app, along with instructional slides explaining how it works.
To see more info about VRED loading [see here](https://github.com/shotgunsoftware/tk-vred/wiki/Loading)
![](https://help.autodesk.com/cloudhelp/2020/ENU/VRED-Shotgun/images/ShotgunLoaderVRED.png)

### Scene Breakdown 
Scene Breakdown: Opens the Breakdown dialog, which displays a list of "referenced" files (and their links), along with what in the scene is out-of-date. Select one or more items and click Update Selected to switch and use the latest version of the content.
![](https://help.autodesk.com/cloudhelp/2020/ENU/VRED-Shotgun/images/ShotgunBreakdownVRED.png)
