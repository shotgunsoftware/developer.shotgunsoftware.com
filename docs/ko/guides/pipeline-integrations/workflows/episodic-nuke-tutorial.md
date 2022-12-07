---
layout: default
title: Nuke Studio의 에피소드 워크플로우
pagename: episodic-nuke-tutorial
lang: ko
---

# Nuke Studio의 에피소드 워크플로우


## 소개 및 준비 작업


이 문서에서는 Nuke Studio 또는 Hiero에서 `tk-hiero-export` 앱으로 에피소드 워크플로우를 시작하고 실행하는 방법에 대해 설명합니다. 명확하게 정해진 방법은 없으며 원하는 워크플로우에 따라 접근 방식이 약간 다를 수 있습니다. 이 예제에서는 다음과 같이 가정합니다.

* 목표는 `Episode > Sequence > Shot`의 3계층을 설정하는 것입니다.
* [파일 시스템 구성 안내서](https://developer.shotgridsoftware.com/ko/82ff76f7/)의 단계를 읽고 완료합니다.
* `CustomEntity02`가 아닌 `Episode` 엔티티 유형을 사용합니다(둘 다 이름만 다를 뿐 동일한 방식으로 작업할 수 있음).
* `Sequence` 엔티티에는 `episode`라는 엔티티 필드가 있습니다.
* Hiero의 경우에도 프로세스는 동일하지만 Nuke Studio를 사용합니다.
* 툴킷 프로젝트에 대한 [기본 구성](https://github.com/shotgunsoftware/tk-config-default2)부터 시작합니다.

시작하기 전에 `Episode`를 확인하는 방법도 결정해야 합니다. 기본 제공 {% include product %} Hiero/Nuke Studio 내보내기 프로세스에서는 Nuke Studio 프로젝트의 컨텐츠에 기반하여 {% include product %} 사이트에 `Sequence` 및 `Shot` 엔티티를 생성합니다. 따라서 툴킷을 사용하여 Maya에서 작업할 때는 에셋 및 태스크를 미리 만드는 것이 좋지만 이와 달리 Nuke Studio에서는 `Episodes` `Sequences` 또는 `Shots`을 미리 만들 필요가 없습니다. 즉, Nuke Studio에서 `Episode`를 정의하는 방법을 결정해야 합니다. 가능한 옵션은 다음과 같습니다.

* 먼저 {% include product %}에서 에피소드를 만들고 에피소드 컨텍스트에서 작동하도록 Nuke Studio 툴킷 통합을 구성하면 내보낼 때 현재 씬 컨텍스트에서 `Episode` 엔티티를 가져올 수 있습니다.
* `Episode` 엔티티가 아직 생성되지 않았다고 가정하고 Nuke Studio의 태그 지정 기능을 활용하여 에피소드 이름으로 시퀀스에 태그를 지정하고 이를 사용하여 내보낼 때 `Episode`를 확인합니다.

Nuke Studio 시퀀스 또는 샷 이름의 일부에서 에피소드 이름을 추출(예: "ep1_s01" 시퀀스의 "ep1" 비트 사용)하는 등 워크플로우에 더 적합한 다른 방법이 있을 수 있습니다. 또는 내보내기 앱의 [hiero_customize_export_ui.py](https://areadownloads.autodesk.com/wdm/shotgrid/tu-episodic-nuke.zip) 후크를 사용하여 에피소드와 내보내기를 링크할 GUI를 추가할 수 있습니다.

이 예에서는 두 번째 옵션인 시퀀스 태그 지정 솔루션을 사용합니다.

*이 연습은 3개의 계층 레이어(`Episode > Sequence > Shot`)를 구현하기 위한 것입니다. 간단하게 `Sequence` 엔티티 유형을 `Episodes` 엔티티 유형으로 대체하는 프로세스(`Episode > Shot`)는 더 쉽습니다. 이 시나리오는 이 안내서의 마지막 부분에서 간단하게 다룹니다. 나머지 부분을 살펴보면 보다 잘 이해할 수 있습니다.*

## 스키마 및 템플릿


앞서 설명한 바와 같이, 이 예에서는 [스키마 및 템플릿을 업데이트](https://developer.shotgridsoftware.com/ko/82ff76f7/#how-can-i-add-a-new-entity-type-to-my-file-structure)했다고 가정합니다. 또한 올바른 부분에 에피소드 키를 포함하도록 templates.yml의 `hiero_plate_path` 및 `hiero_render_path` 경로 값도 업데이트해야 합니다.

## 후크 및 설정


{% include product %} 내보내기 프로세스를 가져와 `Episode`를 올바르게 처리하려면 내보내기 후크의 일부를 수정해야 합니다. 이 문서에서는 [후크](https://developer.shotgridsoftware.com/ko/312b792f/#using-frameworks-from-hooks)가 무엇인지와 기본 구현을 재정의하는 방법을 잘 알고 있다고 가정합니다.

다음은 에피소드를 활성화하는 데 도움이 되는 두 개의 내보내기 후크입니다.

* `hiero_get_shot.py`
* `hiero_resolve_custom_strings.py`

참고: `hiero_translate_template.py`라는 세 번째 후크가 있지만 이 예에서는 사용하지 않습니다. 이 후크는 시퀀스를 에피소드로 대체하고 두 개의 레이어 계층을 유지하려는 경우에만 필요합니다. 여기에 대해서는 문서 마지막에 좀 더 다룹니다.

에피소드를 찾을 수 있도록 `hiero_get_shot.py`를 수정하고 {% include product %}에서 이에 대한 엔티티를 만듭니다. 그리고 Nuke Studio가 경로에서 {Episode} 키에 제공할 값을 알 수 있도록 `hiero_resolve_custom_strings.py`를 수정합니다. 다음은 자세한 단계입니다.

### 1. 에피소드 필드 추가

이제 `Episode`라는 템플릿에 새 키가 있고 이를 확인하는 방법을 `tk-hiero-export` 앱에 지정해야 합니다. `<pipeline_configuration>/config/env/includes/settings/tk-hiero-export.yml` 파일에서 `custom_template_fields`를 다음과 같이 수정합니다.

```
 settings.tk-hiero-export:  
    custom_template_fields: [{keyword: Episode, description: The episode name}]  
 ...
```

그러면 `{Episode}`라는 유효한 내보내기 토큰이 Hiero 내보내기에 추가됩니다.

### 2. hiero_get_shot 후크

이제 `hiero_get_shot.py` 후크를 사용하여 내보내기 프로세스에 에피소드 이름을 찾는 방법을 지정하고 {% include product %}에서 `Episode`를 만들어야 합니다.

[후크의 기본 버전(hiero_get_shot.py)](https://areadownloads.autodesk.com/wdm/shotgrid/tu-episodic-nuke.zip)은 TrackItem과 이름이 같은 {% include product %}의 `Shot`을 반환합니다. `Shot`은 Nuke Studio 시퀀스 항목과 이름이 같은 `Sequence`에 링크되어야 합니다. `Sequence` 또는 `Shot`이 {% include product %}에 없으면 후크가 이를 만듭니다. 다른 계층 수준을 추가하고 있으므로 `Episode`가 없는 경우 이 또한 후크가 만들도록 해야 합니다.

`Sequence`는 `Episode`에 링크되므로 `Sequence`를 조회하는 코드에 연결해야 합니다(`get_shot_parent()` 메서드).

구성의 후크 폴더에 `hiero_get_shot.py` 파일을 만들고 `hook_get_shot: '{config}/hiero_get_shot.py'`를 `tk-hiero-export.yml` 설정에 다음과 같이 추가합니다.

```
 settings.tk-hiero-export:  
    custom_template_fields: [{keyword: Episode, description: The episode name}]  
    hook_get_shot: '{config}/hiero_get_shot.py'
```

다음은 `hiero_get_shot.py` 후크에 대한 전체 코드입니다. 이를 사용자가 만든 후크에 추가합니다.

```
from sgtk import Hook

class HieroGetShot(Hook):
    """
    Return a  {% include product %}  Shot dictionary for the given Hiero items
    """

    def execute(self, task, item, data, **kwargs):
        """
        Takes a hiero.core.TrackItem as input and returns a data dictionary for
        the shot to update the cut info for.
        """

       # get the parent entity for the Shot
       parent = self.get_shot_parent(item.parentSequence(), data, item=item)

       # shot parent field
       parent_field = "sg_sequence"

       # grab shot from  {% include product %}
       sg = self.parent.shotgun
       filter = [
           ["project", "is", self.parent.context.project],
           [parent_field, "is", parent],
           ["code", "is", item.name()],
        ]

       # default the return fields to None to use the python-api default
       fields = kwargs.get("fields", None)
       shots = sg.find("Shot", filter, fields=fields)
       if len(shots) > 1:
           # can not handle multiple shots with the same name
           raise StandardError("Multiple shots named '%s' found", item.name())
       if len(shots) == 0:
           # create shot in {{ akn_product_name_lower }}
           shot_data = {
               "code": item.name(),
               parent_field: parent,
               "project": self.parent.context.project,
           }
           shot = sg.create("Shot", shot_data, return_fields=fields)
           self.parent.log_info("Created Shot in  {% include product %} : %s" % shot_data)
       else:
           shot = shots[0]

       # update the thumbnail for the shot
       upload_thumbnail = kwargs.get("upload_thumbnail", True)
       if upload_thumbnail:
           self.parent.execute_hook(
               "hook_upload_thumbnail",
               entity=shot,
               source=item.source(),
               item=item,
               task=kwargs.get("task")
           )

       return shot

    def get_episode(self, data=None, hiero_sequence=None):
        """
        Return the {{ akn_product_name_lower }} episode for the given Nuke Studio items.
        We define this as any tag linked to the sequence that starts
        with 'Ep'.
        """

       # If we had setup Nuke Studio to work in an episode context, then we could
       # grab the episode directly from the current context. However in this example we are not doing this but here
       # would be the code.
       # return self.parent.context.entity

       # stick a lookup cache on the data object.
       if "epi_cache" not in data:
           data["epi_cache"] = {}

       # find episode name from the tags on the sequence
       nuke_studio_episode = None
       for t in hiero_sequence.tags():
           if t.name().startswith('Ep'):
               nuke_studio_episode = t
               break
       if not nuke_studio_episode:
           raise StandardError("No episode has been assigned to the sequence: %s" % hiero_sequence.name())

       # For performance reasons, lets check if we've already added the episode to the cache and reuse it
       # Its not a necessary step, but it speeds things up if we don't have to check {{ akn_product_name_lower }} for the episode again
       # this session.
       if nuke_studio_episode.guid() in data["epi_cache"]:
           return data["epi_cache"][nuke_studio_episode.guid()]

       # episode not found in cache, grab it from  {% include product %}
       sg = self.parent.shotgun
       filters = [
           ["project", "is", self.parent.context.project],
           ["code", "is", nuke_studio_episode.name()],
       ]
       episodes = sg.find("Episode", filters, ["code"])
       if len(episodes) > 1:
           # can not handle multiple episodes with the same name
           raise StandardError("Multiple episodes named '%s' found" % nuke_studio_episode.name())

       if len(episodes) == 0:
           # no episode has previously been created with this name
           # so we must create it in {{ akn_product_name_lower }}
           epi_data = {
               "code": nuke_studio_episode.name(),
               "project": self.parent.context.project,
           }
           episode = sg.create("Episode", epi_data)
           self.parent.log_info("Created Episode in  {% include product %} : %s" % epi_data)
       else:
           # we found one episode matching this name in {{ akn_product_name_lower }}, so we will resuse it, instead of creating a new one
           episode = episodes[0]

       # update the cache with the results
       data["epi_cache"][nuke_studio_episode.guid()] = episode

       return episode

    def get_shot_parent(self, hiero_sequence, data, **kwargs):
        """
        Given a Hiero sequence and data cache, return the corresponding entity
        in  {% include product %}  to serve as the parent for contained Shots.

        :param hiero_sequence: A Hiero sequence object
        :param data: A dictionary with cached parent data.

        .. note:: The data dict is typically the app's `preprocess_data` which maintains the cache across invocations of this hook.        

        """
        # stick a lookup cache on the data object.
        if "parent_cache" not in data:
            data["parent_cache"] = {}

        if hiero_sequence.guid() in data["parent_cache"]:
            return data["parent_cache"][hiero_sequence.guid()]

        episode = self.get_episode(data, hiero_sequence)

        # parent not found in cache, grab it from  {% include product %}  

        sg = self.parent.shotgun filter = [
            ["project", "is", self.parent.context.project],
            ["code", "is", hiero_sequence.name()],
            ["episode", "is", episode],
            ]

        # the entity type of the parent.
        par_entity_type = "Sequence"

        parents = sg.find(par_entity_type, filter)
        if len(parents) > 1:
            # can not handle multiple parents with the same name
            raise StandardError(
                "Multiple %s entities named '%s' found" % (par_entity_type, hiero_sequence.name())
                )

        if len(parents) == 0:
            # create the parent in {{ akn_product_name_lower }}
            par_data = {
                "code": hiero_sequence.name(),
                "project": self.parent.context.project,
                "episode": episode,
                }

            parent = sg.create(par_entity_type, par_data)
            self.parent.log_info(
                "Created %s in  {% include product %} : %s" % (par_entity_type, par_data)
                )
        else:
            parent = parents[0]

        # update the thumbnail for the parent
        upload_thumbnail = kwargs.get("upload_thumbnail", True)

        if upload_thumbnail:
            self.parent.execute_hook(
                "hook_upload_thumbnail", entity=parent, source=hiero_sequence, item=None
            )

        # cache the results
        data["parent_cache"][hiero_sequence.guid()] = parent
        return parent
```

#### 시퀀스 가져오기

위 코드를 사용하여 `get_shot_parent()` 메서드를 수정했습니다. 이제 `Sequence`를 찾거나 만들 때 새 `get_episode()` 방식에서 반환된 `Episode`를 사용합니다. {% include product %} 데이터베이스의 기존 `Sequence`를 확인할 때 이제 `episode</code< field`로 필터링되고 `Sequence`를 만들 때 시퀀스의 `episode` 필드가 `get_episode()`에서 반환된 `Episode`로 채워집니다.


#### 에피소드 가져오기

그렇다면 에피소드는 어떻게 가져올까요? `get_episode()` 방식 코드는 `get_shot_parent()` 방식과 매우 유사하지만 `Sequence` 대신 `Episode`를 검색하도록 수정되었습니다.

이 안내서에서는 태그를 사용하여 Nuke Studio에서 에피소드를 할당합니다. 예를 들어 Nuke Studio에서 "Ep01"이라는 태그를 만들 수 있습니다. 그런 다음 이 태그를 Nuke Studio의 시퀀스에 적용합니다.

상위 수준에서 `get_episode()` 방식은 Nuke Studio의 시퀀스 항목에 적용된 모든 태그를 확인하여 "Ep"로 시작하는 태그가 있으면 에피소드 이름을 정의하는 태그로 가정합니다. 그런 다음 이 메서드는 {% include product %}에서 일치하는 `Episode`를 찾아서 반환하고 아직 없는 경우에는 만듭니다. 또한 찾기 호출을 다시 수행할 필요가 없도록 이 정보를 캐시합니다.

*다른 방식으로 에피소드를 가져오려면, 예를 들어 컨텍스트에서 또는 시퀀스나 샷 이름의 첫 번째 섹션을 사용하여 가져오려면 이 방식의 해당 로직을 사용합니다.*


#### 샷 가져오기

hiero_get_shot 후크의 주 목적은 {% include product %}에서 샷 데이터를 반환하는 것입니다. `Sequence`가 해당 상위를 가져오는 방법만 수정해야 하므로 실제로 샷을 가져오는 로직을 수정할 필요는 없습니다. 또한 커스텀 필드를 통해 `Shot`을 `Episode`와 링크하려면 실행 방식의 코드도 수정해야 합니다. `parent[“episode”]`와 같이 `Sequence`에서 `Episode`에 액세스한 다음 이를 만들기 호출의 샷에 링크합니다.


### 3. Hiero_resolve_custom_strings.py

인계받아야 할 두 번째 후크는 `hiero_resolve_custom_strings.py`입니다. 이를 통해 Nuke Studio 내보내기의 경로를 확인할 수 있습니다. 다시 한 번 후크 폴더에 후크를 만들고 `hook_resolve_custom_strings: {config}/hiero_resolve_custom_strings.py` 설정을 `tk-hiero-export.yml` 파일에 추가해야 합니다.

1단계에서 추가한 커스텀 키 `{Episode}`가 이 후크로 전달되고 내보내기 앱에서는 확인된 폴더 이름이 반환될 것으로 예상합니다. 후크는 전달된 키가 `{Episode}`인지 확인해야 합니다. 맞을 경우 `hiero_get_shot.py` 후크에서 `get_episode()` 방식을 재사용하여 `Episode` 엔티티를 가져옵니다. `Episode`가 있으면 코드는 에피소드 이름을 추출하여 폴더를 생성할 수 있습니다.

후크의 전체 코드는 다음과 같습니다.

```
from sgtk import Hook


class HieroResolveCustomStrings(Hook):
    """Translates a keyword string into its resolved value for a given task."""
    # cache of shots that have already been pulled from {{ akn_product_name_lower }}
    _sg_lookup_cache = {}

    def execute(self, task, keyword, **kwargs):
        """
        The default implementation of the custom resolver simply looks up
        the keyword from the {{ akn_product_name_lower }} shot dictionary.

        For example, to pull the shot code, you would simply specify 'code'.
        To pull the sequence code you would use 'sg_sequence.Sequence.code'.
        """

        if keyword == "{Episode}":
            episode_entity = self.parent.execute_hook_method(
                "hook_get_shot",
                "get_episode",
                data=self.parent.preprocess_data,
                hiero_sequence=task._item.parentSequence(),
            )
            # hard coded to return the name of the episode
            # if however your folder for the episode in the schema, is not just made up from the code field
            # you need to get it to return what ever string value the folder would normally be created with.
            return episode_entity['code']

        shot_code = task._item.name()

        # grab the shot from the cache, or the get_shot hook if not cached
        sg_shot = self._sg_lookup_cache.get(shot_code)
        if sg_shot is None:
            fields = [ctf['keyword'] for ctf in self.parent.get_setting('custom_template_fields')]
            sg_shot = self.parent.execute_hook(
                "hook_get_shot",
                task=task,
                item=task._item,
                data=self.parent.preprocess_data,
                fields=fields,
                upload_thumbnail=False,
            )

            self._sg_lookup_cache[shot_code] = sg_shot

        self.parent.log_info("_sg_lookup_cache: %s" % (self._sg_lookup_cache))

        if sg_shot is None:
            raise RuntimeError("Could not find shot for custom resolver: %s" % keyword)

        # strip off the leading and trailing curly brackets
        keyword = keyword[1:-1]
        result = sg_shot.get(keyword, "")

        self.parent.log_debug("Custom resolver: %s[%s] -> %s" % (shot_code, keyword, result))
        return result

```

스키마 에피소드 폴더 이름이 `code` 필드가 아닌 다른 필드에서 생성되는 경우에는 해당 이름을 여기에 복제해야 합니다.

좀 더 복잡하지만 보다 정확한 해결 방법은 templates.yml에 `episode_root` 템플릿을 추가한 다음 템플릿에서 필드를 가져오는 것입니다. 이렇게 하면 스키마에서 에피소드 폴더 이름을 변경해도 반환되는 폴더 이름은 항상 스키마와 일치합니다. 다음과 같습니다.

```
ctx = tk.context_from_entity("Episode", episode_entity[id])
my_template = tk.templates["episode_root"]
fields = my_template.get_fields(ctx.filesystem_locations[0])
return fields["Episode"]

```

## 마무리


이제 마무리 단계입니다. 변경 사항이 제대로 작동하는지만 테스트하면 됩니다.

Nuke Studio를 시작하고 프로젝트를 만들어 시퀀스와 footage로 채우면 이제 내보내기 프로세스를 테스트할 수 있습니다. 먼저 에피소드 태그를 만듭니다. `Ep`로 시작하는 시퀀스에 대한 태그를 찾도록 후크를 코딩했으므로 태그 이름을 `Ep…`로 지정해야 합니다.

![에피소드 태그 만들기](/images/tutorial/tu-episodic-nuke-mceclip0-01.png)

이제 시퀀스에 태그를 추가합니다.

![시퀀스에 태그를 추가합니다](./images/tutorial/tu-episodic-nuke-mceclip2-02.png)  
![시퀀스에 태그 추가](/images/tutorial/tu-episodic-nuke-mceclip1-03.png)

완료되면 태그가 지정된 시퀀스에서 샷을 내보냅니다.


![샷 내보내기](/images/tutorial/tu-episodic-nuke-mceclip4-04.png)

구조 내보내기 계층이 스키마의 계층과 일치하는지 확인합니다. 일치하지 않을 경우 [구조를 새로 고쳐야](#tip-refresh) 할 수 있습니다.

![구조 내보내기 계층](/images/tutorial/tu-episodic-nuke-mceclip3-05.png)


내보내기(Export)를 클릭하면 {% include product %} 사이트에 에피소드, 시퀀스 및 샷이 만들어질 뿐만 아니라 디스크에 폴더 구조가 만들어집니다. 문제가 발생할 경우, 가능한 모든 오류에 대해 Nuke Studio 스크립트 편집기 또는 [ {% include product %} 로그(tk-nukestudio.log)](https://developer.shotgridsoftware.com/ko/38c5c024/)를 확인하십시오.

이로써 안내서가 완료되었습니다. 물론 이는 에피소드 작업을 수행하는 많은 방법 중 하나일 뿐이며 스튜디오에 가장 적합한 접근 방법 및 구조를 사용하면 됩니다.

## 시퀀스를 에피소드와 교체


위에서 간단하게 언급한 대로 기본 시퀀스/샷 계층을 에피소드/샷과 교체하려면 Nuke Studio 시퀀스 항목을 에피소드 이름의 소스로 사용할 수 있습니다.

1. 에피소드/샷 구조를 사용하여 작업하도록 스키마 및 템플릿을 설정합니다.

2. 위에 표시된 대로 기본 `hiero_get_shot.py` 후크를 인계받습니다. 그러나 이번에는 `parent_field` 변수 값을 `sg_episode`로 변경하고(샷 엔티티에 에피소드 필드가 있어야 함) `par_entity_type` `variable value to` `Episode`로 변경합니다.

3. `hiero_translate_template.py` 후크를 인계받고 후크 파일에서 매핑을 변경합니다.

```
 mapping = {
   "{Episode}": "{sequence}",
   "{Shot}": "{shot}",
   "{name}": "{clip}",
   "{version}": "{tk_version}",
}

```


에피소드 키는 Nuke Studio 시퀀스 키 값으로 확인됩니다.

> **팁:** <a id="tip-refresh"></a> 이러한 변경을 수행하기 전에 Hiero/Nuke Studio 프로젝트를 열었거나, 변경하는 동안 테스트하려는 경우에는 내보내기 경로를 재설정해야 할 수 있습니다. 내보내기 대화상자를 열면 Nuke Studio가 내보내기 트리를 캐시하므로 변경 사항을 스키마로 다시 로드하려면 새로 고침 버튼을 눌러 다시 빌드해야 합니다.