---
layout: default
title: How do I set up a desktop/launcher icon for Shotgun Desktop on Linux?
pagename: create-shotgun-desktop-shortcut
lang: en
---

# How do I set up a desktop/launcher icon for {% include product %} Desktop on Linux?

The current {% include product %} Desktop installer doesn't automatically create shortcuts and launch entries, so you have to manually go in and do this afterwards. It's straightforward and may differ depending on which flavour of Linux you are using. 

Once you have run the {% include product %} desktop installer, the {% include product %} Desktop executable will be located in the `/opt/Shotgun folder`. The name of the executable is {% include product %}.
No icon is distributed with the installer. Download it from the [{% include product %} Desktop engine github repository](https://github.com/shotgunsoftware/tk-desktop/blob/aac6fe004bd003bf26316b9859bd4ebc42eb82dc/resources/default_systray_icon.png).
Once you have downloaded the icon and have the path to the executable (`/opt/Shotgun/Shotgun`), please manually create any desktop or menu launchers you may require. The process for doing this varies depending on the version of Linux, but you can typically create a desktop launcher by right clicking on the Desktop and looking for a suitable menu option there.