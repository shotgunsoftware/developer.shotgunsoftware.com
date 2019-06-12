---
layout: default
title: Where is my cache?
pagename: where-is-my-cache
lang: en
---

# Where is my cache?

Toolkit stores some data in a local cache to prevent unnecessary calls to the Shotgun server. This includes the [path cache](./what_is_path_cache.md), bundle cache, and thumbnails. While the default location should work for most users, it is configurable using the [cache_location core hook](https://github.com/shotgunsoftware/tk-core/blob/master/hooks/cache_location.py) should you need to change it. 

The default cache root location is:

**Mac OS X**

`~/Library/Caches/Shotgun`

**Windows**

`%APPDATA%\Shotgun`

**Linux**

`~/.shotgun`

# Thumbnails 

Thumbnails used by Toolkit apps (like the [Loader](https://support.shotgunsoftware.com/entries/95442527)) are stored in the local Toolkit cache. They are stored per Project, Pipeline Configuration, and App (as needed). The structure beneath the root cache directory is as follows:

`<site_name>/p<project_id>c<pipeline_configuration_id>/<app_or_framework_name>/thumbs/`

# Path Cache

The path cache is located at:

`<site_name>/p<project_id>c<pipeline_configuration_id>/path_cache.db`
