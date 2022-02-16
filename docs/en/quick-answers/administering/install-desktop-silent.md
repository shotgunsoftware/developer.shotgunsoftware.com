---
layout: default
title: How do I install the ShotGrid Desktop silently on Windows?
pagename: install-desktop-silent
lang: en
---

# How do I install the {% include product %} Desktop silently on Windows?

To run the {% include product %} Desktop installer silently, simply launch the {% include product %} Desktop installer the following way:

`ShotgunInstaller_Current.exe /S`

If you wish to also specify the installation folder, launch it with the `/D` argument:

`ShotgunInstaller_Current.exe /S /D=X:\path\to\install\folder.`

{% include info title="Note" content="The `/D` argument must be the last argument and no `\"` should be used in the path, even if there are spaces in it." %}