---
layout: default
title: Example Plugins
pagename: event-daemon-example-plugins
lang: en
---

There is a [folder of example plugins](https://github.com/shotgunsoftware/shotgunEvents/tree/master/src/examplePlugins) in the source code. 

This page includes a few more simple examples, for anyone looking to get started. You can copy/paste this code and it should run(Note: you'll have to update the `script_name`, and `script_key` values to something specific for your installation)

First, here's a template upon which all SG event code should be written
## 1. Code Template
### Copy / Paste this to get started on new plugins
```python
"""
Necessary Documentation of the code

Author: You
Template Author: Andrew Britton
"""

def registerCallbacks(reg):
    # This takes the form of:
    #    matchEvents = {'Shotgun_Entity_EventType': ['list', 'of', 'field', 'names', 'you', 'need', 'sg_custom_field']}
    # the 'id' is always returned, in addition to any fields specifically requested by your callback
    matchEvents = {
        'Shotgun_Task_Change': ['content']
    }

    # script_name and script_key are defined by you whenever you create a SG script
    # the entry_function_call refers to the function that performs the work of the event plugin
    reg.registerCallback('script_name', 'script_key', entry_function_call, matchEvents, None)


# This gives you
#    shotgun handle = sg
#    a logger object... please use this instead of python print, especially if you respect your time and your fellow developers
#    an event object... this is the metadata that describes what's happening with the particular event.
#        some very good information comes from the event['meta'] object, below is the example event['meta'] data from the subject renamer plugin
#              {
#                "type": "attribute_change",
#                "attribute_name": "subject",
#                "entity_type": "Note",
#                "entity_id": 2,
#                "field_data_type": "text",
#                "old_value": "My Note Subject",
#                "new_value": "2017-05 May-09 - My Note Subject"
#              }
def entry_function_call(sg, logger, event, args):
    # Now do stuff
    pass   
```
## 2. Note Subject Renaming
### Working with `New` Entity Events
This is a great one to start with  because it's simple, but it also deals with a rather tricky aspect of catching `Shotgun_Entity_New` events...
```python
import time
from pprint import pprint

def registerCallbacks(reg):
    matchEvents = {
        'Shotgun_Note_New': ['*'],
    }

    reg.registerCallback('script_name', 'script_key', Function_Name, matchEvents, None)


def Function_Name(sg, logger, event, args):
    # Waiting here should allow the entity to be fully created 
            #     and all the necessary attributes to be added to the NOTE entity
    time.sleep(1)
    current_date = time.strftime("%Y-%m %b-%d")
    asset_id = event['meta']['entity_id']
    asset_type = event['meta']['entity_type']

    asset = sg.find_one(asset_type, [['id', 'is', asset_id]], ['subject'])
    if asset['subject'] is None:
        current_name = current_date + ' - ' + event['project']['name'] + ' - ' + event['user']['name']
    else:
        current_name = current_date + ' - ' + asset['subject']

    # Modify ALL notes except those in 'Software Development'
    if event['project'] == None:
        logger.info('Updated Note ID is #%d, and is being prepended with "%s"', asset_id, current_date)
        logger.info(event)
        sg.update(asset_type, asset_id, {'subject': current_name})
        return

    if event['project']['id'] != 116:
        logger.info('Updated Note ID is #%d, and is being prepended with "%s"', asset_id, current_date)
        logger.info(event)
        sg.update(asset_type, asset_id, {'subject': current_name})

    else:
        logger.info('Dates are not prepended for notes in project id 116 - Software Development')
        return
```
Note the `sleep` call as the very first line of the function body. The reason for this deals with the way that `new` events are handled.
1. When a NEW entity is created in SG, it is still rather unformed - meaning that it doesn't possess all the attributes needed to fully define that entity as you're used to it. In fact, in this example, I can't even guarantee that the `subject` attribute will be on the Note entity when SG emits the `Shotgun_Note_New` event.
2. In order to add all of the necessary attributes, SG then publishes a series of `Shotgun_Note_Change` events wherein SG will add every single attribute to the entity and update the values of those attributes - if required.
3. This means that a multiplicity of events are created, which means that if you need two different attributes to be present and you didn't write a `sleep` aspect to your code, then you'd have to sift through ALL of the `Shotgun_Note_Change` events and the internal metadata looking for only those that have new attributes added and values set... This is a cumbersome process and will process many `Shotgun_Note_Change` events looking for - effectively - just one per note at time of creation.
4. The solution as I've found it is to rely on `Shotgun_Entity_New` and let the script sleep for a short period. At the end of the sleep, SG will have updated all the attributes required for the entity and then you can re-query that same entity for any of the fields you need

## 2. Field Deletion Warning
### Generating Notes, Working with Fields as Entities, and Entity Retirement Events
```python

"""
Create a Note when a field is deleted

Author: Andrew Britton
"""

def registerCallbacks(reg):
    """
    fn: registerCallbacks
    @brief required function. It connects to the event daemon and calls the trashedFieldWarning Function.
    It runs every time a field is deleted (retired)

    @param[in] reg variable that is required by shotgun event daemon plugins
    @return none
    """
    matchEvents = {
        'Shotgun_DisplayColumn_Retirement': ['*']
    }

    reg.registerCallback('script_name', 'script_key',
                         trashedFieldWarning, matchEvents, None)


def CreateNote(sg, logger, event):
    constants = {'note header': ':: FIELD DELETION :: '}
    def GetListOfPipelineUsers():
        pipeline_users = sg.find('Group', [['code', 'is', 'People_Who_Need_to_Know']], ['code', 'users', 'addressings_to',
                                                                         'sg_ticket_type', 'sg_priority'])
        return pipeline_users[0]['users']

    def CreateToolsNote():
        # Note to members of the pipeline group
        # Body text = CreateNoteRequestText()
        # Date Created = event['event']['created_at']
        # Created By = event['user']['id']
        # Project = Software Development['id']
        # Subject = ':: Field Delete Warning :: ' + event['entity']['name']
        note_data = {
            'project': {'type': 'Project', 'id': 'ID OF PROJECT WHERE YOU WANT THE NOTE REPORTED TO'},
            # ex: 'project': {'type': 'Project', 'id': 2},
            'content': CreateNoteRequestText(),
            'created_at': event['created_at'],
            'created_by': event['user'],
            'addressings_to': GetListOfPipelineUsers(),
            'subject': constants['note header'] + event['meta']['display_name']
        }

        sg.create('Note', note_data)

    def CreateNoteRequestText():
        OUT = ''

        # Tool Name = event['entity']['name']
        # sg_assigned_to = members of the pipeline group
        # Description = linked Ticket decription
        # Project = decided in GUI
        # sg_sg_request_ticket = event['entity']['id']
        # task_template = Software task template
        # Software Projects = defined in GUI

        OUT = '::FIELD DELETION WARNING::\n'
        OUT += ':: A Field was deleted ::\n'
        OUT += ':: It was called %s ::\n'%event['meta']['display_name']

        return OUT

    logger.info('::WARNING:: A FIELD has been deleted')
    CreateToolsNote()


def trashedFieldWarning(sg, logger, event, args):
    """
    fn: finalizeTasksFromShot
    @brief Function to create and send a warning note, via SG, whenever a field is deleted
    event['entity']['id'] yields the id of the current entity that was caught by the plugin as having been changed.
    ie. this is the id of the field that was just deleted

    @param[in] sg defines the Shotgun handle to access the database
    @param[in] logger sets logging messages to the shotgun event daemon
    @param[in] event the collection of shots that have changed
    @param[in] args useless variable for this particular function
    @return none
    """

    if event['meta']['entity_type'] == 'DisplayColumn':
        logger.info('This DisplayColumn was deleted %s', event['meta']['display_name'])
    if event['event_type'] == 'Shotgun_DisplayColumn_Retirement':
        logger.info('The incoming event call is for deleting a field from an entity. Field name: %s', event['meta']['display_name'])

    # logger.info(' TEST ')
    # logger.info('Deleted Field ID is #%d, and is called: %s', event['entity']['id'], event['entity']['name'])

    CreateNote(sg, logger, event)
```
This is a very simple script. There is no special logic in checking for deleted fields. If a field is deleted, then a note is created and sent to a group of people that need to know. In my department, we have the group id set to the 'programmers' group, and the project id of the note set to the 'development' project.