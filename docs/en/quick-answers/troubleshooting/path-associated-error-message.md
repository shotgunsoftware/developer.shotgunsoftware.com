---
layout: default
title: The path `<PATH>` is already associated with {% include product %} entity `<ENTITY>`
pagename: path-associated-error-message
lang: en
---

# Database concurrency problems: The path `<PATH>` is already associated with {% include product %} entity `<ENTITY>`

## Related error messages:

- Database concurrency problems: The path `<PATH>` is already associated with {% include product %} entity `<ENTITY>`.
- Could not resolve row id for path!

## Example:
This error occurs when a Toolkit user tries to create folders. Here’s the full error:

The full error looks something like:

```
ERROR: Database concurrency problems: The path
'Z:\projects\SpaceRocks\shots\ABC_0059' is already associated with
Shotgun entity {'type': 'Shot', 'id': 1809, 'name': 'ABC_0059'}. Please re-run
folder creation to try again.
```
## What’s causing the error?
It happens when you’re in a state where you’re trying to create a FilesystemLocation entity for a folder that already has one.

## How to fix
Clear the bad FilesystemLocation entities. If you can narrow down to a set of errant FilesystemLocation entities, just remove those. In a lot of cases though, all of the paths for a project are compromised, so they all need to go.

- How to clear the FilesystemLocation entities: ideally you can run `tank unregister_folders`. To clear all of them, run tank `unregister_folders --all`. (For all the options for `tank unregister_folders`, just run it with no arguments and it will output usage notes.)
- However, because the db is already in a wonky state, this may not work, or may only partially work. Once you’ve run the command, go back to FilesystemLocations in {% include product %}, and confirm that what you expected to be deleted is actually gone. If not, select the bad entities, and move them to trash manually.

At this point, the FilesystemLocations in {% include product %} are clean, but artists’ local caches may not reflect your changes. The last step is to actually sync the local cache on each user’s machine. To do this, they should run tank `synchronize_folders --full`.

Once all those steps are taken, the path cache should be in a good state, and that errors shouldn’t appear anymore.

## Related links
- [Here’s the code in question](https://github.com/shotgunsoftware/tk-core/blob/01bb9547cec19cc2a959858b09a8b349a388b56f/python/tank/path_cache.py#L491-L498)
- [What is the path cache? What are Filesystem Locations?](https://developer.shotgridsoftware.com/cbbf99a4/)

[See the full thread in the community](https://community.shotgridsoftware.com/t/how-to-troubleshoot-folder-creation-errors/3578).

