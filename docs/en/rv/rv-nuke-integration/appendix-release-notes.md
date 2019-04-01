---
layout: default
title: Release Notes
permalink: /rv/rv-nuke-integration/appendix-release-notes/
lang: en
---

# Appendix: Release Notes

## Version 1.9, released 12/17/13, with RV 4.0.10

* Updated for RV v4.0.

## Version 1.7, released 10/19/11, with RV 3.12.12

* Bracket all RV media changes with caching threads halt/restart, which prevents at least one crash.
* Handle case of “offset” frame ranges in Read node with synced corresponding rangeOffset on RV side.
* Don’t restrict render frame range to that of node, since it seems the global range is often more correct (in future need choice).
* Get better frame ranges for Read/Write viewing to prevent single-frame source on RV side.
* Cleaner disconnect in the case where RV shuts down first.
* Don’t restart RV automatically after crash or other unexpected exit.

## Version 1.6, released 9/26/11, with RV 3.12.11

* Update for python-enabled RV 3.12.11

## Version 1.5, released 5/8/11

* Support for proxy-mode output for checkpoints and renders.

## Version 1.4, released 4/7/11, with RV 3.10.13

* Full support for `%Vv`-style stereoscopy, including checkpoints and renders.
* View Write nodes similarly to Read nodes.
* Better error handling during batch render, disconnect.
* *Session Dir Base* preference to specify root directory for new session directories.
* Newlines in labels no longer cause a problem for checkpointing.

## Version 1.3, released 2/28/11, with RV 3.10.11

* R3D files no longer crash rv.
