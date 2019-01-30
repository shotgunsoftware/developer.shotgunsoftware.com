---
layout: default
title: Editing Pipeline Configurations, changing an app setting
nav_order: 2
parent: Toolkit Basics Guides
permalink: learning_content/toolkit_basics_guides/editing_app_setting
---

# Editing Pipeline Configurations, changing an App Setting
 
## About the guide
 
This guide describes how to edit settings within an existing Pipeline Configuration to meet the needs of a project pipeline. The first guide, [Shotgun Toolkit editing a configuration getting started guide](link), described how to prepare a pipeline configuration for editing. If you aren’t familiar with how to create an Advanced Configuration, complete the Advanced Configuration Guide before proceeding.

Through extending the Default Configuration, Shotgun Toolkit enables the creation of custom workspace [environments](link to environments document) creating an integrated UI that allows for custom pipeline workflows. An example of a customization might be as simple as enabling and disabling a button to control at what step in a pipeline a function of a Toolkit App can or cannot be used, and by whom. These customizations change the way specified users interact with the Apps. Toolkit allows proprietary configurations that enable you to work smarter and faster by: creating custom workflows, automating repetitive and mundane tasks, modifying hooks as well as adding custom tools. Unfortunately, it’s only accessible through Shotgun, and not yet released for everyday tasks like washing your clothes.

The exercises in this guide will teach you how to find what configuration settings control actions within the Shotgun Toolkit software integrations, where the settings live, and how to edit them. We will edit a setting in the Workfiles App that manages the behavior of the +New Task button in Maya and prevents an artist from creating a new task when working on a project inside Maya. After completing this guide, you will have the knowledge fundamental to: finding a configuration setting for a specific Toolkit app, editing a setting, and exploring what other functions the configuration settings can extend.

##Using this document
 
To use this guide and perform an edit on a pipeline configuration the following is required:

