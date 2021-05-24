---
layout: default
title: Shotgun
pagename: tk-shotgun
lang: zh_CN
---

# {% include product %}

{% include product %} 插件用来管理可以从 {% include product %} 内启动的应用。有时，我们称这些 Toolkit 应用为“动作”**。它们通常以菜单项的形式显示在 {% include product %} 内的菜单上。

## 使用 {% include product %} Pipeline Toolkit 动作

{% include product %} 主页上列出了这些动作：

![动作 1](../images/engines/shotgun-action1.png)

另外，您也可以在标准 {% include product %} 上下文菜单上找到这些动作，在对象或选择内容上单击鼠标右键即可显示上下文菜单：

![动作 2](../images/engines/shotgun-action2.png)

单击某个动作，将立即开始处理操作。应用完成处理后，通常会显示一条包含状态信息的消息，如果动作未正常运行，则会显示错误消息。

## 为 {% include product %} 开发应用

开发在 {% include product %} 内运行的应用非常简单！如果您不熟悉应用开发的一般流程，请访问平台文档库阅读相关的介绍资料。在这部分，我们将只介绍应用开发流程中特定于 {% include product %} 的方面！

自 Core v0.13 起，所有多用应用都可以与 {% include product %} 插件一起使用。从技术上讲，{% include product %} 插件与其他插件没有太大区别，但还是有些细微差异：

* 如果想在 {% include product %} 插件中执行基于 QT 的应用，需要在标准 Python 环境中手动安装 PySide 或 PyQt。
* 在 {% include product %} 插件中，可根据用户所属的权限组向用户显示动作。例如，如果想向 {% include product %} 动作菜单添加某个命令，并且只希望管理员才能看到该命令，就可以使用此功能。

一个样式简单、仅对管理员可见的 {% include product %} 应用如下所示：

```python
from tank.platform import Application

class LaunchPublish(Application):

    def init_app(self):
        """
        Register menu items with {% include product %}
        """        
        params = {
            "title": "Hello, World!",
            "deny_permissions": ["Artist"],
        }

        self.engine.register_command("hello_world_cmd", self.do_stuff, params)


    def do_stuff(self, entity_type, entity_ids):
        # this message will be displayed to the user
        self.engine.log_info("Hello, World!")    
```

