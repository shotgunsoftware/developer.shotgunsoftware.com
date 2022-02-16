---
layout: default
title: 오류 {% include product %} tk-maya 툴킷에서 예외가 발생했습니다.
pagename: tk-maya-exception-error-message
lang: ko
---

# 오류: {% include product %} tk-maya: 툴킷에서 예외가 발생했습니다.

## 활용 사례

툴킷 앱이 실행을 트리거할 때 커스텀 인자를 수신하도록 설정할 수 있습니다.

예를 들어, 앱을 실행할 때 상태에 따라 앱이 다르게 시작되도록 하는 상태 플래그를 제공할 수 있습니다.

다음은 이미 사용되고 있는 몇 가지 예입니다.

- `tk-shotgun-folders` 앱(Shotgun 웹 앱에서 선택한 엔티티를 기반으로 폴더 생성)은 사용자가 Shotgun 웹 앱에서 선택하고 다음에서 액션을 실행한 Shotgun 엔티티 및 엔티티 유형을 전달합니다.
   https://github.com/shotgunsoftware/tk-shotgun-folders/blob/v0.1.7/app.py#L86
- `tk-multi-launchapp`(Shotgun 통합을 통해 소프트웨어 시작을 담당)은 `file_to_open` 인자를 전달할 수 있습니다. 이 인자는 소프트웨어를 시작한 후 파일을 여는 데 사용됩니다.
   https://github.com/shotgunsoftware/tk-multi-launchapp/blob/v0.11.2/python/tk_multi_launchapp/base_launcher.py#L157
   일반적으로 {% include product %} 데스크톱을 통해 소프트웨어를 시작하면 `file_to_open` 인자가 제공되지 않지만, 중앙 집중식 구성(`tank maya_2019 /path/to/maya/file.mb`)을 사용하는 경우 tank 명령을 통해 앱을 호출할 수 있습니다.
   또한 `tk-shotgun-launchpublish` 앱도 `tk-multi-launchapp`을 시작하고 게시된 파일을 `file_to_open` 인자로 제공합니다.
   https://github.com/shotgunsoftware/tk-shotgun-launchpublish/blob/v0.3.2/hooks/shotgun_launch_publish.py#L126-L133

## 인자를 허용하도록 앱 프로그래밍

[커스텀 앱을 작성](https://developer.shotgridsoftware.com/2e5ed7bb/)하는 경우 필요한 인자를 허용하도록 엔진에 등록되는 콜백 메서드만 설정하면 됩니다.
다음은 두 개의 인자가 필요하고 추가 인자를 허용하고 출력하도록 설정된 간단한 앱입니다.

```python
from sgtk.platform import Application


class AnimalApp(Application):

    def init_app(self):
        self.engine.register_command("print_animal", self.run_method)

    def run_method(self, animal, age, *args):
        print ("",animal)
        print ("age",age)
        print ("args", args)
```

### tank 명령에서 실행

이제 셸에서 다음 tank 명령을 실행하면

```
 ./tank print_animal cat 7 Tortoiseshell large
```

다음과 같은 결과가 출력됩니다.

```
...

----------------------------------------------------------------------
Command: Print animal
----------------------------------------------------------------------

libpng warning: iCCP: known incorrect sRGB profile
('animal', 'cat')
('age', '7')
('args', ('Tortoiseshell', 'large'))
```
### 스크립트에서 실행

`tk-shell` 엔진의 스크립트에서 앱을 호출하려면 다음을 수행할 수 있습니다.

```python
# This assumes you have a reference to the `tk-shell` engine.
engine.execute_command("print_animal", ["dog", "3", "needs a bath"])
>>
# ('animal', 'dog')
# ('age', '3')
# ('args', ('needs a bath',))
```

Maya를 사용 중이면 다음과 같은 작업을 수행할 수 있습니다.

```python
import sgtk

# get the engine we are currently running in.
engine = sgtk.platform.current_engine()
# Run the app.
engine.commands['print_animal']['callback']("unicorn",4,"it's soooo fluffy!!!!")

>>
# ('animal', 'unicorn')
# ('age', 4)
# ('args', ("it's soooo fluffy!!!!",))
```

## 오류 메시지

Maya의 메뉴에서 앱을 시작하려고 하면 다음과 같은 오류가 발생합니다.

```
// Error: Shotgun tk-maya: An exception was raised from Toolkit
Traceback (most recent call last):
  File "/Users/philips1/Library/Caches/Shotgun/bundle_cache/app_store/tk-maya/v0.10.1/python/tk_maya/menu_generation.py", line 234, in _execute_within_exception_trap
    self.callback()
  File "/Users/philips1/Library/Caches/Shotgun/mysite/p89c1.basic.maya/cfg/install/core/python/tank/platform/engine.py", line 1082, in callback_wrapper
    return callback(*args, **kwargs)
TypeError: run_method() takes at least 3 arguments (1 given) //
```

이는 앱이 인자를 요구하도록 설정되어 있고 메뉴 버튼은 인자를 제공하도록 설정되어 있지 않기 때문입니다.

## 해결 방법

다음과 같은 키워드 인자를 사용하도록 앱의 `run_method`를 작성하는 것이 좋습니다.

```python
    def run_method(self, animal=None, age=None, *args):
        print ("",animal)
        print ("age",age)
        print ("args", args)
```
그러면 인자가 제공되지 않을 경우 발생하는 문제를 처리하고 폴백 동작을 구현할 수 있습니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/custom-app-args/8893)하십시오.

