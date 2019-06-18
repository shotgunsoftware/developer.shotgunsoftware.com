---
layout: default
title: I've launched Nuke/Maya/etc. from SG Desktop, but the Shotgun menu is missing entries
pagename: menu-entries-missing-in-launched-dcc
lang: en
---

# I've launched Nuke/Maya/etc. from SG Desktop, but the Shotgun menu is missing entries

The actions that show up in the Shotgun menu are contextually configured. That means the list of available actions may be different depending on the context you’re in.
It's possible you may not be seeing the app your after because your in the wrong context.

## Example

When you launch an application from [Shotgun Desktop](https://support.shotgunsoftware.com/entries/95442947), it puts you in the project environment by default. This environment is managed by the config file in your pipeline configuration located at `.../config/env/project.yml`. Because most of your work will probably not be done in this environment, it's not configured with many apps for you to work with.

**Default Maya Project actions:**

![Shotgun Menu project actions](images/shotgun_menu_project_actions.png)

You can use the [Shotgun workfiles app](https://support.shotgunsoftware.com/hc/en-us/articles/219033088-Your-Work-Files) to select the Asset, Shot, or Task to work on which will load up the appropriate new environment for you which will then have more apps enabled with menu items in your Shotgun menu.

**Default Maya Asset Task actions:**

![Shotgun Menu project actions](images/shotgun_menu_asset_step_actions.png)

If you believe your in the correct environment and the actions are still not showing, then the next step is to check the relevant [log](where-are-my-log-files.md), and see if there are any errors.
You may need to [enable debug logging](turn-debug-logging-on.md) to get the full output.