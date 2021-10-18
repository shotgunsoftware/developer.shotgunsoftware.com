---
layout: default
title: 调用 __commands::unreal_engine 时出错
pagename: unreal-proxy-error-message
lang: zh_CN
---

# `[ERROR] [PROXY]` 调用 __commands::unreal_engine 时出错]

## 用例：

现在，设置 {% include product %} 桌面应用并能够使 UE4 在 {% include product %} 应用中显示后，当我尝试启动 Unreal 时，收到以下消息：

```
2020-06-06 03:22:24,246 [ ERROR] [PROXY] Error calling __commands::unreal_engine_4.24.3((), {}):
Traceback (most recent call last):
File “C:\Users\USER0\AppData\Roaming\Shotgun\bundle_cache\app_store\tk-desktop\v2.4.12\python\tk_desktop\desktop_engine_project_implementation.py”, line 164, in _trigger_callback
callback(*args, **kwargs)
File “C:\Users\USER0\AppData\Roaming\Shotgun\babilgames\p91c38.basic.desktop\cfg\install\core\python\tank\platform\engine.py”, line 1084, in callback_wrapper
return callback(*args, **kwargs)
File “C:\Users\USER0\AppData\Roaming\Shotgun\bundle_cache\app_store\tk-multi-launchapp\v0.10.2\python\tk_multi_launchapp\base_launcher.py”, line 125, in launch_version
*args, **kwargs
File “C:\Users\USER0\AppData\Roaming\Shotgun\bundle_cache\app_store\tk-multi-launchapp\v0.10.2\python\tk_multi_launchapp\base_launcher.py”, line 343, in _launch_callback
“Could not create folders on disk. Error reported: %s” % err
TankError: Could not create folders on disk. Error reported: Could not resolve row id for path! Please contact support! trying to resolve path ‘D:\UEProjects\SON\D:\UEProjects\SON’. Source data set: [{‘path_cache_row_id’: 2, ‘path’: ‘D:\UEProjects\SON’, ‘metadata’: {‘root_name’: ‘primary’, ‘type’: ‘project’}, ‘primary’: True, ‘entity’: {‘type’: ‘Project’, ‘id’: 91, ‘name’: ‘SON’}}]

```

## 导致错误的原因是什么？

磁盘上 UE4 项目的路径 `D:\UEProjects\PROJECT_NAME\` 不正确。

## 如何修复

为 {% include product %} 的设置创建新文件夹可解决该问题。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/error-launching-ue4-from-shotgun/8938)。

