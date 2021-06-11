---
layout: default
title: Loader
pagename: tk-multi-loader2
lang: ko
---

# Loader

이 문서에서는 툴킷 구성에 대한 제어 권한이 있는 경우에만 사용할 수 있는 기능에 대해 설명합니다. 자세한 정보는 [{% include product %} 통합 사용자 안내서](https://support.shotgunsoftware.com/hc/ko/articles/115000068574-Integrations-User-Guide#The%20Loader)를 참조하십시오.

## 구성

Loader는 상세하게 구성할 수 있으며 여러 가지 방법으로 설정할 수 있습니다. 다음 두 가지 주요 구성 영역이 있습니다.

- 왼쪽 트리 뷰에 표시할 탭과 컨텐츠를 설정하는 영역
- 다른 게시에 표시할 액션을 제어하고 실제로 수행할 액션을 제어하는 영역

다음 섹션에서는 Loader를 구성할 수 있는 방법을 개괄적으로 설명합니다.
구성과 관련된 기술적 세부 사항은 이 문서에서 자세히 설명하는 별도 섹션을 참조하십시오.

### 트리 뷰

트리 뷰는 상세하게 구성할 수 있으며 표준 {% include product %} 필터 구문을 사용하여 다양한 탭의 컨텐츠를 제어할 수 있습니다. 각 탭은 계층으로 그룹 지정된 단일 {% include product %} API 쿼리로 구성됩니다. 임의의 필터를 추가하여 표시할 항목을 제어할 수 있으며 특수 키워드 `{context.entity}`, `{context.project}`, `{context.project.id}`, `{context.step}`, `{context.task}` 및 `{context.user}`를 사용하여 현재 컨텍스트를 기반으로 쿼리의 범위를 지정할 수 있습니다. 이러한 각 키워드는 관련 컨텍스트 정보로 대체되거나 컨텍스트의 해당 부분이 입력되지 않은 경우 또는 id, type 및 name 키가 포함된 표준 {% include product %} 링크 사전인 경우에는 `None`으로 대체됩니다.

기본적으로 Loader는 현재 프로젝트에 속한 에셋 및 샷을 표시합니다. 다시 구성하면 다른 프로젝트 또는 특정 에셋 라이브러리 프로젝트 등의 항목을 표시하는 등 쉽게 확장할 수 있습니다. 예를 들어 필터를 사용하여 특정 승인 상태의 항목만 표시하거나 상태별 또는 다른 {% include product %} 필드별로 그룹 항목을 표시할 수도 있습니다. 다음은 트리 뷰 탭을 설정할 수 있는 방법을 보여 주는 몇 가지 샘플 구성 설정입니다.

```yaml
# An asset library tab which shows assets from a specific
# {% include product %} project
caption: Asset Library
entity_type: Asset
hierarchy: [sg_asset_type, code]
filters:
- [project, is, {type: Project, id: 123}]

# Approved shots from the current project
caption: Shots
hierarchy: [project, sg_sequence, code]
entity_type: Shot
filters:
- [project, is, '{context.project}']
- [sg_status_list, is, fin]

# All assets for which the current user has tasks assigned
caption: Assets
entity_type: Task
hierarchy: [entity.Asset.sg_asset_type, entity, content]
filters:
- [entity, is_not, null]
- [entity, type_is, Asset]
- [task_assignees, is, '{context.user}']
- [project, is, '{context.project}']
```

### 게시 필터링

{% include product %}에서 게시 데이터를 로드할 때 Loader가 수행하는 게시 쿼리에 {% include product %} 필터를 적용할 수 있습니다. 이 필터는 `publish_filters` 매개변수를 통해 제어되며 승인되지 않은 게시 또는 연결된 리뷰 버전이 승인되지 않은 게시를 숨기는 작업 등에 사용할 수 있습니다.

### 액션이 표시되지 않을 경우

Loader는 각 엔진별로 다양한 *액션*이 제공됩니다. 예를 들어 Nuke의 경우 "스크립트 가져오기"와 "읽기 노드 만들기"의 두 가지 액션이 있습니다. 액션은 후크에 정의됩니다. 즉, 원하는 경우 동작을 수정하거나 액션을 추가할 수 있습니다. 그런 다음 Loader의 구성에서 이러한 액션을 특정 *게시 유형*에 바인딩합니다. 액션을 게시 유형에 바인딩하는 것은 기본적으로 액션이 Loader 내부의 모든 해당 유형의 항목에 대한 액션 메뉴에 표시됨을 의미합니다.

예를 들어 기본적으로 Nuke의 매핑은 다음과 같이 설정됩니다.

```
action_mappings:
  Nuke Script: [script_import]
  Rendered Image: [read_node]
```

액션 메뉴가 표시되지 않을 경우 사용 중인 게시 유형에 다른 이름을 선택했기 때문일 수 있습니다. 이 경우 구성으로 이동하고 해당 유형이 Loader 내부에 표시되도록 추가합니다.

### 액션 관리

Loader가 지원하는 각 응용프로그램에는 해당 응용프로그램에 대해 지원되는 액션을 구현하는 액션 후크가 있습니다. 예를 들어 Maya를 사용하면 기본 후크는 각각 특정 Maya 명령을 수행하는 `reference`, `import` 및 `texture_node` 액션을 구현하여 현재 Maya 씬으로 컨텐츠를 가져옵니다. 모든 후크와 마찬가지로 재정의 및 변경이 완벽히 가능하고, 기본 제공 후크로부터 파생되는 후크를 생성하는 것 역시 가능하기 때문에 많은 코드를 복제할 필요 없이 기본 제공 후크에 다른 액션을 쉽게 추가할 수 있습니다.

액션 후크에서 액션 목록을 정의한 후에는 이러한 액션을 게시 파일 유형에 바인딩할 수 있습니다. 예를 들어 이름이 "Maya Scene"인 파이프라인에 게시 파일 유형이 있는 경우 구성에서 이 유형을 후크에 정의된 `reference` 및 `import` 액션에 바인딩할 수 있습니다. 이를 통해 툴킷은 표시되는 각 Maya Scene 게시에 참조 및 가져오기 액션을 추가합니다. 이렇게 게시 유형을 실제 후크에서 분리하면 기본 구성과 함께 제공되는 설정이 아닌 다른 게시 유형 설정을 사용할 수 있도록 Loader를 쉽게 재구성할 수 있습니다.

Loader는 툴킷의 2세대 후크 인터페이스를 사용하기 때문에 그 유연성이 뛰어납니다. 이 후크 형식은 향상된 구문을 사용합니다. Loader용으로 설치된 기본 구성 설정에서 다음과 같은 후크를 볼 수 있습니다.

```
actions_hook: '{self}/tk-maya_actions.py'
```

`{self}` 키워드를 통해 툴킷은 앱 `hooks` 폴더에서 후크를 찾을 수 있습니다. 이 후크를 사용자 구현으로 재지정하려면 값을 `{config}/loader/my_hook.py`로 변경합니다. 이렇게 하면 툴킷이 구성 폴더에 있는 `hooks/loader/my_hook.py`라는 후크를 사용하게 됩니다.

Loader가 사용하고 있는 또 다른 2세대 후크 기능은 더 이상 `execute()` 방식을 필요로 하지 않습니다. 대신, 후크는 일반 클래스와 더 비슷하며 함께 그룹으로 지정하는 데 유용한 방식 컬렉션을 포함할 수 있습니다. Loader의 경우 액션 후크는 다음 두 가지 방식을 구현해야 합니다.

```
def generate_actions(self, sg_publish_data, actions, ui_area)
def execute_multiple_actions(self, actions)
```

자세한 정보는 앱과 함께 제공되는 후크 파일을 참조하십시오. 후크는 또한 상속을 이용합니다. 즉, 후크의 모든 사항을 재지정할 필요는 없지만 다양한 방식으로 기본 후크를 좀 더 쉽게 확장하거나 확대하여 보다 쉽게 후크를 관리할 수 있습니다.

`v1.12.0` 이전 버전에서는 응용프로그램이 `execute_action` 후크를 호출하여 액션을 실행했습니다. 최신 버전에서는 `execute_multiple_actions` 후크를 호출합니다. 기존 후크와의 호환성을 제공하기 위해 `execute_multiple_actions` 후크는 실제로 제공된 각각의 액션에 대해 `execute_action`을 호출합니다. 응용프로그램이 `v1.12.0` 이상으로 업그레이드 후 `execute_multiple_actions` 후크가 정의되지 않았다고 보고하는 경우 환경의 `actions_hook` 설정이 기본 제공 후크 `{self}/{engine_name}_actions.py`에서 올바르게 상속받는지 확인합니다. 기본 제공 후크에서 커스텀 후크를 파생하는 방법에 대한 자세한 정보는 [툴킷 참조 문서](http://developer.shotgridsoftware.com/tk-core/core.html#hook)를 참조하십시오.

LINKBOX_DOC:5#The%20hook%20data%20type: 2세대 후크 형식에 대한 자세한 정보는 여기에서 확인하십시오.

후크에서 상속을 사용하면 다음과 같은 기본 후크에 액션을 추가할 수 있습니다.

```python
import sgtk
import os

# toolkit will automatically resolve the base class for you
# this means that you will derive from the default hook that comes with the app
HookBaseClass = sgtk.get_hook_baseclass()

class MyActions(HookBaseClass):

    def generate_actions(self, sg_publish_data, actions, ui_area):
        """
        Returns a list of action instances for a particular publish.
        This method is called each time a user clicks a publish somewhere in the UI.
        The data returned from this hook will be used to populate the actions menu for a publish.

        The mapping between Publish types and actions are kept in a different place
        (in the configuration) so at the point when this hook is called, the loader app
        has already established *which* actions are appropriate for this object.

        The hook should return at least one action for each item passed in via the
        actions parameter.

        This method needs to return detailed data for those actions, in the form of a list
        of dictionaries, each with name, params, caption and description keys.

        Because you are operating on a particular publish, you may tailor the output
        (caption, tooltip etc) to contain custom information suitable for this publish.

        The ui_area parameter is a string and indicates where the publish is to be shown.
        - If it will be shown in the main browsing area, "main" is passed.
        - If it will be shown in the details area, "details" is passed.
        - If it will be shown in the history area, "history" is passed.

        Please note that it is perfectly possible to create more than one action "instance" for
        an action! You can for example do scene introspection - if the action passed in
        is "character_attachment" you may for example scan the scene, figure out all the nodes
        where this object can be attached and return a list of action instances:
        "attach to left hand", "attach to right hand" etc. In this case, when more than
        one object is returned for an action, use the params key to pass additional
        data into the run_action hook.

        :param sg_publish_data: {% include product %} data dictionary with all the standard publish fields.
        :param actions: List of action strings which have been defined in the app configuration.
        :param ui_area: String denoting the UI Area (see above).
        :returns List of dictionaries, each with keys name, params, caption and description
        """

        # get the actions from the base class first
        action_instances = super(MyActions, self).generate_actions(sg_publish_data, actions, ui_area)

        if "my_new_action" in actions:
            action_instances.append( {"name": "my_new_action",
                                      "params": None,
                                      "caption": "My New Action",
                                      "description": "My New Action."} )

        return action_instances


    def execute_action(self, name, params, sg_publish_data):
        """
        Execute a given action. The data sent to this be method will
        represent one of the actions enumerated by the generate_actions method.

        :param name: Action name string representing one of the items returned by generate_actions.
        :param params: Params data, as specified by generate_actions.
        :param sg_publish_data: {% include product %} data dictionary with all the standard publish fields.
        :returns: No return value expected.
        """

        # resolve local path to publish via central method
        path = self.get_publish_path(sg_publish_data)

        if name == "my_new_action":
            # do some stuff here!

        else:
            # call base class implementation
            super(MyActions, self).execute_action(name, params, sg_publish_data)
```

그런 다음 이 새 액션을 구성의 게시 유형 세트에 바인딩할 수 있습니다.

```yaml
action_mappings:
  Maya Scene: [import, reference, my_new_action]
  Maya Rig: [reference, my_new_action]
  Rendered Image: [texture_node]
```

위의 그림과 같이 후크에서 파생된 커스텀 후크 코드는 유지 관리 및 업데이트가 보다 쉽도록 실제 추가된 비즈니스 로직만 포함하면 됩니다.

## 참조

다음 방식은 앱 인스턴스에서 사용할 수 있습니다.

### open_publish()
'파일 열기' 스타일 버전의 Loader를 제공하여 사용자가 게시를 선택할 수 있습니다. 그러면 선택한 게시가 반환됩니다. 이 모드에서 실행할 때 앱에 구성된 일반 액션은 허용되지 않습니다.

app.open_publish( `str` **title**, `str` **action**, `list` **publish_types** )

**매개변수 및 반환값**
* `str` **title** - 게시 열기 대화상자에 표시할 제목입니다.
* `str` **action** - '열기' 버튼에 사용할 액션 이름입니다.
* `list` **publish_types** - 사용 가능한 게시 목록을 필터링하는 데 사용할 게시 유형 목록입니다. 이 값이 비어 있거나 None인 경우 모든 게시가 표시됩니다.
* **반환값:** 사용자가 선택한 {% include product %} 엔티티 사전 목록을 반환합니다.

**예**

```python
>>> engine = sgtk.platform.current_engine()
>>> loader_app = engine.apps.get["tk-multi-loader2"]
>>> selected = loader_app.open_publish("Select Geometry Cache", "Select", ["Alembic Cache"])
>>> print selected
```
