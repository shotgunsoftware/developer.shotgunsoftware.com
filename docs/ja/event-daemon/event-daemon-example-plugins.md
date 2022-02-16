---
layout: default
title: サンプル プラグイン
pagename: event-daemon-example-plugins
lang: ja
---

# サンプル プラグイン

ソース コードには、[サンプル プラグインのフォルダ](https://github.com/shotgunsoftware/shotgunEvents/tree/master/src/examplePlugins)があります。

このページには、作業を開始するユーザのためのいくつかの簡単なサンプルが含まれています。このコードはコピーと貼り付けによって実行できます(注: `script_name` と `script_key` の値をインストールに合わせて更新する必要があります)。

まず、ここに SG イベント コードを記述するテンプレートがあります。
## 1. コード テンプレート
### 新規プラグインを開始するには、これをコピーして貼り付けます
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
## 2. ノートの件名の名前変更
### `New` エンティティ イベントを使用する
これは単純ですが、`Shotgun_Entity_New` イベントを捕捉するという複雑な処理も実行できるので、開始点として優れています...
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
`sleep` の呼び出しが、関数本体の最初の行であることに注意してください。この理由は、`new` イベントの処理方法に関係があります。
1. SG で新しいエンティティを作成すると、そのエンティティにはまだ形式はありません。つまり、使い慣れたエンティティを完全に定義するために必要なアトリビュートのすべてが設定されていません。実際、この例では、SG が `subject` イベントを発行する場合に、`Shotgun_Note_New` アトリビュートがノート エンティティ上に存在するという保証さえもできません。
2. 必要なすべてのアトリビュートを追加するために、SG は次に一連の `Shotgun_Note_Change` イベントをパブリッシュします。このイベントでは、SG はそれぞれの単一のアトリビュートをエンティティに追加し、必要に応じてこれらのアトリビュートの値を更新します。
3. これは、さまざまなイベントが作成されることを意味します。つまり、2 つの異なるアトリビュートが存在する必要があり、コードに `sleep` の側面を記述していない場合、すべての `Shotgun_Note_Change` イベントと内部メタデータを調べて、新しいアトリビュートが追加され、値が設定されたイベントのみを検索する必要があります。これは面倒なプロセスであり、作成時にノートごとに 1 つのイベントを効果的に見つけるために数多くの `Shotgun_Note_Change` イベントを処理します。
4. この問題に対する解決策は、`Shotgun_Entity_New` を利用してスクリプトを短時間スリープ状態にすることです。スリープ状態の最後に、SG はエンティティに必要なすべてのアトリビュートを更新し、必要な任意のフィールドに対して同じエンティティを再クエリーできます。

## 2. フィールド削除の警告
### ノートの生成、エンティティとしてのフィールドの操作、エンティティの廃棄イベント
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
これは非常に単純なスクリプトです。削除されたフィールドをチェックする場合、特別なロジックはありません。フィールドが削除されると、ノートが作成され、それを必要とするユーザのグループに送信されます。ある部署では、グループ ID を「programmers」グループに設定し、ノートのプロジェクト ID を「development」プロジェクトに設定しています。
