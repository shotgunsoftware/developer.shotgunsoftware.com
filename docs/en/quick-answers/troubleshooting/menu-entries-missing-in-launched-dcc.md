---
layout: default
title: I've launched Nuke/Maya/etc. from SG Desktop, but the Shotgun menu is missing entries
pagename: menu-entries-missing-in-launched-dcc
lang: en
---

# I've launched Nuke/Maya/etc. from SG Desktop, but the Shotgun menu is missing entries

When you launch an application from [Shotgun Desktop](https://support.shotgunsoftware.com/entries/95442947), it puts you in the project environment by default. This environment is managed by the config file in your pipeline configuration located at `.../config/env/project.yml`. Because most of your work will probably not be done in this environment, it's not configured with many apps for you to work with.

You can use the [Shotgun File Manager](https://support.shotgunsoftware.com/hc/en-us/articles/219033088-Your-Work-Files) to select the Asset, Shot, or Task to work on which will load up the appropriate new environment for you which will then have more apps enabled with menu items in your Shotgun menu.
