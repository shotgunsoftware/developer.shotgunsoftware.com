---
layout: default
title: Performance Troubleshooting
pagename: performance_troubleshooting
lang: en
---

# Performance Troubleshooting

You may come across situations where Toolkit usage can become slow. There can be many reasons for encountering this, ranging from issues with the client side infrastructure such as server speeds or internet connection to configuration based issues where Toolkit or Shotgun is not configured in a performant way, to areas of our code that could use further optimization.

Here is a quick list of things to check which we cover in further detail below:

- Make sure your Apps, engines, frameworks, core, and Desktop are up to date.
- Ensure [debug logging](./turn-debug-logging-on.md) is not enabled during general use.
- Only create the folders that you need to, and limit folders so they are only created when they are actually needed. Adding too many folders to your schema will slow things down.
- Storing your user caches on a server can be slow. You can redirect the user’s Shotgun cache by setting the [`SHOTGUN_HOME` environment variable](https://developer.shotgunsoftware.com/tk-core/initializing.html#environment-variables) to point to a location on your local drive.
- Configure the workfiles and loader apps to filter out content that is not needed by the artist. Consider filtering by statuses to help keep the list of entities short and relevant to the artist’s current tasks.
- Check to see if you have any custom hooks and that they are not adding additional overhead.

Below is a list of good practices and common slow down scenarios. This is not an exhaustive list and we will try to add to it as and when we see new patterns. If this guide doesn’t help you get to the bottom of the problem you’re facing, then please feel free to pop a [support ticket](https://support.shotgunsoftware.com/hc/en-us/requests/new) in and our team will be happy to assist you further.

Table of Contents:
1. [General good practice](#general-good-practice)
    - Cache Location
    - Keeping up to date
    - Centralized configs vs distributed configs
    - Debugging
2.Launching software is slow
    - Diagnosis
    - Is the issue pre or post launch?
    - Checking the logs
    - Common causes of slow software launches
3. File Open, File Save, or the Loader app is slow?
4. Folder Creation is slow
    - Tackling I/O usage
    - Registering folders

## General good practice

### Cache Location

Shotgun Toolkit [caches data to the user’s home directory](../administering/where-is-my-cache.md). This cache can include a number of different SQLite databases as well as cached apps and configs. Normally the user’s home directory is stored on the machine’s local hard drives, but it's fairly common for studios to redirect them to network storage. Doing this can impact performance—most notably to the SQLite databases, which are used for browser integration and folder creation/lookup among other things. 

If your user directories are stored on a server location, we recommend repathing the Shotgun Toolkit cache using the `SHOTGUN_HOME` environment variable. The `SHOTGUN_HOME` environment variable is used to set the location where Toolkit caches various data, such as the bundle cache, thumbnails, SQLite databases used for fast lookup of data and other things.

### Debugging
You can enable debug logging in Shotgun Toolkit, so that you can get more verbose output from the various processes. This can be incredibly useful when trying to diagnose issues, however, the debug setting is not designed to be enabled during normal everyday use. The increase in logging output can significantly impact performance. 

When encountering performance issues, especially ones that are localized to specific machines or users, first check that debug logging isn’t enabled.
### Keeping up to date
If you’re encountering performance issues, check that your core, apps, engines, and frameworks are up to date, as there may already be fixes or optimizations available in newer releases.
