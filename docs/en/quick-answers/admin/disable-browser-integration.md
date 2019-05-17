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

Complete instructions on how to configure the browser integration are located [here](https://support.shotgunsoftware.com/hc/en-us/articles/115000067493-Integrations-Admin-Guide#Toolkit%20Configuration%20File).

**Alternate Method**

If you've taken over your Toolkit pipeline configuration, an alternative would be to remove the [`tk-shotgun` engine from your environments](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/project.yml#L48) so that it can't load any actions.