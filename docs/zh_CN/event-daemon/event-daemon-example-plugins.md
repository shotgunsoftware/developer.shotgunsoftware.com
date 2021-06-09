---
layout: default
title: 示例插件
pagename: event-daemon-example-plugins
lang: zh_CN
---

# 示例插件

源代码中有一个[示例插件的文件夹](https://github.com/shotgunsoftware/shotgunEvents/tree/master/src/examplePlugins)。

此页面包含几个简单的示例，可供任何人入门使用。您可以复制/粘贴此代码，它应该可以正常运行（注意：您需要将 `script_name` 和 `script_key` 值更新为特定于您的安装的内容）

首先，这里有一个模板，所有 SG 事件代码都应基于此模板编写
## 1. 代码模板
### 复制/粘贴此代码以在新插件上使用
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
## 2. 注释主题重命名
### 使用 `New` 实体事件
这是一个很好的起点，因为它很简单，而且还能处理捕捉 `Shotgun_Entity_New` 事件的棘手方面...
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
请注意函数主体第一行的 `sleep` 调用。这与 `new` 事件的处理方式有关。
1. 在 SG 中创建新实体时，它仍然是非成形的 - 这意味着它不具备完全定义该实体所需的所有习惯属性。实际上，在本示例中，我甚至无法保证在 SG 发出 `Shotgun_Note_New` 事件时，`subject` 属性将位于注释实体上。
2. 为了添加所有必需的属性，SG 将发布一系列 `Shotgun_Note_Change` 事件，其中 SG 会将每个属性添加到实体并更新这些属性的值（如果需要）。
3. 这表示将创建多种事件，这意味着如果您需要存在两个不同的属性，而您未在代码中写入 `sleep` 内容，则必须对所有 `Shotgun_Note_Change` 事件和内部元数据进行筛选，以便仅查找那些添加了新属性并设置了值的事件。这是一个繁琐的过程，并且将处理许多 `Shotgun_Note_Change` 事件，从而在创建时有效查找每个注释的一个事件。
4. 我发现的解决方案是依赖 `Shotgun_Entity_New`，让脚本休眠一小段时间。在休眠结束时，SG 应该已更新实体所需的所有属性，然后您可以针对所需的任何字段重新查询同一实体

## 2. 字段删除警告
### 生成注释、将字段作为实体使用以及实体停用事件
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
这是一个非常简单的脚本。检查已删除的字段时没有特殊逻辑。如果删除了某个字段，则会创建一个注释并将其发送给需要了解的一组人员。在我的部门，我们将组 ID 设置为“程序员”组，并将注释的项目 ID 设置为“开发”项目。
