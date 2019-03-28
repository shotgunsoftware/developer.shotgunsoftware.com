---
layout: default
title: Installation
permalink: /rv/rv-nuke-integration/installation/
lang: en
---

# Installation

Note that the first ingredient of a successful install is RV 3.12.12 or later, and Nuke 6.1v1 or later. Once you have those installed, the rest of the installation goes like this:

# Personal Installation

1. Start RV and go to the *Packages* tab of the *Preferences* dialog
2. Find *Nuke Integration* in the Package list and click the *Load* toggle next to it.
3. Restart RV
4. Click the *Nuke* item on the *Tools* menu
5. From the *Nuke* menu, select the *Install Nuke Support Files* item and follow the directions.

To confirm that the Nuke support files are properly installed, start Nuke. You should see an *RV* menu on the main menubar, and if you select *RV/Preferences…*, you should get the appropriate dialog.

That’s it for installation!

## Site-wide Installation

In what follows we suppose that you’ve installed RV in `/usr/local/tweak/rv-3.12.12`, and that you keep your Nuke scripts in subdirectories of `/usr/local/nuke/scripts`. If you do otherwise please adjust the paths below appropriately.

1. Make a subdir in your Nuke scripts area for the rvnuke support files:

```
% mkdir /usr/local/nuke/scripts/rvnuke
```
2. Copy the Nuke support files into place

```
% cp /usr/local/tweak/rv-3.12.12/plugins/SupportFiles/rvnuke/* /usr/local/nuke/scripts/rvnuke
```
3. Edit the `init.py` file in `/usr/local/nuke/scripts` to include this line:

```
nuke.pluginAddPath('./rvnuke')
```
Done!
