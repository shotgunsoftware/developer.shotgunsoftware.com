---
layout: default
title: How do I install the Shotgun Desktop silently on Windows?
permalink: /quick-answers/admin/install_desktop_silent/
lang: en
---

To run the Shotgun Desktop installer silently, simply launch the Shotgun Desktop installer the following way:

`ShotgunInstaller_Current.exe /S`

If you wish to also specify the installation folder, launch it with the /D argument:

`ShotgunInstaller_Current.exe /S /D=X:\path\to\install\folder.`

Note that the `/D` argument must be the last argument and no `"` should be used in the path, even if there are spaces in it.