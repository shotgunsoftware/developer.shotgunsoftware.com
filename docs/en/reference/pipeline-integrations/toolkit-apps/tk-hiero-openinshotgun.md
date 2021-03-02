---
layout: default
title: Hiero/Nuke Studio Open in Shotgun
pagename: tk-hiero-openinshotgun
lang: en
---

# Hiero/Nuke Studio Open in {% include product %}

This app adds a context menu to the Hiero spreadsheet and timeline that allows you to 
open a given track item in {% include product %} if there is a Shot for that item.

![open_in_shotgun](../images/apps/hiero-open_in_shotgun.png)

You typically configure this app by adding it to the time line and spreadsheet menus in 
Hiero by adding the following to the {% include product %} Engine for Nuke configuration:

```yaml
    timeline_context_menu:
    - {app_instance: tk-hiero-openinshotgun, keep_in_menu: false, name: "Open in {% include product %}", requires_selection: true}
    spreadsheet_context_menu:
    - {app_instance: tk-hiero-openinshotgun, keep_in_menu: false, name: "Open in {% include product %}", requires_selection: true}
```



