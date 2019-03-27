---
layout: default
title: Getting Started
permalink: /rv/rv-nuke-integration/04-getting-started/
lang: en
---

# Getting Started

## RV Preferences

In order to launch RV from Nuke, Nuke needs to know where the RV executable is. To set this, start Nuke and select the *RV/Preferences…* menu item. Navigate to the RV executable you want to use with Nuke and hit *OK*.

This setting is stored and used across all future Nuke sessions.

You can also specify any additional default command line arguments for RV in the *RV Preferences* dialog.

If you have a RAID or other fast storage device you may want to configure the RV/Nuke integration to use a directory on this device as the base for all Session directories (see below). If so set the “Default Session Dir Base” preference accordingly.

## RV Project Settings

There are several settings that the integration uses that may be different for different Nuke projects. Once you have a script loaded, select the *RV/Project Settings…* menu item, and then the *RV* tab of the Project Settings.

The table below lists all the RV Project Settings, with explanations, but the most important is the “Session Directory.” This directory is where all media, script versions, and other information is stored for this Nuke script/project. It **must** be unique for each project.

| | |
|-|-|
| Session Directory | The root directory for all media, scripts and other information related to this project. It will be created if it does not exist. Since media will be stored under this directory, you may want to put it on a device with fast IO. This **name** must be unique across all projects.<br/>You can set "Default Session Dir Base" in the RV Preferences (see above) so that by default all Session directories are created on your fast IO device. |
| Render File Format | The format of all media files created by rendering and checkpointing. |
| Nuke Node Selection → RV Current View | If this box is checked, every time you select a node in nuke, if RV is connected, the current RV view node will be set to the corresponding view. This lets you quickly view or play media, either input media associated with a Read node, or rendered media associated with any node that has been checkpointed or rendered. |
| Nuke Frame → RV Frame | If this box is checked, frame changes in Nuke will force the corresponding frame change in RV. |
| Nuke Read Node Changes → RV Sources | If this box is checked, the total set of Read nodes in the project will be dynamically synced to RV. That is, for every Read node in the project, there will be a corresponding Source in RV with the same media, available for playback on demand. Adding or Deleteing a Read node in Nuke will trigger the corresponding action in RV. Changes to Read node file path, frame range, and color space will also be reflected in RV. |

## Quick Start Summary

You must set the RV executable path using the *RV/Preferences..* menu item before you use RV with Nuke at all, and whenever you start work on a new project/script, use *RV/Project Settings…* to make sure that the *Session Directory* is set to something reasonable before you start RV from that script for the first time. See above for details.

## RV Toolbar

Note that all the items on the RV menu are also available on the RV toolbar, which you can find in the Panes submenu.
