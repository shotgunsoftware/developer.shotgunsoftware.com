---
layout: default
title: I've launched Nuke/Maya/etc. from SG Desktop, but the Shotgun menu is missing entries
pagename: menu-entries-missing-in-launched-dcc
lang: en
---

# I've launched Nuke/Maya/etc. from SG Desktop, but the Shotgun menu is missing entries

{% include info title="Note" content="This document describes functionality only available if you have taken control over a Toolkit configuration. Please refer to the [Shotgun Integrations Admin Guide](https://support.shotgunsoftware.com/hc/en-us/articles/115000067493) or contact support if you do not have a more advanced configuration." %}

When you launch an application from [SG Desktop](https://support.shotgunsoftware.com/entries/95442947), it puts you in the Project environment by default. This environment is managed by the config file in your pipeline configuration located at config/env/project.yml. Because most of your work will probably not be done in this environment, it's not configured with many apps for you to work with.

You can use the [Shotgun File Manager](https://support.shotgunsoftware.com/hc/en-us/articles/219033088-Your-Work-Files) to select the Asset, Shot, or Task to work on which will load up the appropriate new environment for you which will then have more apps enabled with menu items in your Shotgun menu.
