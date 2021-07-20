---
layout: default
title: Performance Troubleshooting
pagename: performance-troubleshooting
lang: en
---

# Performance troubleshooting

You may come across situations where Toolkit usage can become slow. There can be many reasons for encountering this, ranging from issues with the client side infrastructure such as server speeds or internet connection, to configuration based issues where Toolkit or {% include product %} is not configured in a performant way, to areas of our code that could use further optimization.

Here is a quick list of things to check which we cover in further detail below:

- Make sure your apps, engines, frameworks, core, and {% include product %} Desktop [are up to date](#keeping-up-to-date).
- Ensure [debug logging](./turn-debug-logging-on.md) is not enabled during general use.
- Only [create the folders that you need to](#folder-creation-is-slow), and limit folders so they are only created when they are actually needed. Adding too many folders to your schema will slow things down.
- Storing your user caches on a server can be slow. You can redirect the user’s {% include product %} cache by setting the [`{% include product %}_HOME` environment variable](https://developer.shotgridsoftware.com/tk-core/initializing.html#environment-variables) to point to a location on your local drive.
- [Configure the workfiles and loader apps](#file-open-file-save-or-the-loader-app-is-slow) to filter out content that is not needed by the artist. Consider filtering by statuses to help keep the list of entities short and relevant to the artist’s current tasks.
- Check to see if you have any custom hooks and that they are not adding additional overhead.

Below is a list of good practices and common slow down scenarios. This is not an exhaustive list and we will try to add to it as and when we see new patterns. If this guide doesn’t help you get to the bottom of the problem you’re facing, then please feel free to submit a [support ticket](https://support.shotgunsoftware.com/hc/en-us/requests/new) in and our team will be happy to assist you further.

Table of Contents:
- [General good practice](#general-good-practice)
    - [Cache Location](#cache-location)
    - [Keeping up to date](#keeping-up-to-date)
    - [Centralized configs vs distributed configs](#centralized-configs-vs-distributed-configs)
    - [Debugging](#debugging)
- [Launching software is slow](#launching-software-is-slow)
    - [Diagnosis](#diagnosis)
    - [Is the issue pre or post launch?](#is-the-issue-pre-or-post-launch)
    - [Checking the logs](#checking-the-logs)
    - [Common causes of slow software launches](#common-causes-of-slow-software-launches)
- [File Open, File Save, or the Loader app is slow?](#file-open-file-save-or-the-loader-app-is-slow)
- [Folder Creation is slow](#folder-creation-is-slow)
    - [Tackling I/O usage](#tackling-io-usage)
    - [Registering folders](#registering-folders)

## General good practice

### Cache Location

{% include product %} Toolkit [caches data to the user’s home directory](../administering/where-is-my-cache.md). This cache can include a number of different SQLite databases as well as cached apps and configs. Normally the user’s home directory is stored on the machine’s local hard drives, but it's fairly common for studios to redirect them to network storage. Doing this can impact performance—most notably to the SQLite databases, which are used for browser integration and folder creation/lookup among other things. 

If your user directories are stored on a server location, we recommend repathing the {% include product %} Toolkit cache using the [`{% include product %}_HOME` environment variable](https://developer.shotgridsoftware.com/tk-core/initializing.html#environment-variables). The `{% include product %}_HOME` environment variable is used to set the location where Toolkit caches various data, such as the bundle cache, thumbnails, SQLite databases used for fast lookup of data and other things.

### Debugging

You can enable debug logging in {% include product %} Toolkit, so that you can get more verbose output from the various processes. This can be incredibly useful when trying to diagnose issues, however, the debug setting is not designed to be enabled during normal everyday use. The increase in logging output can significantly impact performance. 

When encountering performance issues, especially ones that are localized to specific machines or users, first check that [debug logging](./turn-debug-logging-on.md) isn’t enabled.

### Keeping up to date

If you’re encountering performance issues, check that your core, apps, engines, and frameworks are up to date, as there may already be fixes or optimizations available in newer releases.

### Centralized configs vs distributed configs

There are two different ways of setting up advanced Toolkit configurations: [centralized and distributed](https://developer.shotgridsoftware.com/tk-core/initializing.html#the-toolkit-startup). The key differences are that the centralized configs typically live on your studio’s network storage where they can be accessed by all users, and the distributed configs are usually stored in the cloud and get cached locally per user. 

Whilst the differences between these two methods extend beyond performance, they can both bring performance benefits and disadvantages. Here is a table showing the pros and cons, purely from a performance standpoint.

|                         | Advantages                                                                                                                                                                                                                                                    | Disadvantages                                                                                                                                                                                                                                                                                                                                    |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Centralized Configs** | - Once the initial setup process is complete, it will have everything it needs already downloaded and ready to go for all users.                                                                                                                              | - Centralized configs are usually kept on network storage; therefore the performance can be degraded during normal Toolkit usage.                                                                                                                                                                                                                |
|                         | - Future updates only need to be downloaded once to the centralized location.                                                                                                                                                                                 | - Toolkit configurations contain many small files, and handling metadata operations on lots of small files can be a lot slower and harder for servers. Also, heavy read operations both through the use of Toolkit or through general use of the server may impact Toolkit’s performance by not being able to read the configuration as quickly. |
| **Distributed Configs** | - The cached apps, engines, frameworks, and cores are stored in such a way that they can be shared with other locally cached configs. This means subsequent loading of different projects will likely be faster to cache if they share the same dependencies. | - Distributed configs need to be cached locally per user. Usually, this involves downloading the config and all the required apps, engines, frameworks, and core.                                                                                                                                                                                |
|                         | - They are stored in the user’s cache on their local hard drive and thus normally perform better than server speeds. This means that after the initial cache, the performance should be better than a centralized config.                                     | - The process happens seamlessly behind the scenes, but there is still the initial cost of downloading these.                                                                                                                                                                                                                                    |
|                         |                                                                                                                                                                                                                                                               | - Every time the config gets updated to point to new versions of the dependencies, both the config and the new dependencies will need to be cached.                                                                                                                                                                                              |

In summary, if you have slow storage but a reasonable internet connection, then distributed configs maybe the best answer, but if you have good server storage performance and poor internet, then a centralized config might be more suitable.

{% include info title="Note" content="If you are interested in the distributed configs but are concerned about downloading the dependencies per machine, it is possible to centralize just your bundle cache so that it is shared among all users." %}

When using distributed configs, a user will only have to download something if it is not already found in the cache, and once one user has downloaded it, others will be able to benefit from it as well. To achieve this you can set the [`{% include product %}_BUNDLE_CACHE_PATH` environment variable](https://developer.shotgridsoftware.com/tk-core/initializing.html#environment-variables) on each machine to point to the shared location.

## Launching software is slow

You may notice that when launching software such as Maya, Nuke, Houdini, or others, they take longer to start up than without {% include product %}. It is normal that they may take a short while longer than without {% include product %}, but sometimes these times can increase to unacceptable levels, (normally depending on the software we would expect them to startup in under a minute). This can be one of the more tricky areas to diagnose as there are many processes involved in launching the software.

### Diagnosis

The first thing you should do is figure out under what conditions this is happening.

1. **Is it slow when launching without {% include product %}?** - This might seem obvious, but it’s worth checking that the issue only occurs when launching with {% include product %}.
2. **Is it slow regardless of which approach you use to launch, i.e., is it about the same if you launch from SG Desktop, or from the SG site using the browser integration?** - If it's slow launching from the {% include product %} site but not from SG Desktop, then it could be an issue with the browser integration, or it could point to issues creating the folders on disk. If you’re launching from a context other than a Project, then it will likely be creating more folders on disk so this might explain where the time is taken. It’s also worth noting that we check for the existence of the required folders every time software is launched.
3. **Does it happen on all projects?** - If it doesn't, then it’s likely to be something specific to the way the configuration is setup.
4. **Does this happen at specific points in the day?** - If so, then this could point to high demand on the infrastructure, such as server usage being higher at certain times of the day.
5. **Does this happen for all Machines/OSs used?** - If a particular machine is slow, then it's possible there is something outside of Toolkit that is causing the issues. However, clearing the Toolkit cache on that machine is a good first step. Different OSs come with different versions of software and Python packages, and sometimes performance issues can crop up on specific builds. Specifically we have seen issues with performance on Windows using Samba (SMB) shares. There isn’t a fix for this as such, but it’s good to be aware of if you are using it.
If you believe the issue is limited to a certain OS, Python package, or software version then please let our [support team](https://support.shotgunsoftware.com/hc/en-us/requests/new) know so they can investigate further.
6. **Does this happen for all users?** - Similar to above, it’s possible that as a different user on the same machine, the issue might disappear. In this situation, start by clearing the user’s local {% include product %} cache. Also, make sure debug logging is not enabled for normal production use, as this will impact performance.
7. **Is the slow launching exclusive to a specific app/software or are all apps/software launched abnormally slow?** - If specific software is slow to launch, this might mean that there is a configuration issue. It may be worth checking to see if you have any custom hooks set up to run either before or after launch that might be impacting performance. Common hooks used in start up are [`before_app_launch.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/master/hooks/before_app_launch.py), [`app_launch.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/master/hooks/app_launch.py), and the core hook [`engine_init.py`](https://github.com/shotgunsoftware/tk-core/blob/master/hooks/engine_init.py). There can also be occurrences from time to time where a newer version of software is released and our integrations are suddenly much slower to start. In this situation, you should reach out to [support](https://support.shotgunsoftware.com/hc/en-us/requests/new) to check if they are aware of this, and if there is any known fix. Please provide the version number of the software your using (including patches/service pack if applicable) and the version of the tk engine and core you’re running.

### Is the issue pre or post launch?

If the above hasn’t helped you narrow it down, then the next step is to establish where in the startup process things are slowing down. When launching software via Toolkit, it can usually be boiled down into a two step process.

The first step performs some initial operations, such as gathering the information required to launch the software, automatically creating the folders from the context and then actually launching the software. Then the second step of the process starts the Toolkit integration once the software has launched.

Usually, you can see without looking at the logs if the performance issue lies in the first step of the process or the second:

- By watching and seeing if it takes a long time for the software’s splash screen to start. If it does then the issue could well be in the first step.
- By seeing the software begin to start up relatively quickly but then become slow (after getting to the point where it has finished initializing and the {% include product %} menu is present). If this is the case then the issue will fall into the second step.

Knowing this will help you in the next bit which is looking at the logs.

### Checking the logs

Now you hopefully have some idea of if the issue is in the first step or the second step of the launching; this will help target which log you will be looking in. The logs are broken up per engine, so if the issue appears to be in the pre-launch phase, then you will need to look in either the `tk-desktop.log` or in the `tk-{% include product %}.log`, depending on if you launched from SG Desktop or the SG site respectively.

The next thing you should do is enable debug logging.
{% include info title="Note" content="If it was already enabled, as [mentioned above](#debugging) this could be a cause for sluggishness, so you should also test without it enabled" %}
Once debug logging is enabled, you should clear your existing logs, and then replicate the launch process. Then you can use the timestamps in the logs to see where the jumps in time appear.

For example, here are a few lines where a 5 second jump in time occurs during folder creation:

    2019-05-01 11:27:56,835 [82801 DEBUG sgtk.core.path_cache] Path cache syncing not necessary - local folders already up to date!
    2019-05-01 11:28:01,847 [82801 INFO sgtk.env.asset.tk-shotgun.tk-shotgun-folders] 1 Asset processed - Processed 66 folders on disk.


Once you locate the jumps in time, the log line will hopefully give you some idea about what was happening at that stage, such as if it occurred during folder creation, or if it was trying to get a {% include product %} connection. 

Reading logs can be tricky though and the contents may not always make sense, so again you can reach out to [support](https://support.shotgunsoftware.com/hc/en-us/requests/new) to assist you with this bit.

### Common causes of slow software launches

|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Slow internet speed** | Pretty much every aspect of Toolkit usage where it needs to connect and communicate with the {% include product %} site will be affected by slow internet speeds. In this case, typically, you will see speed issues in other situations in addition to launching software. However, if the connection is unstable rather than slow, you’re more likely to run into performance issues during launch (as there is quite a bit of {% include product %} communication going on throughout the process). |
| **Slow server access**  | This can certainly affect launch times. If you're using a [centralized config](#centralized-configs-vs-distributed-configs), (i.e., your config is stored on a central server) there can be a lot of I/O as it reads your configuration files. On top of that, launching the software will trigger folder creation for the context it’s being launched in. This means that it will be checking to see if your folders are created, and creating them if not.               |
| **Folder creation**     | As mentioned above, folder creation can be a common cause of slowdown. [See the folder creation performance troubleshooting below for more details.](#folder-creation-is-slow)                                                                                                                                                                                                                                                                                             |

## File Open, File Save, or the Loader app is slow?

The first thing to do is to narrow down to certain aspects of where the app in question is slow.

- **Is it slow to launch the app or navigate through the tabs?**
    - It's possible that the app is currently configured to show too much information. The My Tasks tab and others can be configured to filter out unneeded entities from the list. For example, you could filter out tasks that are of a certain status, such as On Hold (`hld`) or Final (`fin`).  Not only does this offer performance benefits, but it also lets the artist see only the information that is important to them. Both the [Loader app](https://support.shotgunsoftware.com/hc/en-us/articles/219033078-Load-Published-Files-#The%20tree%20view) and the Workfiles app can be filtered, however, Workfiles doesn’t currently have a specific doc section on filtering but filters can be applied as part of the [hierarchy settings](https://support.shotgunsoftware.com/hc/en-us/articles/219033088-Your-Work-Files#Step%20filtering).
    - The hierarchy on the File Open app can also be configured to defer the loading of the [sub items until it is expanded](https://support.shotgunsoftware.com/hc/en-us/articles/219033088-Your-Work-Files#Deferred%20queries). This is now the default configuration setup, however, if you have older configs you may wish to transition over to using this.
    - Check that debug logging isn’t enabled. This can cause a lot of additional I/O and therefore slow things down; these apps do contain a lot of debugging output.
- **Is it slow opening, saving, or creating a new file?**
    - Check to see if you’ve taken over scene operations or actions hooks, and see if there is any custom behavior around these functions that might slow things down.
    - When creating or saving a file, Workfiles will ensure that all the required folders for the context are created. Folder creation can be a common point at which performance [issues](#folder-creation-is-slow) can occur.

## Folder Creation is slow

Folder creation has many parts to it, which can contribute to the process being slow when an issue arises.

Folder creation will:
- Synchronise your local path cache.
- Read your config’s schema.
- Generate a list of paths that should be created given a certain context. 
- Check the paths against path registries stored locally.
- Attempt to register the new paths both on your SG site and locally, if not already registered.
- Check to see if the folders actually exist on disk regardless of if they have already been registered, and create the folders if they are not.

In short, folder creation will have potentially significant I/O usage on the disk, as well as need to write to a local database and communicate with the SG site.

### Tackling I/O usage

It may be possible that your storage is slow or inefficient at handling many small read-write operations, so anything that can be done to improve the infrastructure will help speed up the folder creation operations. However, there are steps that can be taken on the Toolkit configuration side to try and reduce the strain as much as possible.

The first thing is to limit the folders that are created to the ones that are important to that context and thus the environment you would be working in. For example, if you're working on a Task on a Shot in Maya, then you would ideally only want it to check and create the folders for your specific Shot and software. 

Basically, create the minimum required folders that allow you to save and publish your work.

#### Create with parent

There is a [`create_with_parent` setting](https://support.shotgunsoftware.com/hc/en-us/articles/219039868-Integrations-File-System-Reference#Create%20With%20Parent%20Folder) that can be applied to schema folders.
Setting it to true will cause the folder to be created at the same time as it’s parent. You should be careful to avoid situations where setting it to True will cause large numbers of folders to be checked and created.

**Example**

If you had a Sequence/Shot folder hierarchy and you set your Shot folder to create with its parent Sequence, then whenever a Sequence folder gets created, it will check for all associated Shots and create folders for them. 

Whilst this might be convenient in some situations, it is causing a lot more folders to be checked and potentially created at once. In this scenario, if you were to create a new file in workfiles on a Task on a Shot, it would trigger the creation of the Shot’s parent Sequence folder and that in turn would create all children Shot folders, not just the Shot you’re working on. 

{% include info title="Note" content="The setting for step schema folders defaults to true." %}

#### Defer creation

The [`defer_creation` setting](https://support.shotgunsoftware.com/hc/en-us/articles/219039868-Integrations-File-System-Reference#Workspaces%20and%20Deferred%20Folder%20Creation) allows you to further refine when folders should be created by restricting the creation of folders to only happen when a certain engine is running. You can even use custom names, and then trigger the creation of them using the [sgtk API](https://developer.shotgridsoftware.com/tk-core/core.html?highlight=create_#sgtk.Sgtk.create_filesystem_structure).

**Example**

You may have a bunch of folders that should only be created at publish stage. In this case, you could set a custom to defer keyword of maya_publish, and then use the API to create the folders using that keyword as the engine name.
Your folder in the schema might look something like:

    # the type of dynamic content
    type: "static"
    # defer creation and only create this folder when Photoshop starts
    defer_creation: "publish"

And then you would create the folders with a script like this:

```python
sgtk.create_filesystem_structure(entity["type"], entity["id"], engine="publish")
```

**Extended Example**

Taking the idea of deferring folders further, if you have a number of non-dynamic folders at the root of your project, these typically only ever need to be created once. For example, the [“editorial” and “reference”](https://github.com/shotgunsoftware/tk-config-default2/tree/master/core/schema/project) folders in the root of the Default Configuration’s  schema would only likely need creating once at the start of the project, but by default, the folder creation will check for their existence every time. 

To limit this, you could create [yml files](https://support.shotgunsoftware.com/hc/en-us/articles/219039868-Integrations-File-System-Reference#Static%20folders) for them, where you can set a defer keyword so that they only get created when the folder creation is run in a certain engine or passed the keyword. You could set the defer keyword to `tk-shell` and then run the folder creation via the tank command like `tank folders`. 

This would mean that these folders would only get created if the folder creation was run via the tank command, which a Toolkit administrator could do when setting up the project for the first time. Alternatively, you could write a small script that ran the folder creation with a custom keyword a bit like the example above.

### Registering folders

During the folder creation process the folders are [registered](../administering/what-is-path-cache.md) so that the paths can be used to look up the context in the future. [As mentioned before](#folder-creation-is-slow), part of this process requires talking to the {% include product %} site, which is the central location where the registries are stored. However, these registries are also cached locally to enable faster lookup by the tools. 

#### SQLite database

The local [path cache](../administering/what-is-path-cache.md) uses an SQLite database to store the data. The performance of reading and writing to the database can be severely impacted if the database is stored on network storage.

#### Initial synchronization

There can be situations where a local cache needs to be generated from scratch for a project (such as when a new user joins an already in progress project) that has a lot of folders registered. This process can take noticeably longer, but the good news here is that this should only happen once for that project. 

Subsequent syncs will only pull the differences between the local cache and the site registry. If the user infrequently works on the project and a lot of folders get created between sessions, then they may experience a noticeable wait whilst everything caches.

One method we’ve seen people employ here is to transfer a reasonably up to date version of a local cache to the user’s machine.

{% include info title="Note" content="This approach is only necessary in situations where there is an extremely large amount of folders being created on a project." %}

This update process can be achieved automatically through the use of the core hook cache_location.py. This hook can be used to set the location of the cache, but rather than changing the location, you can use this hook to copy a version of the path_cache.db file from a central location to the user’s default location, thus cutting out the need for it to do an expensive full sync. 

The centrally stored path cache could then be updated periodically by either manually copying from someone's cache, or perhaps having a script transfer it on a regular basis. 

{% include warning title="WARNING" content="The cache_location.py hook can be used to set the location of the cache, but setting this to point to a single location for all users should be avoided, as this can lead to database locks when one or more processes try to edit the database at the same time." %}