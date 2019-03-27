---
layout: default
title: Checkpoints and Renders
permalink: /rv/rv-nuke-integration/06-checkpoints_and_renders/
lang: en
---

# Checkpoints and Renders

As with Read nodes, Checkpoints and Renders are representations in RV of particular nodes in Nuke. So the Frame and Selection syncing described in the Read Nodes section applies to Checkpoints and Renders as well.

Unlike Read nodes, the media associated with Checkpoints and Renders are generated from the Nuke script and so reflect the state of the script at the time of rendering.

## Checkpoints

The point of a Checkpoint is to to visually label a particular point in your projects development, so that you can easily return to that point if you want to. When you’ve made some changes in your script, and reach a point where you want to go in another direction, or try something out, or work on a different aspect of the project, that’s a good time to “bookmark” your work with a Checkpoint.

To make a Checkpoint, select a node that visually reflects the state of the script and select *RV/Create Checkpoint*. You’ll see a new Source appear in RV, in a Folder named for the node you selected, with a single rendered frame from that node.

As you work on a particular aspect of your project, you may want to make many Checkpoints of a particular node, so that you can easily compare the visual effect of different parameter settings. They’ll all be collected in a single folder in the Session Manager, and as with Read nodes, you can double click on a single one to view it, or double click on the folder itself to see them all.

## Rendering

A Render is similar to a Checkpoint, but involves rendering a sequence of frames, instead of just one. To render, select the node of interest, then select *RV/Render to RV*. You’ll get a dialog with some parameters:

| | |
|-|-|
| Output Node | The name of the node to be rendered. |
| Use Selected | If checked, the output node will always be equal to whatever node is selected when the dialog is shown. If unchecked, the output node will “stick” and not be affected by the selection. |
| First Frame | The first frame in the sequence to be rendered. |
| Last Frame | The last frame in the sequence to be rendered. |

Since Renders can occupy significant disk space, successive renders of the same node overwrite any pre-existing render. But each render also automatically generates a single-frame Checkpoint of the same Nuke state. Also, deleting a Render or Checkpoint in the Session Manager (with the Trash Can button), also removes the corresponding media from disk.

During a Render, RV updates dynamically to show you all the frames rendered so far. If the render is canceled, you still see in RV any frames that completed before the cancel. RV Sources from renders go into the same Folder as Checkpoints from the same node.

## Full Checkpoints

A Full Checkpoint is just like a regular checkpoint except that an entire sequence of frames is saved. To create a Full Checkpoint, select a Render in the RV Session Manager and then select *Create Full Checkpoint* from the *Nuke* menu in RV.
