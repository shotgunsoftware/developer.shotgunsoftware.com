---
layout: default
title: sgtk.env.project.tk-nuke.tk-multi-workfiles2 无法创建“文件打开”(File Open)对话框！
pagename: data-handler-cache-error-message
lang: zh_CN
---

# data_handler_cache 错误消息: 错误 sgtk.env.project.tk-nuke.tk-multi-workfiles2 无法创建“文件打开”(File Open)对话框！

## 用例：

它发生在启动 Nuke 等应用时，`tk-multi-workfiles2`“文件打开”(File Open)对话框失败，在堆栈跟踪的末尾出现错误，指出 `data_handler_cache` 的 `get_children` 方法无法迭代，因为在应该传递词典时向它传递了字符串值。

完整的堆栈如下所示：

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

## 导致错误的原因是什么？

缓存中出现问题，您应该能够通过移除缓存来修复它（请参见下一部分）。

## 如何修复

[请按照以下说明](https://developer.shotgridsoftware.com/zh_CN/7c9867c0/)了解在何处查找缓存并将其移除。您可以擦除所有内容，但是当下次重新启动 Desktop 时，会在下载所有内容时导致延迟。建议您擦除以位于根缓存文件夹内的 {% include product %} 站点命名的文件夹，该文件夹仍需要进行一些重建，但不会太多。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/data-handler-cache-error/10955)。

