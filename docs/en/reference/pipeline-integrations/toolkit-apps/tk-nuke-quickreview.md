---
layout: default
title: Nuke Quickreview
pagename: tk-nuke-quickreview
lang: en
---

# Nuke Quickreview

The Quickreview app makes it easy to submit Nuke renders for review in {% include product %}. A **Version** in {% include product %} will be created with each quickreview submission. It appears as a node in Nuke, located on the {% include product %} Node menu. Simply create a new node, attach it to your Nuke network, double click it and click the Upload button.

![Nuke overview](../images/apps/nuke-quickreview-nuke_ui.png)

You get presented with the following UI, allowing you control how your Version is created in {% include product %}:

![Submit UI](../images/apps/nuke-quickreview-submit.png)

The following items can be controlled:

- The version name is pre-populated based on the currently loaded nuke script and can be adjusted if needed.
- The entity link and task associated with the version is based on the current context and can be adjusted.
- The frame range to be submitted can be adjusted.
- The created Version can be added to a playlist. A dropdown with recent playlist are being displayed.

Once you press the Upload button, a quicktime will be generated in nuke and then uploaded to {% include product %}. Once uploaded, the following screen will be shown, allowing you to either show the Version in the Built-in {% include product %} Panel in Nuke or in the web overlay player.

## Burnins and slate

By default, the app will generate a Quicktime with a slate and burn-ins:

![Slate Example](../images/apps/nuke-quickreview-slate.png)
![Burnins Example](../images/apps/nuke-quickreview-burnins.png) 

## Customization

Most aspects of the review submission can be adjusted using hooks. Documentation can be found [here](http://developer.shotgunsoftware.com/tk-nuke-quickreview).

