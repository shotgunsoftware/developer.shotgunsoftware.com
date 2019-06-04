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

If your user directories are stored on a server location, we recommend repathing the Shotgun Toolkit cache using the [`SHOTGUN_HOME` environment variable](https://developer.shotgunsoftware.com/tk-core/initializing.html#environment-variables). The `SHOTGUN_HOME` environment variable is used to set the location where Toolkit caches various data, such as the bundle cache, thumbnails, SQLite databases used for fast lookup of data and other things.

### Debugging

You can enable debug logging in Shotgun Toolkit, so that you can get more verbose output from the various processes. This can be incredibly useful when trying to diagnose issues, however, the debug setting is not designed to be enabled during normal everyday use. The increase in logging output can significantly impact performance. 

When encountering performance issues, especially ones that are localized to specific machines or users, first check that [debug logging](./turn-debug-logging-on.md) isn’t enabled.

### Keeping up to date

If you’re encountering performance issues, check that your core, apps, engines, and frameworks are up to date, as there may already be fixes or optimizations available in newer releases.

### Centralized configs vs distributed configs

There are two different ways of setting up advanced Toolkit configurations: [centralized and distributed](https://developer.shotgunsoftware.com/tk-core/initializing.html#the-toolkit-startup). The key differences are that the centralized configs typically live on your studio’s network storage where they can be accessed by all users, and the distributed configs are usually stored in the cloud and get cached locally per user. 

Whilst the differences between these two methods extend beyond performance, they can both bring performance benefits and disadvantages. Here is a table showing the pros and cons, purely from a performance standpoint.

|                     | Advantages                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Disadvantages                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Centralized Configs | Once the initial setup process is complete, it will have everything it needs already downloaded and ready to go for all users.<br/><br/>Future updates only need to be downloaded once to the centralized location.                                                                                                                                                                                                                                                                          | Centralized configs are usually kept on network storage; therefore the performance can be degraded during normal Toolkit usage.<br/><br/>Toolkit configurations contain many small files, and handling metadata operations on lots of small files can be a lot slower and harder for servers. Also, heavy read operations both through the use of Toolkit or through general use of the server may impact Toolkit’s performance by not being able to read the configuration as quickly. |
| Distributed Configs | The cached apps, engines, frameworks, and cores are stored in such a way that they can be shared with other locally cached configs. This means subsequent loading of different projects will likely be faster to cache if they share the same dependencies.<br/><br/>They are stored in the user’s cache on their local hard drive and thus normally perform better than server speeds. This means that after the initial cache, the performance should be better than a centralized config. | Distributed configs need to be cached locally per user. Usually, this involves downloading the config and all the required apps, engines, frameworks, and core.<br/><br/>The process happens seamlessly behind the scenes, but there is still the initial cost of downloading these.<br/><br/>Every time the config gets updated to point to new versions of the dependencies, both the config and the new dependencies will need to be cached.                                         |

In summary, if you have slow storage but a reasonable internet connection, then distributed configs maybe the best answer, but if you have good server storage performance and poor internet, then a centralized config might be more suitable.

{% include info title="Note" content="If you are interested in the distributed configs but are concerned about downloading the dependencies per machine, it is possible to centralize just your bundle cache so that it is shared among all users." %}

When using distributed configs, a user will only have to download something if it is not already found in the cache, and once one user has downloaded it, others will be able to benefit from it as well. To achieve this you can set the [`SHOTGUN_BUNDLE_CACHE_PATH` environment variable](https://developer.shotgunsoftware.com/tk-core/initializing.html#environment-variables) on each machine to point to the shared location.

## Launching software is slow

You may notice that when launching software such as Maya, Nuke, Houdini, or others, they take longer to start up than without Shotgun. It is normal that they may take a short while longer than without Shotgun, but sometimes these times can increase to unacceptable levels, (normally depending on the software we would expect them to startup in under a minute). This can be one of the more tricky areas to diagnose as there are many processes involved in launching the software.

### Diagnosis
The first thing you should do is figure out under what conditions this is happening.

1. **Is it slow when launching without Shotgun?** - This might seem obvious, but it’s worth checking that the issue only occurs when launching with Shotgun.
2. **Is it slow regardless of which approach you use to launch, i.e., is it about the same if you launch from SG Desktop, or from the SG site using the browser integration?** - If it's slow launching from the Shotgun site but not from SG Desktop, then it could be an issue with the browser integration, or it could point to issues creating the folders on disk. If you’re launching from a context other than a Project, then it will likely be creating more folders on disk so this might explain where the time is taken. It’s also worth noting that we check for the existence of the required folders every time software is launched.
3. **Does it happen on all projects?** - If it doesn't, then it’s likely to be something specific to the way the configuration is setup.
4. **Does this happen at specific points in the day?** - If so, then this could point to high demand on the infrastructure, such as server usage being higher at certain times of the day.
5. **Does this happen for all Machines/OSs used?** - If a particular machine is slow, then it's possible there is something outside of Toolkit that is causing the issues. However, clearing the Toolkit cache on that machine is a good first step. Different OSs come with different versions of software and Python packages, and sometimes performance issues can crop up on specific builds. Specifically we have seen issues with performance on Windows using Samba (SMB) shares. There isn’t a fix for this as such, but it’s good to be aware of if you are using it.
If you believe the issue is limited to a certain OS, Python package, or software version then please let our [support team](https://support.shotgunsoftware.com/hc/en-us/requests/new) know so they can investigate further.
6. **Does this happen for all users?** - Similar to above, it’s possible that as a different user on the same machine, the issue might disappear. In this situation, start by clearing the user’s local Shotgun cache. Also, make sure debug logging is not enabled for normal production use, as this will impact performance.
7. **Is the slow launching exclusive to a specific app/software or are all apps/software launched abnormally slow?** - If specific software is slow to launch, this might mean that there is a configuration issue. It may be worth checking to see if you have any custom hooks set up to run either before or after launch that might be impacting performance. Common hooks used in start up are [`before_app_launch.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/master/hooks/before_app_launch.py), [`app_launch.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/master/hooks/app_launch.py), and the core hook [`engine_init.py`](https://github.com/shotgunsoftware/tk-core/blob/master/hooks/engine_init.py). There can also be occurrences from time to time where a newer version of software is released and our integrations are suddenly much slower to start. In this situation, you should reach out to [support](https://support.shotgunsoftware.com/hc/en-us/requests/new) to check if they are aware of this, and if there is any known fix. Please provide the version number of the software your using (including patches/service pack if applicable) and the version of the tk engine and core you’re running.