---
layout: default
title: ModuleNotFoundError
pagename: modulenotfounderror-error
lang: zh_CN
---

# ModuleNotFoundError

## 用例

使用分布式配置时，如果在插件外部引导 `tk-shell` 以访问 `tk.templates` 命令，则会出现此错误。按照[此文档](https://developer.shotgridsoftware.com/3d8cc69a/#part-2-logging)（第 4 部分）进行操作并从安装文件夹导入 sgtk v0.19.18 时，出现以下错误：

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

## 如何修复

此问题可能是由于使用 Python 3 所致。Python 2.7 确实有 Cookie 模块，但 3.x 没有。因此，可以使用 Python 2.7 解决此问题。

## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/bootstrap-sgtk-modulenotfounderror/11708)