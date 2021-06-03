---
layout: default
title: Where are my log files?
pagename: where-are-my-log-files
lang: en
---

# Where are my log files?

By default, {% include product %} Desktop and Integrations store their log files in the following directory:

**Mac**

`~/Library/Logs/Shotgun/`

**Windows**

`%APPDATA%\Shotgun\logs\`

**Linux**

`~/.shotgun/logs/`

Log file names are in the form `tk-<ENGINE>.log`. Examples include `tk-desktop.log` or `tk-maya.log`.

If you've set the [`{% include product %}_HOME` environment variable](http://developer.shotgridsoftware.com/tk-core/utils.html#localfilestoragemanager) to override the user's cache location, then the log files will be located in: `$SHOTGUN_HOME/logs`.

{% include info title="Note" content="You can also reach this directory from Shotgun Desktop. Selecting a project, click the down-arrow button to the right of the project name, and choose **Open Log Folder**." %}
