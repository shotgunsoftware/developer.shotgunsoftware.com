---
layout: default
title: Where is my cache?
pagename: where-is-my-cache
lang: en
---

# Where is my cache?


## Root Cache Location

Toolkit stores some data in a local cache to prevent unnecessary calls to the Shotgun server. This includes the [path cache](./what-is-path-cache.md), bundle cache, and thumbnails. While the default location should work for most users, it is configurable using the [cache_location core hook](https://github.com/shotgunsoftware/tk-core/blob/master/hooks/cache_location.py) should you need to change it. 

The default cache root location is:

**Mac OS X**

`~/Library/Caches/Shotgun`

**Windows**

`%APPDATA%\Shotgun`

**Linux**

`~/.shotgun`

## Path Cache

The path cache is located at:

`<site_name>/p<project_id>c<pipeline_configuration_id>/path_cache.db`

## Bundle Cache

**Distributed Configurations**

The bundle cache is a cached collection of all the applications, engines, and frameworks used across all of the 
projects on your Shotgun site. The bundle cache for distributed configs is stored in the following location:

Mac:
`~/Library/Caches/Shotgun/bundle_cache`

Windows:
`%APPDATA%\Shotgun\bundle_cache`

Linux:
`~/.shotgun/bundle_cache`

{% include info title="Note" content="You can override these locations with the `SHOTGUN_BUNDLE_CACHE_PATH` environment variable, so specific implementations may vary." %}

**Centralized Configurations**

The bundle cache for centralized configs are located inside the centralized configuration.

`...{project configuration}/install/` 

If your configuration uses a shared core, then this will be located inside your shared core's install folder instead.

## Thumbnails
 
Thumbnails used by Toolkit apps (like the [Loader](https://support.shotgunsoftware.com/entries/95442527)) are stored in the local Toolkit cache. They are stored per Project, Pipeline Configuration, and App (as needed). The structure beneath the root cache directory is as follows:

`<site_name>/p<project_id>c<pipeline_configuration_id>/<app_or_framework_name>/thumbs/`
