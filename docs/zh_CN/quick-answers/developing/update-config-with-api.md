---
layout: default
title: 如何使用 API 以编程方式更新我的 Toolkit 配置？
pagename: update-config-with-api
lang: zh_CN
---

# 如何使用 API 以编程方式更新我的 Toolkit 配置？

## 更新应用、插件和框架

如果您想要以编程方式将所有插件、应用和框架更新到最新版本，可以使用以下代码执行此操作：

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

{% include warning title="注意" content="这会将此工作流配置中的所有插件、应用和框架更新为最新版本，而无需执行任何进一步交互或确认操作。在继续之前，请确保了解这一点。" %}

## 更新核心

如果要通过脚本更新项目的核心版本以便采用非交互方式运行该版本，可以使用以下代码执行此操作：

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

{% include warning title="注意" content="这会将 Toolkit 核心更新为最新版本，而无需执行任何进一步交互或确认操作。如果您正在从共享核心运行，此操作将更新共享此核心版本的所有项目使用的核心版本！在继续之前，请确保了解这一点。" %}

请参见：

- [自定义脚本中的身份认证和登录凭据](https://support.shotgunsoftware.com/hc/zh-cn/articles/219040338)
