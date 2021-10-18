---
layout: default
title: __commands::unreal_engine을 호출하는 동안 오류 발생
pagename: unreal-proxy-error-message
lang: ko
---

# `[ERROR] [PROXY]` __commands::unreal_engine]을 호출하는 동안 오류 발생

## 활용 사례:

{% include product %} 데스크톱 앱을 설정하고 {% include product %} 앱에 UE4를 표시할 수 있게 된 후 Unreal을 실행하려고 하면 다음 메시지가 표시됩니다.

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

## 오류의 원인은 무엇입니까?

디스크의 UE4 프로젝트 경로(`D:\UEProjects\PROJECT_NAME\`)가 잘못되었습니다.

## 해결 방법

{% include product %} 설정에 대한 새 폴더를 만들면 문제가 해결됩니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/error-launching-ue4-from-shotgun/8938)하십시오.

