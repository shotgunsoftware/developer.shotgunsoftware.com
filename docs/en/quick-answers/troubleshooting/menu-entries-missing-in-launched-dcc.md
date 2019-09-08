---
layout: default
title: I've launched Nuke/Maya/etc. from Shotgun Desktop, but the Shotgun menu is missing entries
pagename: menu-entries-missing-in-launched-dcc
lang: en
---

# I've launched Nuke/Maya/etc. from Shotgun Desktop, but the Shotgun menu is missing entries

The actions that show up in the Shotgun menu are contextually configured. That means the list of available actions may be different depending on the context you’re in.
It's possible you may not be seeing the app you're after because you're in the wrong context.

## Example

When you launch an application from [Shotgun Desktop](https://support.shotgunsoftware.com/entries/95442947), it puts you in the project environment by default. This environment is managed by the config file in your pipeline configuration located at `config/env/project.yml`. Because most user's work will probably not be done in this environment, it's not configured with many apps for you to work with.

**Default Maya Project actions:**

![Shotgun Menu project actions](images/shotgun-menu-project-actions.png)

You can use the [Shotgun Workfiles app](https://support.shotgunsoftware.com/hc/en-us/articles/219033088-Your-Work-Files) to select the Asset, Shot, or Task to work on. This will load up the appropriate new environment for you which will then have more apps enabled with menu items in your Shotgun menu.

**Default Maya Asset Task actions:**

![Shotgun Menu project actions](images/shotgun-menu-asset-step-actions.png)

If you believe you're in the correct environment and the actions are still not showing, then the next step is to check the relevant [log](where-are-my-log-files.md), and see if there are any errors.
You may need to [enable debug logging](turn-debug-logging-on.md) to get the full output.