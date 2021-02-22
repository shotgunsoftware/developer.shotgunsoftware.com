---
layout: default
title: Configuration
pagename: event-daemon-configuration
lang: en
---

# Configuration

The following guide will help you configure {% include product %}Events for your studio.

Most of the configuration for {% include product %}Events is controlled by the `shotgunEventDaemon.conf` file. In this file, you'll find several settings you can modify to match your needs. Most of them have defaults that will work fine for most studios, however, there are some settings that must be configured (specifically, your {% include product %} server URL, script name, and application key so the {% include product %}EventDaemon can connect to your {% include product %} server).

{% include info title="Note" content="**For Windows:** Windows users will need to change all the paths in the configuration file for Windows equivalents. We suggest keeping all paths, including logging, under one single location for the sake of simplicity. This documentation tends to refer to `C:\shotgun\shotgunEvents` when mentioning Windows paths." %}

<a id="Edit_shotgunEventDaemon_conf"></a>
## Edit shotgunEventDaemon.conf

Once you have installed {% include product %}Events, the next step is to open the `shotgunEventDaemon.conf` file in a text editor and modify the settings to match your studio's needs. The defaults will be fine for most studios, however, there are some settings that have no defaults that will need to be provided by you before you can run the daemon. 

The items you *must* provide are:

- your {% include product %} server URL
- the Script name and Application key for connecting to {% include product %}
- the full path to your plugins for the {% include product %}EventDaemon to run

Optionally, you can also specify an SMTP server and email-specific settings in order to setup email notification for errors. While this is optional, if you choose to set this up, you must provide all of the configuration values in the email section.

There is also a section for an optional timing log which can help with troubleshooting if you ever encounter performance issues with your daemon. Enabling timing logging will populate its own separate log file with the timing information.

<a id="Shotgun_Settings"></a>
### {% include product %} Settings

Underneath the `[{% include product %}]` section, replace the default tokens with the correct values for `server`, `name`, and `key`. These should be the same values you'd provide to a standard API script connecting to {% include product %}.

Example

```
server: https://awesome.shotgunstudio.com
name: {% include product %}EventDaemon
key: e37d855e4824216573472846e0cb3e49c7f6f7b1
```

<a id="Plugin_Settings"></a>
### Plugin Settings

You will need to tell the {% include product %}EventDaemon where to look for plugins to run. Under the `[plugins]` section replace the default token with the correct  value for `paths`.

You can specify multiple locations (which may be useful if you have multiple departments or repositories using the daemon). The value here must be a full path to a readable existing directory.

Example

```
paths: /usr/local/shotgun/{% include product %}Events/plugins
```

When you're first getting started, a good plugin to test with is the `logArgs.py` plugin located in the `/usr/local/shotgun/{% include product %}Events/src/examplePlugins` directory. Copy that into the plugins folder you specified and we'll use that for testing things.

<a id="Location_of_shotgunEventDaemon_conf"></a>
### Location of shotgunEventDaemon.conf

By default, the daemon will look for the shotgunEventDaemon.conf file in the same directory that {% include product %}EventDaemon.py is in, and in the `/etc` directory. If you need to put the conf file in another directory, it's recommended you create a symlink to it from the current directory.

{% include info title="Note" content="If for some reason the above won't work for you, the search paths for the config file are located in the `_getConfigPath()` function at the bottom of the `{% include product %}EventDaemon.py` script" %}

{% include info title="Note" content="**For Windows** The `/etc` doesn't exist on Windows so the configuration file should be put in the same directory as the Python files." %}

<a id="Testing_the_Daemon"></a>
## Testing the Daemon

Daemons can be difficult to test since they run in the background. There isn't always an obvious way to see what they're doing. Lucky for us, the {% include product %}EventDaemon has an option to run it as a foreground process. Now that we have done the minimum required setup, let's go ahead and test the daemon and see how things go.

{% include info title="Note" content="The default values used here may require root access (for example, to write to the/var/log directory). The examples provided use are run using `sudo` to accommodate this." %}

```
$ sudo ./{% include product %}EventDaemon.py foreground
INFO:engine:Using {% include product %} version 3.0.8
INFO:engine:Loading plugin at /usr/local/shotgun/{% include product %}Events/src/examplePlugins/logArgs.py
INFO:engine:Last event id (248429) from the {% include product %} database.
```

You should see the lines above when you start the script (some of the details may differ obviously). If you get any errors, the script will terminate since we opted to run it in the foreground we'll see that happen. Some common errors are displayed below if you get stuck.

The `logArgs.py` plugin simply takes the event that occurred in {% include product %} and passes it to the logger. Not very exciting but it's a simple way to ensure that the script is running and the plugin is working. If you're at a busy studio, you may have already noticed a rapid stream of messages flowing by. If not, login to your {% include product %} server in your web browser and change some values or create something. You should see log statements printed out to your terminal window corresponding to the type of event you generated with your changes. 

{% include info title="Note" content="There are variables in the logArgs.py file that need to be filled in with appropriate values. '$DEMO_SCRIPT_NAMES$' and '$DEMO_API_KEY$' must be edited to contain the same values that were used in the shotgunEventDaemon.conf file in order for the logging to function correctly." %}

If you don't see anything logged to the log file, check your log-related settings in {% include product %}EventDaemon.conf to ensure that the ``logging`` value is set to log INFO level messages

```
logging: 20
```

and the logArgs plugin is also configured to show INFO level messages. There is a line at the end of the registerCallbacks() method that should read

```python
reg.logger.setLevel(logging.INFO)
```

Assuming all looks good, to stop the {% include product %}EventDaemon process, simply type `<ctrl>-c` in the terminal and you should see the script terminate.

<a id="Running_the_Daemon"></a>
## Running the daemon

Assuming all went well with your testing, we can now run the daemon as intended, in the background.

```
$ sudo ./{% include product %}EventDaemon.py start
```

You should see no output and control should have been returned to you in the terminal. We can make sure that things are running well in two ways. The first would be to check the running processes and see if this is one of them.

```
$ ps -aux | grep shotgunEventDaemon
kp              4029   0.0  0.0  2435492    192 s001  R+    9:37AM   0:00.00 grep shotgunEventDaemon
root            4020   0.0  0.1  2443824   4876   ??  S     9:36AM   0:00.02 /usr/bin/python ./{% include product %}EventDaemon.py start
```

We can see by the second line returned that the daemon is running. The first line is matching the command we just ran. So we know it's running, but to ensure that it's *working* and the plugins are doing what they're supposed to, we can look at the log files and see if there's any output there.

```
$ sudo tail -f /var/log/shotgunEventDaemon/shotgunEventDaemon
2011-09-09 09:42:44,003 - engine - INFO - Using {% include product %} version 3.0.8
2011-09-09 09:42:44,006 - engine - INFO - Loading plugin at /usr/local/shotgun/{% include product %}/src/plugins/logArgs.py
2011-09-09 09:42:44,199 - engine - DEBUG - Starting the event processing loop.
```

Go back to your web browser and make some changes to an entity. Then head back to the terminal and look for output. You should see something like the following

```
2011-09-09 09:42:44,003 - engine - INFO - Using {% include product %} version 3.0.8
2011-09-09 09:42:44,006 - engine - INFO - Loading plugin at /usr/local/shotgun/{% include product %}/src/plugins/logArgs.py
2011-09-09 09:42:44,199 - engine - DEBUG - Starting the event processing loop.
2011-09-09 09:45:31,228 - plugin.logArgs.logArgs - INFO - {'attribute_name': 'sg_status_list', 'event_type': 'Shotgun_Shot_Change', 'entity': {'type': 'Shot', 'name': 'bunny_010_0010', 'id': 860}, 'project': {'type': 'Project', 'name': 'Big Buck Bunny', 'id': 65}, 'meta': {'entity_id': 860, 'attribute_name': 'sg_status_list', 'entity_type': 'Shot', 'old_value': 'omt', 'new_value': 'ip', 'type': 'attribute_change'}, 'user': {'type': 'HumanUser', 'name': 'Kevin Porterfield', 'id': 35}, 'session_uuid': '450e4da2-dafa-11e0-9ba7-0023dffffeab', 'type': 'EventLogEntry', 'id': 276560}
```

The exact details of your output will differ, but what you should see is that the plugin has done what it is supposed to do, that is, log the event to the logfile. Again, if you don't see anything logged to the log file, check your log-related settings in {% include product %}EventDaemon.conf to ensure that the ``logging``value is set to log INFO level messages and your logArgs plugin is also configured to show INFO level messages.

<a id="A_Note_About_Logging"></a>
### A Note About Logging

It should be noted that log rotation is a feature of the {% include product %} daemon. Logs are rotated at midnight every night and ten daily files are kept per plugin.

<a id="Common_Errors"></a>
## Common Errors

The following are a few of the common errors that you can run into and how to resolve them. If you get really stuck, feel free to contact the {% include product %} Software team (support@shotgunsoftware.com) and we'll help you out.

### Invalid path: $PLUGIN_PATHS$

You need to specify the path to your plugins in the shotgunEventDaemon.conf file.

### Permission denied: '/var/log/shotgunEventDaemon'

The daemon couldn't open the log file for writing.

You may need to run the daemon with `sudo` or as a user that has permissions to write to the log file specified by the `logPath` and `logFile` settings in shotgunEventDaemon.conf. (the default location is `/var/log/shotgunEventDaemon` which is usually owned by root.

### ImportError: No module named shotgun_api3

The {% include product %} API is not installed. Make sure it is either located in the current directory or it is in a directory in your `PYTHONPATH`.

If you have to run as sudo and you think you have the `PYTHONPATH` setup correctly, remember that sudo resets the environment variables. You can edit the sudoers  file to preserve the `PYTHONPATH` or run sudo -e(?)

<a id="List_of_Configuration_File_Settings"></a>
## List of Configuration File Settings

<a id="Daemon_Settings"></a>
### Daemon Settings

The following are general daemon operational settings.

**pidFile**

The pidFile is the location where the daemon will store its process id while it is running. If this file is removed while the daemon is running, it will shut down cleanly after the next pass through the event processing loop.

The directory must already exist and be writable. You can name the file whatever you like but we strongly recommend you use the default name as it matches with the process that is running

```
pidFile: /var/log/shotgunEventDaemon.pid
```

**eventIdFile**

The eventIdFile points to the location where the daemon will store the id of the last processed {% include product %} event. This will allow the daemon to pick up where it left off when it was last shutdown, thus it won't miss any events. If you want to ignore any events since the last daemon shutdown, remove this file before starting up the daemon and the daemon will process only new events created after startup. 

This file keeps track of the last event id for *each* plugin and stores this information in pickle format.

```
eventIdFile: /var/log/shotgunEventDaemon.id
```

**logMode**

The logging mode can be set to one of two values:

- **0** = all log messages in the main log file
- **1** = one main file for the engine, one file per plugin

When using a value of **1**, the log messages generated by the engine itself will be logged to the main log file specified by the `logFile` config setting. Any messages logged by a plugin will be placed in a file named `plugin.<plugin_name>`.

```
logMode: 1
```

**logPath**

The path where to put log files (both for the main engine and plugin log files). The name of the main log file is controlled by the ``logFile``setting below.

```
logPath: /var/log/shotgunEventDaemon
```

{% include info title="Note" content="The shotgunEventDaemon will have to have write permissions for this directory. In a typical setup, the daemon is set to run automatically when the machine starts up and is given root privileges at that point." %}

**logFile**

The name of the main daemon log file. Logging is configured to store up to  10 log files that rotate every night at midnight.

```
logFile: shotgunEventDaemon
```

**logging**

The threshold level for log messages sent to the log files. This value is the default for the main dispatching engine and can be overridden on a per plugin basis. This value is simply passed to the Python logging module. The most common values are:
- **10:** Debug
- **20:** Info
- **30:** Warnings
- **40:** Error
- **50:** Critical

```
logging: 20
```

**timing_log**

Enabling timing logging by setting this value to `on` will generate a separate log file with timing information which should make troubleshooting performance issues with your daemon simpler.

The timing information provided for each callback invocation is as follows:

- **event_id** The id of the event that triggered the callback
- **created_at** The timestamp in ISO format when the event was created in {% include product %}
- **callback** The name of the invoked callback in `plugin.callback` format
- **start** The timestamp in ISO format of the start of callback processing
- **end** The timestamp in ISO format of the end of callback processing
- **duration** The duration in `DD:HH:MM:SS.micro_second` format of the callback processing time
- **error** If the callback failed or not. The value can be `False` or `True`.
- **delay** The duration in `DD:HH:MM:SS.micro_second` format of the delay between the event creation and the start of processing by the callback.

**conn_retry_sleep**

If the connection to {% include product %} fails, this is the number of seconds to wait until the connection is re-attempted. This allows for occasional network hiccups, server restarts, application maintenance, etc.

```
conn_retry_sleep = 60
```

**max_conn_retries**

Number of times to retry the connection before logging an error level message(which potentially sends an email if email notification is configured below). 

```
max_conn_retries = 5
```

**fetch_interval**

The number of seconds to wait before requesting new events after each batch of events is done being processed. This setting generally doesn't need to be adjusted.

```
fetch_interval = 5
```

<a id="Shotgun_Settings"></a>
### {% include product %} Settings

The following are settings related to your {% include product %} instance.

**server**

The URL for the {% include product %} server to connect to.

```
server: %(SG_ED_SITE_URL)s
```

{% include info title="Note" content="There is no default value here. Set the `SG_ED_SITE_URL` environment variable to the URL for your Shotgun server (ie. https://awesome.shotgunstudio.com)" %}

**name**

The {% include product %} Script name the {% include product %}EventDaemon should connect with.

```
name: %(SG_ED_SCRIPT_NAME)s
```
        
{% include info title="Note" content="There is no default value here. Set the `SG_ED_SCRIPT_NAME` environment variable to the Script name for your Shotgun server (ie. `shotgunEventDaemon`)" %}

**key**

The {% include product %} Application Key for the Script name specified above.

```
key: %(SG_ED_API_KEY)s
```
        
{% include info title="Note" content="There is no default value here. Set the `SG_ED_API_KEY` environment variable to the Application Key for your Script name above (ie:`0123456789abcdef0123456789abcdef01234567`)" %}

**use_session_uuid**

Sets the session_uuid from every event in the {% include product %} instance to propagate in any events generated by plugins. This will allow the {% include product %} UI to display updates that occur as a result of a plugin.

```
use_session_uuid: True
```

- {% include product %} server v2.3+ is required for this feature.
- {% include product %} API v3.0.5+ is required for this feature.

{% include info title="Note" content="The Shotgun UI will *only* show updates live for the browser session that spawned the original event. Other browser windows with the same page open will not see updates live." %}

<a id="Plugin_Settings_details"></a>
### Plugin Settings

**paths**

A comma-delimited list of complete paths where the framework should look for plugins to load. Do not use relative paths.

```
paths: /usr/local/shotgun/plugins
```

{% include info title="Note" content="There is no default value here. You must set the value to the location(s) of your plugin files (ie:`/usr/local/shotgun/shotgunEvents/plugins` or `C:\shotgun\shotgunEvents\plugins` on Windows)" %}

<a id="Email_Settings"></a>
### Email Settings

These are used for error reporting because we figured you wouldn't constantly be tailing the log and would rather have an active notification system.

Any error above level 40 (ERROR) will be reported via email if all of the settings are provided below.

All of these values must be provided for there to be email alerts sent out.

**server**

The server that should be used for SMTP connections. The username and password values can be uncommented to supply credentials for the SMTP connection. If your server does not use authentication, you should comment out the settings for `username` and `password`

```
server: smtp.yourdomain.com
```
        
{% include info title="Note" content="There is no default value here. You must replace the smtp.yourdomain.com token with the address of your SMTP server (ie. `smtp.mystudio.com`)." %}

**username**

If your SMTP server requires authentication, uncomment this line and make sure you have configured the `SG_ED_EMAIL_USERNAME` environment variable with the username required to connect to your SMTP server.

```
username: %(SG_ED_EMAIL_USERNAME)s
```

**password**

If your SMTP server requires authentication, uncomment this line and make sure you have configured the `SG_ED_EMAIL_PASSWORD` environment variable with the password required to connect to your SMTP server.

```
password: %(SG_ED_EMAIL_PASSWORD)s
```

**from**

The from address that should be used in emails.

```
from: support@yourdomain.com
```

{% include info title="Note" content="There is no default value here. You must replace`support@yourdomain.com` with a valid value (ie. `noreply@mystudio.com`)." %}

**to**

A comma-delimited list of email addresses to whom these alerts should be sent.

```
to: you@yourdomain.com
```

{% include info title="Note" content="There is no default value here. You must replace `you@yourdomain.com` with a valid value (ie. `shotgun_admin@mystudio.com`)." %}

**subject**

An email subject prefix that can be used by mail clients to help sort out alerts sent by the {% include product %} event framework.

```
subject: [SG]
```
