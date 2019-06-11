---
layout: default
title: Does Shotgun Desktop run on Debian systems like Ubuntu?
pagename: sg-desktop-run-on-ubuntu
lang: en
---

# Does Shotgun Desktop run on Debian systems like Ubuntu?

We don't currently support Debian based distros for Shotgun Desktop. We have some clients in the past who have tried to get 
it working, extracting Desktop from the RPM using cpio and then trying to satisfy the library dependencies but this has 
had relatively poor results. For reference, 
[you can check out this thread](https://groups.google.com/a/shotgunsoftware.com/d/msg/shotgun-dev/nNBg4CKNBLc/naiGlJowBAAJ).

Please note that we don't have an explicit list of lib dependencies, since Python itself sits on top of a lot of 
system level libraries.

We don't have official plans for Debian support at the moment. There is the problem of building for Ubuntu, 
but then there is the need to QA and support the extra operating system as we make changes, which isn't at all trivial.

If you want to run and activate Toolkit manually without Shotgun Desktop ([as explained in the doc here](https://support.shotgunsoftware.com/hc/en-us/articles/219033208#Step%208.%20Run%20the%20activation%20script),) - please 
download the `activate_shotgun_pipeline_toolkit.py` script from that documentation page - it's in step 8 of the guide,
 click the "click to download..." header.