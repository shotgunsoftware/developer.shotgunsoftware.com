---
layout: default
title: 예시 플러그인
pagename: event-daemon-example-plugins
lang: ko
---

# 예시 플러그인

소스 코드에 [예시 플러그인 폴더](https://github.com/shotgunsoftware/shotgunEvents/tree/master/src/examplePlugins)가 있습니다.

이 페이지에는 누구나 시작할 수 있는 몇 가지 간단한 예제가 나와 있습니다. 이 코드를 복사해서 붙여넣으면 실행됩니다(참고: `script_name` 및 `script_key` 값을 설치에 해당되는 값으로 업데이트해야 함).

먼저, 다음은 SG 이벤트 코드를 기록해야 하는 템플릿입니다.
## 1. 코드 템플릿
### 이를 복사하여 붙여넣으면 새 플러그인을 시작할 수 있습니다.
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
## 2. 노트 제목 이름 바꾸기
### `New` 엔티티 이벤트 작업
이 작업은 간단해서 시작하기 좋지만 `Shotgun_Entity_New` 이벤트를 포착하는 것은 매우 까다로운 측면이기도 합니다.
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
함수 본문의 첫 번째 줄인 `sleep` 호출에 주목합니다. `new` 이벤트가 처리되는 방식을 다루기 때문입니다.
1. SG에서 새 엔티티가 생성될 때는 완전한 형태를 갖추지 않습니다. 즉, 엔티티를 사용할 때 해당 엔티티를 완전히 정의하는 데 필요한 모든 속성이 포함되어 있지 않습니다. 실제로 이 예제에서는 SG가 `subject` 이벤트를 내보내는 경우 `Shotgun_Note_New` 속성이 노트 엔티티에 있음을 보장할 수 없습니다.
2. 필요한 모든 속성을 추가하기 위해 SG는 필요한 경우 SG가 모든 단일 속성을 엔티티에 추가하고 해당 속성의 값을 업데이트하는 일련의 `Shotgun_Note_Change` 이벤트를 게시합니다.
3. 이렇게 하면 여러 개의 이벤트가 생성됩니다. 즉, 서로 다른 두 개의 속성이 있어야 하고 `sleep` 요소를 코드에 기록하지 않은 경우에는, 새로운 속성이 추가되고 값이 설정된 이벤트만 검색하는 내부 메타데이터 및 `Shotgun_Note_Change` 이벤트를 모두 거쳐야 합니다. 이 작업은 복잡한 프로세스이며 많은 `Shotgun_Note_Change` 이벤트 검색을 효과적으로 처리합니다(생성 시 노트별로 하나씩만).
4. 적합한 솔루션은 `Shotgun_Entity_New`를 사용하고 짧은 기간 동안 스크립트가 절전 모드로 전환되도록 하는 것입니다. 절전 모드가 끝나면 SG는 해당 엔티티에 필요한 모든 속성을 업데이트한 다음 필요한 필드에 대해 동일한 엔티티를 다시 쿼리할 수 있습니다.

## 2. 필드 삭제 경고
### 노트 생성, 필드를 엔티티로 사용, 엔티티 삭제 이벤트
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
매우 간단한 스크립트입니다. 삭제된 필드를 확인하는 특별한 로직이 없습니다. 필드가 삭제된 경우 노트가 생성되어 해당 정보를 알아야 하는 사용자 그룹으로 전송됩니다. 내 부서에서 그룹 ID를 'programmers' 그룹으로 설정하고 노트의 프로젝트 ID는 'development' 프로젝트로 설정했습니다.
