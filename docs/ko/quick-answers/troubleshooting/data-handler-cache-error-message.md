---
layout: default
title: sgtk.env.project.tk-nuke.tk-multi-workfiles2에서 파일 열기(File Open) 대화상자를 만들지 못했습니다!
pagename: data-handler-cache-error-message
lang: ko
---

# data_handler_cache 오류 메시지: 오류 sgtk.env.project.tk-nuke.tk-multi-workfiles2 파일 열기(File Open) 대화상자를 만들지 못했습니다!

## 활용 사례:

Nuke와 같은 앱을 시작하면 `tk-multi-workfiles2` 파일 열기(File Open) 대화상자가 실패하고 `data_handler_cache`의 `get_children` 메서드에 대한 스택 트래킹 마지막에 오류가 발생합니다. dict가 필요한데 문자열 값이 전달되어 반복하지 못하는 상태가 발생합니다.

전체 스택은 다음과 같습니다.

```
2020-12-07 09:42:03,571 [7192 ERROR sgtk.env.project.tk-nuke.tk-multi-workfiles2] Failed to create File Open dialog!
Traceback (most recent call last):
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-multi-workfiles2\v0.11.8\python\tk_multi_workfiles\work_files.py", line 115, in _show_file_dlg
    self._dialog_launcher(dlg_name, app, form)
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\core\python\tank\platform\engine.py", line 1822, in show_dialog
    dialog, widget = self._create_dialog_with_widget(title, bundle, widget_class, *args, **kwargs)
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\core\python\tank\platform\engine.py", line 1684, in _create_dialog_with_widget
    widget = self._create_widget(widget_class, *args, **kwargs)
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\core\python\tank\platform\engine.py", line 1658, in _create_widget
    widget = derived_widget_class(*args, **kwargs)
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-multi-workfiles2\v0.11.8\python\tk_multi_workfiles\file_open_form.py", line 46, in __init__
    FileFormBase.__init__(self, parent)
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-multi-workfiles2\v0.11.8\python\tk_multi_workfiles\file_form_base.py", line 64, in __init__
    self._my_tasks_model = self._build_my_tasks_model()
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-multi-workfiles2\v0.11.8\python\tk_multi_workfiles\file_form_base.py", line 134, in _build_my_tasks_model
    bg_task_manager=self._bg_task_manager)
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-multi-workfiles2\v0.11.8\python\tk_multi_workfiles\my_tasks\my_tasks_model.py", line 57, in __init__
    bg_task_manager=bg_task_manager
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-multi-workfiles2\v0.11.8\python\tk_multi_workfiles\entity_models\extended_model.py", line 74, in __init__
    **kwargs
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-framework-shotgunutils\v5.5.0\python\shotgun_model\shotgun_entity_model.py", line 70, in __init__
    self._load_data(entity_type, filters, hierarchy, fields)
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-framework-shotgunutils\v5.5.0\python\shotgun_model\shotgun_model.py", line 367, in _load_data
    self._create_item
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\core\python\tank\log.py", line 503, in wrapper
    response = func(*args, **kwargs)
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-framework-shotgunutils\v5.5.0\python\shotgun_model\data_handler.py", line 266, in generate_child_nodes
    for data_item in self._cache.get_children(unique_id):
  File "X:\sgtk_studio\_projects\Endlings2\shotgun_configuration\install\app_store\tk-framework-shotgunutils\v5.5.0\python\shotgun_model\data_handler_cache.py", line 129, in get_children
    for item in cache_node[self.CACHE_CHILDREN].itervalues():
AttributeError: 'str' object has no attribute 'itervalues'
```

## 오류의 원인은 무엇입니까?

캐싱에 문제가 있습니다. 캐시를 제거하면 수정할 수 있습니다(다음 섹션 참조).

## 해결 방법

[이 지침](https://developer.shotgridsoftware.com/ko/7c9867c0/)에 따라 캐시를 찾아 제거합니다. 전체를 제거하면 다음에 데스크톱을 다시 시작할 때 모든 항목을 다운로드해야 하므로 지연이 발생할 수 있습니다. 따라서 루트 캐시 폴더 내에 있는 {% include product %} 사이트의 이름을 따서 명명된 폴더를 지우는 것이 좋습니다. 그러면 그리 긴 지연이 발생하지 않습니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/data-handler-cache-error/10955)하십시오.

