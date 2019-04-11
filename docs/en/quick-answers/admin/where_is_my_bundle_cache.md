---
layout: default
title: Where is my bundle cache
permalink: /quick-answers/where_is_my_bundle_cache.md
lang: en
---

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