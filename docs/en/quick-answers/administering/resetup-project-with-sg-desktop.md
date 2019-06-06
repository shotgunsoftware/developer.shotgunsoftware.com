---
layout: default
title: How do I re-setup a Toolkit Project using Shotgun Desktop?
pagename: resetup-project-with-sg-desktop
lang: en
---

# How do I re-setup a Toolkit Project using Shotgun Desktop?

The steps you need to do to re-setup the Project are as follows.

1. Delete the PipelineConfiguration entity(s) linked to your Project in Shotgun.<br/>![Access to the PipelineConfiguration entity page](../../../images/quick-answers/administering/pipeline-configuration-entity-page.png)
2. Set the Tank Name field on your Project in Shotgun to a blank value.<br/>![Clear the project tank name field](../../../images/quick-answers/administering/clear-project-tank-name.png)
3. Remove the corresponding pipeline configuration directory(s) on disk.
4. In Shotgun Desktop select the Project you wish to setup. *If you were already viewing the project, jump out to the project list view and then back into your project again.*
6. Now you can run the project setup process again.

**Alternate Method**

If you are used to using the command line to setup your project with the  `tank setup_project` command then you can add a `--force` argument to the end of the command to allow you to setup a previously setup project without following the manual steps listed above.
    
    tank setup_project --force"

    