---
layout: default
title: API를 사용하여 툴킷 구성을 프로그래밍 방식으로 업데이트하려면 어떻게 해야 합니까?
pagename: update-config-with-api
lang: ko
---

# API를 사용하여 툴킷 구성을 프로그래밍 방식으로 업데이트하려면 어떻게 해야 합니까?

## 앱, 엔진 및 프레임워크 업데이트

프로그래밍 방식으로 엔진, 앱 및 프레임워크를 모두 최신 버전으로 업데이트하려면 다음 코드를 사용하면 됩니다.

```python
import sys
sys.path.append("<path_to_your_config>/install/core/python")
import sgtk

# substitute your Project id here or alternatively use sgtk_from_path()
tk = sgtk.sgtk_from_entity('Project', 161)
c=tk.get_command("updates")

# setup authentication
if hasattr(sgtk, "set_authenticated_user"):
     from tank_vendor.shotgun_authentication import ShotgunAuthenticator
     user = ShotgunAuthenticator(sgtk.util.CoreDefaultsManager()).get_default_user()
     sgtk.set_authenticated_user(user)

# finally, execute the command
c.execute({})
```

{% include warning title="주의" content="이렇게 하면 추가적인 상호 작용 또는 확인 없이 파이프라인 구성에서 모든 엔진, 앱 및 프레임워크가 최신 버전으로 업데이트됩니다. 계속 진행하기 전에 유념하시기 바랍니다." %}

## 코어 업데이트

프로젝트의 코어를 상호 작용하지 않는 방식으로 실행하기 위해 스크립트에서 프로젝트 코어 버전을 업데이트하려면 다음 코드를 사용하면 됩니다.

```python
import sys
sys.path.append("<path_to_your_config>/install/core/python")
import sgtk

# substitute your Project id here or alternatively use sgtk_from_path()
tk = sgtk.sgtk_from_entity('Project', 161)
c=tk.get_command("core")

# setup authentication
if hasattr(sgtk, "set_authenticated_user"):
    from tank_vendor.shotgun_authentication import ShotgunAuthenticator
    user = ShotgunAuthenticator(sgtk.util.CoreDefaultsManager()).get_default_user()
    sgtk.set_authenticated_user(user)

# finally, execute the command
c.execute({})
```

{% include warning title="주의" content="이렇게 하면 추가적인 상호 작용 또는 확인 없이 Toolkit Core가 최신 버전으로 업데이트됩니다. 이 양식을 실행 중인 코어가 공유 코어인 경우 이렇게 하면 이 코어 버전을 공유 중인 모든 프로젝트가 사용하는 코어 버전이 업데이트됩니다! 계속 진행하기 전에 유념하시기 바랍니다." %}

참고:

- [커스텀 스크립트의 인증 및 로그인 자격 증명](https://support.shotgunsoftware.com/hc/ko/articles/219040338)
