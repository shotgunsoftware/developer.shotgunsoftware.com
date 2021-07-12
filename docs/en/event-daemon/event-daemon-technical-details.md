---
layout: default
title: Technical Details
pagename: event-daemon-technical-details
lang: en
---

# Technical Overview

<a id="Event_Types"></a>

## Event Types

The event types your triggers can register to be notified of are generally respect the following form `Shotgun_[entity_type]_[New|Change|Retirement|Revival]`. Here are a few examples of this pattern:

    Shotgun_Note_New
    Shotgun_Shot_New
    Shotgun_Task_Change
    Shotgun_CustomEntity06_Change
    Shotgun_Playlist_Retirement
    Shotgun_Playlist_Revival

Some notable departures from this pattern are used for events that aren't related to entity record activity but rather key points in application behavior.

    CRS_PlaylistShare_Create
    CRS_PlaylistShare_Revoke
    SG_RV_Session_Validate_Success
    Shotgun_Attachment_View
    Shotgun_Big_Query
    Shotgun_NotesApp_Summary_Email
    Shotgun_User_FailedLogin
    Shotgun_User_Login
    Shotgun_User_Logout
    Toolkit_App_Startup
    Toolkit_Desktop_ProjectLaunch
    Toolkit_Desktop_AppLaunch
    Toolkit_Folders_Create
    Toolkit_Folders_Delete

This list is not exhaustive but is a good place to start. If you wish to know more about the activity and event types on your {% include product %} site, please consult a page of EventLogEntries where you can filter and search through like any other grid page of any other entity type.

### Event Log Entries for Thumbnails

When a new thumbnail is uploaded for an entity, an Event Log entry is created with `` `Type` == `Shotgun_<Entity_Type>_Change` `` (e.g. `Shotgun_Shot_Change`).

1. The `‘is_transient’` field value is set to true:

```
{ "type": "attribute_change","attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11656,
 "is_transient": true
}
```

2. When the thumbnail becomes available, a new Event Log entry is created with the `‘is_transient’` field value now set to false:

```
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11656,
 "is_transient": false
}
```

3. If we update the thumbnail again, we get these new Event Log entries:

```
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": 11656, "new_value": 11657,
 "is_transient": true
}
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11657,
 "is_transient": false
}
```

4. Notice the `‘old_value’` field is set to null when the attachment’s thumbnail is the placeholder thumbnail.

<a id="Plugin_Processing_Order"></a>

## Plugin Processing Order

Each event is always processed in the same predictable order so that if any plugins or callbacks are co-dependant, you can safely organize their processing.

The configuration file specifies a `paths` config that contains one or multiple plugin locations. The earlier the location in the list the sooner the contained plugins will be processed.

Each plugin within a plugin path is then processed in ascending alphabetical order.

{% include info title="Note" content="Internally the filenames are put in a list and sorted." %}

Finally, each callback registered by a plugin is called in registration order. First registered, first run.

We suggested keeping any functionality that needs to share state somehow in the same plugin as one or multiple callbacks.

<a id="Sharing_State"></a>

## Sharing state

Many options exist for multiple callbacks that need to share state.

- Global variables. Ick. Please don't do this.
- An imported module that holds the state information. Ick, but a bit better than simple globals.
- A mutable passed in the `args` argument when calling [`Registrar.registerCallback`](API#wiki-registerCallback). A state object of your design or something as simple as a `dict`. Preferred.
- Implement callbacks such as `__call__` on object instances and provide some shared state object at callback object initialization. Most powerful yet most convoluted method. May be redundant compared to the args argument method above.

<a id="Event_Backlogs"></a>

## Event Backlogs

The framework is designed to have every plugin process every single event they are interested in exactly once, without exception. To make sure this happens, the framework stores a backlog of unprocessed events for each plugin and remembers the last event each plugin was provided. Here is a description of situations in which a backlog may occur.

### Backlogs due to gaps in the event log entry sequence

Each event that occurs in {% include product %} (field update, entity creation, entity retirement, etc.) has a unique ID number for its event log entry. Sometimes there are gaps in the ID number sequence. These gaps can occur for many reasons, one of them being a large database transaction that has not yet been completed.

Every time there is a gap in the event log sequence the "missing" event IDs are put into a backlog for later processing. This allows for the event daemon to process the events from a long database transaction once it has finished.

Sometimes the gap in the event log sequence will never be filled in, such as with a failed transaction or reverted page setting modifications. In this case, after a 5 minute timeout, the system will stop waiting for the event log entry ID number and will remove it from the backlog. When this happens you will see a "Timeout elapsed on backlog event id #" message. If the first time a gap in the event sequence is seen and it is already deemed to have exceeded the timeout, the message will appear as "Event # never happened - ignoring" and it won't be put in the backlog in the first place.

### Backlogs due to plugin errors

During normal operation, the framework is always tracking the last event that was processed by each plugin. If you have a plugin that fails for any reason it will stop processing further events. When you fix the plugin, by fixing a bug for example, the framework will start processing events at the last event stored for the fixed plugin. This is done in order to make sure the newly fixed plugin gets to process all events, including those that have occurred in the past between the failure and the fix. If the failure occurred long ago, this may mean a lot of events need to be revisited and it may take a while for the fixed plugin to catch up with the other plugins that were functioning normally.

While your fixed plugin plays catch-up, the other plugins will be ignoring these events in order to make sure no single event is processed twice by the same plugins. This leads to the "Event X is too old. Last event processed is (Y)" message. This is a debug message and can be safely ignored.

There is no formal way to sidestep this. The framework is designed to make sure every single plugin processes every event once and only once. However, If you are familiar with Python and its pickle data format, you can stop the daemon, open the .id file with a Python interpreter/interactive shell, decode its contents with the pickle modules and edit its contents to remove the stored id thus skipping the accrued backlog. This is unsupported and at your own risk. Please backup the `.id` file appropriately before you do this.
