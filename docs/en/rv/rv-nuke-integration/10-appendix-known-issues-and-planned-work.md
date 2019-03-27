---
layout: default
title: Appendix: Known Issues and Planned Work
permalink: /rv/rv-nuke-integration/10-appendix-known-issues-and-planned-work/
lang: en
---

# Appendix: Known Issues and Planned Work

## Known Issues

* Duplicate Nuke node names confuse RV (but they confuse Nuke too …)
* There are several “frame number mapping” problems that we’re investigating.

If you find a bug, please send us [email](mailto:support@shotgunsoftware.com).

## Next Round

* Hotkeys for appropriate RV menu items in Nuke
* “Redo Last Checkpoint” item/button
* “Redo Last Render” item/button
* Checkpoint/Render multiple nodes

## Future Work

* Add sorting in session-manager, to sort by timestamp/type
* RV core: add reload only new/changed frames, use during render updates
* Set RV display color settings from Nuke viewer color settings
* Per render-node prefs (audio or not, stereo, frame-range)
* Store audio file / offset in Nuke project settings
* Copy input color (linearizing) settings from RV sources to created Read nodes in Nuke
* Nuke panel (not dialog) with sync controls, quick checkpoint button, ?
* Optionally push current frame number from RV to Nuke
* Set viewer input in Nuke from current view in RV
* Optionally restore checkpoint to a new Nuke session
* Handle creating stereo Reads in Nuke from “browsed” stereo sources in RV
* Mark/group checkpoints that are associated with same Nuke script
* Popup warning dialog when render/checkpoint (and media) is deleted
* Adjust audio offset in renders with audio according to frame range
* Create pre-comps in RV, transfer to Nuke
* Color adjustments in RV, transfer to Nuke
* Manage (proxy of) final comp (over) in RV
