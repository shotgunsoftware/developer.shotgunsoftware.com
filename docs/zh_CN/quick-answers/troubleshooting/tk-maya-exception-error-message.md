---
layout: default
title: 错误 {% include product %} tk-maya Toolkit 产生异常
pagename: tk-maya-exception-error-message
lang: zh_CN
---

# 错误: {% include product %} tk-maya: Toolkit 产生异常

## 用例

可以将 Toolkit 应用设置为在触发运行时接收自定义参数。

例如，运行应用时，您可能希望提供某种状态标志，使应用根据状态以不同方式启动。

下面是一些已使用这种设置的示例：

- `tk-shotgun-folders` 应用（它基于 Shotgun Web 应用中的选定实体创建文件夹）将传递用户在 Shotgun Web 应用中选择并在其上运行操作的 Shotgun 实体和实体类型：https://github.com/shotgunsoftware/tk-shotgun-folders/blob/v0.1.7/app.py#L86
- `tk-multi-launchapp`（负责启动具有 Shotgun 集成的软件）可以传递 `file_to_open` 参数，一旦该软件启动，将使用它打开文件：
   https://github.com/shotgunsoftware/tk-multi-launchapp/blob/v0.11.2/python/tk_multi_launchapp/base_launcher.py#L157
   通常，当您通过 {% include product %} Desktop 启动软件时，它不会提供 `file_to_open` 参数，但是，如果您使用的是集中式配置 (`tank maya_2019 /path/to/maya/file.mb`)，则可以通过 tank 命令调用该应用。此外，我们的 `tk-shotgun-launchpublish` 应用会进而启动 `tk-multi-launchapp`，并提供已发布的文件作为 `file_to_open` 参数。https://github.com/shotgunsoftware/tk-shotgun-launchpublish/blob/v0.3.2/hooks/shotgun_launch_publish.py#L126-L133

## 对应用进行编程以接受参数

如果您要[编写自定义应用](https://developer.shotgridsoftware.com/zh_CN/2e5ed7bb/)，只需将在插件中注册的回调方法设置为接受所需的参数。
下面是一个简单的应用，它设置为需要两个参数，接受任何其他参数，然后输出它们：

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

### 从 tank 命令运行

现在，如果在 shell 中运行以下 tank 命令：

```
 ./tank print_animal cat 7 Tortoiseshell large
```

它会导致输出以下内容：

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
### 从脚本运行

如果要在 `tk-shell` 插件上从脚本调用应用，则可以执行以下操作：

```python
# This assumes you have a reference to the `tk-shell` engine.
engine.execute_command("print_animal", ["dog", "3", "needs a bath"])
>>
# ('animal', 'dog')
# ('age', '3')
# ('args', ('needs a bath',))
```

如果您在 Maya 中，则会执行如下操作：

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

## 错误消息

如果您尝试从 Maya 中的菜单启动应用，则会收到如下错误：

```
// Error: Shotgun tk-maya: An exception was raised from Toolkit
Traceback (most recent call last):
  File "/Users/philips1/Library/Caches/Shotgun/bundle_cache/app_store/tk-maya/v0.10.1/python/tk_maya/menu_generation.py", line 234, in _execute_within_exception_trap
    self.callback()
  File "/Users/philips1/Library/Caches/Shotgun/mysite/p89c1.basic.maya/cfg/install/core/python/tank/platform/engine.py", line 1082, in callback_wrapper
    return callback(*args, **kwargs)
TypeError: run_method() takes at least 3 arguments (1 given) //
```

这是因为应用设置为需要参数，而菜单按钮不知道提供它们。

## 如何修复

建议编写应用的 `run_method`，以使用如下关键字参数：

```python
    def run_method(self, animal=None, age=None, *args):
        print ("",animal)
        print ("age",age)
        print ("args", args)
```
然后，您可以处理未提供参数时发生的情况，并实现回退行为。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/custom-app-args/8893)。

