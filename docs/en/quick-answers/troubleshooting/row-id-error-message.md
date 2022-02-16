---
layout: default
title: Could not resolve row id for path!
pagename: row-id-error-message
lang: en
---

# Could not resolve row id for path!

## Related error messages:

- Could not resolve row id for path!
- Database concurrency problems: The path `<PATH>` is already associated with {% include product %} entity `<ENTITY>`.

## Example:

A Toolkit user is getting the error “Could not resolve row id for path!” when they create folders.

Oddly, this is creating FileSystemLocation entities, but sometimes resulting in duplicates, which can cause a whole host of problems.

The full error looks something like:

```
Creating folders, stand by...

ERROR: Could not resolve row id for path! Please contact support! trying to 
resolve path '\\server\nas_production\CLICK\00_CG\scenes\Animation\01\001'. 
Source data set: [{'path_cache_row_id': 8711, 'path': 
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001', 
'metadata': {'type': '{% include product %}_entity', 'name': 'sg_scenenum', 'filters': 
[{'path': 'sg_sequence', 'values': ['$sequence'], 'relation': 'is'}], 
'entity_type': 'Shot'}, 'primary': True, 'entity': {'type': 'Shot', 'id': 
1571, 'name': '001_01_001'}}, {'path_cache_row_id': 8712, 'path': 
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001\\Fx', 
'metadata': {'type': '{% include product %}_step', 'name': 'short_name'}, 'primary': True, 
'entity': {'type': 'Step', 'id': 6, 'name': 'FX'}}, {'path_cache_row_id': 
8713, 'path': 
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001\\Comp',
```
_note: it can go on much longer than that._

## What’s causing the error?

This error is pointing to a mismatch between the storage roots as specified in {% include product %} (Site Prefs -> File Management) and c`onfig/core/roots.yml` in the Pipeline Configuration.

It often comes up because of a case mismatch in studios running Windows. Their paths are case-insensitive, but our configs are case-sensitive. A difference as simple as `E:\Projects` vs `E:\projects` can cause this error.

## What’s happening behind the scenes?

The code creates the FilesystemLocation entity in {% include product %} for the path it just created, using {% include product %}’s storage roots to determine the root for the path. Then, it goes to create the same entry in the local cache, and has to determine where to put it in the database. For the local cache, it uses `roots.yml` to determine the root for the path, and because of the case mismatch, the path it generates doesn’t match what was just entered in {% include product %}. At this point, it throws the error.

It’s especially bad because it doesn’t error cleanly: the folders are created, the FilesystemLocation entries are created, they are not synced in the local path cache, nor will they ever be able to be synced because of the storage root mismatch.

## How to fix

First, make sure the storage root paths in the Site Prefs match the paths in `config/core/roots.yml`. Fixing the mismatch should make the error go away in subsequent folder creation calls.

Then, clear the bad FilesystemLocation entities. If you can narrow down to a set of errant FilesystemLocation entities, just remove those. In a lot of cases though, all of the paths for a project are compromised, so they all need to go.

- How to clear the FilesystemLocation entities: ideally you can run `tank unregister_folders`. To clear all of them, run tank `unregister_folders --all`. (For all the options for `tank unregister_folders`, just run it with no arguments and it will output usage notes.)
- However, because the db is already in a wonky state, this may not work, or may only partially work. Once you’ve run the command, go back to FilesystemLocations in {% include product %}, and confirm that what you expected to be deleted is actually gone. If not, select the bad entities, and move them to trash manually.

At this point, the FilesystemLocations in {% include product %} are clean, but artists’ local caches may not reflect your changes. The last step is to actually sync the local cache on each user’s machine. To do this, they should run tank `synchronize_folders --full`.

Once all those steps are taken, the path cache should be in a good state, and that errors shouldn’t appear anymore.

## Related links

- [Here’s the code in question](https://github.com/shotgunsoftware/tk-core/blob/01bb9547cec19cc2a959858b09a8b349a388b56f/python/tank/path_cache.py#L491-L498)
- [What is the path cache? What are Filesystem Locations?](https://developer.shotgridsoftware.com/cbbf99a4/)

[See the full thread in the community](https://community.shotgridsoftware.com/t/how-to-troubleshoot-folder-creation-errors/3578).

