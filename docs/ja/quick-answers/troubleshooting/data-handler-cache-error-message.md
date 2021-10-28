---
layout: default
title: sgtk.env.project.tk-nuke.tk-multi-workfiles2 Failed to create File Open dialog!
pagename: data-handler-cache-error-message
lang: ja
---

# data_handler_cache error message: ERROR sgtk.env.project.tk-nuke.tk-multi-workfiles2 Failed to create File Open dialog!

## 使用例:

このエラーは、Nuke などのアプリを起動したときに発生します。`data_handler_cache` の `get_children` メソッドに関するスタック トレースの最後にエラーが発生して、`tk-multi-workfiles2` の[File Open]ダイアログ ボックスが障害状態になり、操作できなくなりました。原因は、dict 値が予期されていたのに、文字列値が渡されたことです。

スタック全体は次のようになります。

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

## エラーの原因

キャッシュに問題が発生したため、キャッシュを削除して修正する必要があります(次のセクションを参照)。

## 修正方法

キャッシュの場所と削除方法については、[こちら](https://developer.shotgridsoftware.com/ja/7c9867c0/)の手順に従ってください。全体を削除することはできますが、そうすると、すべてをダウンロードする必要が生じて、次回に Desktop を再起動するときに遅延が生じます。ルート キャッシュ フォルダ内にある {% include product %} サイトに由来する名前の付いたフォルダを削除することをお勧めします。この場合も若干の再構築が行われますが、それほど時間はかかりません。

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/data-handler-cache-error/10955)を参照してください。

