---
layout: default
title: How can I disable the Shotgun Desktop's browser integration?
pagename: disable-browser-integration
lang: en
---

# How can I disable the Shotgun Desktop's browser integration?

To disable the browser integration, follow these two simple steps.

1. Create or open the text file at

```
Windows: %APPDATA%\Shotgun\preferences\toolkit.ini
Macosx: ~/Library/Preferences/Shotgun/toolkit.ini
Linux: ~/.shotgun/preferences/toolkit.ini
```

2. Add the following section:

```
[BrowserIntegration]
enabled=0
```

Complete instructions on how to configure the browser integration are located [here](https://support.shotgunsoftware.com/entries/95442748-Initial-Setup-and-Configuration#Advanced%20Installation%20Topics).

