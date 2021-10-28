---
layout: default
title: ModuleNotFoundError
pagename: modulenotfounderror-error
lang: ko
---

# ModuleNotFoundError

## 활용 사례

분산 구성을 사용하는 경우 엔진 외부에서 `tk.templates` 명령에 액세스하기 위해 `tk-shell` 부트스트래핑을 수행할 때 이 오류가 표시됩니다. [이 문서](https://developer.shotgridsoftware.com/ko/3d8cc69a/#part-2-logging)(4부)에 따라 설치 폴더에서 sgtk v0.19.18을 가져올 때 다음 오류가 발생합니다.

```
Traceback (most recent call last):
  File ".../_wip/sgtk_bootstrap.py", line 9, in <module>
    import sgtk
  File "L:/_tech/sgtk_sandbox/install/core/python\sgtk\__init__.py", line 16, in <module>
    import tank
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\__init__.py", line 58, in <module>
    from . import authentication
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\__init__.py", line 33, in <module>
    from .shotgun_authenticator import ShotgunAuthenticator
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\shotgun_authenticator.py", line 13, in <module>
    from .sso_saml2 import (
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\sso_saml2\__init__.py", line 15, in <module>
    from .core.errors import (  # noqa
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\sso_saml2\core\__init__.py", line 15, in <module>
    from .sso_saml2_core import (  # noqa
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\sso_saml2\core\sso_saml2_core.py", line 19, in <module>
    from Cookie import SimpleCookie
ModuleNotFoundError: No module named 'Cookie'
```

## 해결 방법

이 문제는 Python 3을 사용하기 때문일 수 있습니다. Python 2.7에는 쿠키 모듈이 있지만 3.x에는 없습니다. 따라서 Python 2.7을 사용하면 이 문제를 해결할 수 있습니다.

## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/bootstrap-sgtk-modulenotfounderror/11708)