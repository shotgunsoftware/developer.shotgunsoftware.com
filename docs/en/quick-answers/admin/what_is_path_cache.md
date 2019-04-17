---
layout: default
title: What is the path cache?
permalink: /quick-answers/admin/what_is_path_cache/
lang: en
---

What is the Path Cache? What are Filesystem Locations?
==

The path cache is used by Toolkit to track the associations between folders on disk and entities in Shotgun. 
The master cache is stored in Shotgun using the `FilesystemLocation` entity type. Each user then has their own version 
of the path cache [stored locally in the Toolkit cache directory on disk](./where_is_my_cache.md), which is synchronized in the background 
whenever applications are launched or folders are created.

Typically, we don't advise modifying the path cache manually. Our internal processes not only sync your local cache 
with the FilesystemLocation entities in Shotgun, but also create event log entries that allow all users'
 machines to stay in sync with Shotgun. 

There are a couple tank commands that can be used to modify the path cache:

 - `tank unregister_folders` removes path cache associations.
 - `tank synchronize_folders` forces a sync of the local path cache with Shotgun.
 
Typically you won't need to run either of these commands, but in certain circumstances, they can be useful.
 For example, `unregister_folders` should be run before renaming or recreating an entity in your project. 