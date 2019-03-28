---
layout: default
title: RV/Nuke Integration
permalink: /rv/rv-nuke-integration/
lang: en
---

# RV/Nuke Integration (v1.10)

© 2011 [Tweak Software](http://tweaksoftware.com/)

## Introduction

Rather than just attach a “flipbook” to Nuke, the goal of this integration effort is to provide compositors with a unified framework in which RV’s core media functionality (playback, browsing, arranging, editing, etc) is always instantly available to augment and enhance Nuke’s own capabilities.

Key features include:

* Checkpointing: Save a rendered frame with a copy of the current nuke script
* Rendering: Save a rendered sequence with a copy of the current nuke script
* Background rendering in Nuke 6.2 **and** 6.1
* Live update of RV during renders, showing the latest frame rendered
* Rendered frames visible in RV as soon as they are written
* Rendered frames from canceled renders are visible
* Render directly into a slap comp or sequence in RV
* Full checkpoints: copies of entire ranges of frames, for comparison
* Visual browsing of checkpoints and renders
* Visual comparison (wipes, tiled) of checkpoints and renders
* Restoring the script to the state of any checkpoint or render
* Read and Write nodes in the script dynamically mirrored as sources in RV
* Read/Write node path, frame range, color space dynamically synced to RV
* Node selection dynamically synced to the View in RV
* Frame changes in Nuke dynamically synced to RV frame
* RV Sources can be used to create the corresponding Nuke Read node
* All Render/Checkpoint context retained in session file on disk
* Support for `%V`-style stereoscopic Reads, Writes, renders, and checkpoints.
