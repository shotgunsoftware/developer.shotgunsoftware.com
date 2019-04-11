---
layout: default
title: Where is my cache
permalink: /quick-answers/admin/where_is_my_cache.md
lang: en
---

Root Cache Location
==

Toolkit stores some data in a local cache to prevent unnecessary calls to the Shotgun server. This includes the path cache, bundle cache, and thumbnails. While the default location should work for most users, it is configurable using the cache_location core hook should you need to change it. 

The default cache root location is:

**Mac OS X**

`~/Library/Caches/Shotgun`

**Windows**

`%APPDATA%\Shotgun`

**Linux**()

`~/.shotgun`

Thumbnails
==
 
Thumbnails used by Toolkit apps (like the Loader) are stored in the local Toolkit cache. They are stored per Project, Pipeline Configuration, and App (as needed). The structure beneath the root cache directory is as follows:

`<site_name>/p<project_id>c<pipeline_configuration_id>/<app_or_framework_name>/thumbs/`

Path Cache
==
The path cache is located at:

`<site_name>/p<project_id>c<pipeline_configuration_id>/path_cache.db`

Bundle Cache
=

**Distributed Configurations**

The bundle cache is a cached collection of all the applications, engines, and frameworks used across all of the 
projects on your Shotgun site. The bundle cache for distributed configs is stored in the following location:

Mac:
`~/Library/Caches/Shotgun/bundle_cache`

Windows:
`%APPDATA%\Shotgun\bundle_cache`

Linux:
`~/.shotgun/bundle_cache`

Note that you can override these locations with the `SHOTGUN_BUNDLE_CACHE_PATH` environment variable, so specific 
implementations may vary.

**Centralized Configurations**

The bundle cache for centralized configs are located inside the centralized configuration.

`...{project configuration}/install/` 

If your configuration uses a shared core, then this will be located inside your shared core's install folder instead.