---
layout: default
title: Modifying the Nuke Project from RV
permalink: /rv/rv-nuke-integration/modifying-the-nuke-project-from-rv/
lang: en
---

# Modifying the Nuke Project from RV

## Restoring Checkpoints

Any Checkpoint (or Render) can provide a source from which the Nuke project can be restored to the state it was in when the Checkpoint’s media was rendered. To restore a Checkpoint, select it in the RV Session Manager, and choose *Nuke/Restore Checkpoint*. After a confirmation dialog, the Nuke script will be restored.

The navigation techniques referenced above combine with checkpoint restoration to produce some nice workflows (I think). For example:

1. After lots of rendering and checkpointing of node *FinalMerge*, double-click on the *Renders of FinalMege* folder to see a layout of all the checkpoints and renders.
2. Bring up the Image Info widget to mouse around and see the names and timestamps of all the views in the layout.
3. Double click on one if the tiles to examine that checkpoint more closely.
4. Decide to restore this checkpoint, it’s already selected, so just hit *Nuke/Restore Checkpoint*.

Also note that the Restore operation is undo-able, from the Nuke *Edit* menu.

## Adding Read Nodes

Of course you can still view media that’s unconnected to the Nuke project in a connected RV. So you can for example browse an element library. Once you have media that you’d like to include in your project, just select the Sources in the Session Manager and choose *Nuke/Create Nuke Read Node*. The corresponding Read node will be created in Nuke. Actually you can create any number at once by just selecting however many you want.

## Version 1.10, released 9/29/14, with RV 4.0.13

* Further updates for RV v4.0.
