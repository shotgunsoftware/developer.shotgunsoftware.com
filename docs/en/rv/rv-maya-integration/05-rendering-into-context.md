---
layout: default
title: Rendering into Context
permalink: /rv/rv-maya-integration/05-rendering-into-context/
lang: en
---

# Rendering into Context

Don’t forget that you can also bring in supplementary media to compare or use as reference for your animation. So for example you might bring in takes of the shots on either side of the one you’re animating, and assemble a 3-shot sequence with one of your playblasts in the middle. But as you work, you’d like that middle shot to be replaced by newer playblasts. We call that “rendering into context”.

In general, to prepare to render into context, after you setup your views, you’d:

1. Turn off the *View Latest Playblast* option in the *Maya* menu.
2. Select (in the Session Manager) the previously-rendered playblast you want to swap out for new ones
3.  Pick the *Mark Selected as Target* item on the *Maya* menu.

Henceforth, future playblasts will be swapped into the slot occupied by the one you just marked. Possible “render into context” workflows include:

**Your shot in the cut**

Load the shots before and after yours and make a Sequence view. Note that you can trim shots by adjusting the in/out points on the timeline in the Source view.

**Wipe between the latest playblast and a previous take, or reference footage**

Add one or more sources (or use a previous playblast). Make a Stack view. Order the Stack to your liking by dragging and dropping in the Inputs section of the Session Manager. Turn on Wipes (Tools menu).

**Tile newest playblast with one or more others, reference footage, etc**

Add one or more sources (or use a previous playblast). Make a Layout view. Select Tile/Column/Row (or even arrange by hand with the Manual mode) from the *Layout* menu. Arrange the Layout to your liking by dragging and dropping in the Inputs section of the Session Manager.
