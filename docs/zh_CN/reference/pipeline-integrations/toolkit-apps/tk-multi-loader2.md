---
layout: default
title: 加载器
pagename: tk-multi-loader2
lang: zh_CN
---

# 加载器

本文档介绍仅当控制 Toolkit 配置时可用的功能。有关详细信息，请参见 [{% include product %} 集成用户手册](https://support.shotgunsoftware.com/hc/zh-cn/articles/115000068574#The%20Loader)。

## 配置

加载器具有高度的可配置性，您可以通过多种不同的方式对其进行设置。加载器有两个主要的配置区域：

- 设置左侧树视图中显示哪些选项卡和内容。
- 控制针对不同的发布显示哪些动作，以及这些动作实际执行什么操作。

下面各部分将简要介绍如何配置加载器。
有关配置方面的技术细节，请参见文档后面的单独章节。

### 树视图

树视图具有高度的可配置性，您可以使用标准 {% include product %} 过滤语法控制各个选项卡的内容。每个选项卡包含一个 {% include product %} API 查询，通过分组构成一个层次结构。您可以添加任意过滤器来控制要显示哪些项，并可使用特殊关键字 `{context.entity}`、`{context.project}`、`{context.project.id}`、`{context.step}`、`{context.task}` 和 `{context.user}` 基于当前上下文确定查询范围。每个关键字将被替换为相关的上下文信息，可以是 `None`（当上下文的对应部分未填充数据时）或包含键 ID、类型和名称的标准 {% include product %} 链接词典。

默认情况下，加载器将显示属于当前项目的资产和镜头。通过重新配置，可以轻松对此进行扩展，例如显示来自其他项目（或特定资产库项目）的内容项。您还可以使用过滤器仅显示具有某个审批状态的内容项，或者按状态或其他 {% include product %} 字段对内容项进行分组。下面是一些配置设置示例，说明了树视图选项卡的设置方式：

```yaml
# An asset library tab which shows assets from a specific
# {% include product %} project
caption: Asset Library
entity_type: Asset
hierarchy: [sg_asset_type, code]
filters:
- [project, is, {type: Project, id: 123}]

# Approved shots from the current project
caption: Shots
hierarchy: [project, sg_sequence, code]
entity_type: Shot
filters:
- [project, is, '{context.project}']
- [sg_status_list, is, fin]

# All assets for which the current user has tasks assigned
caption: Assets
entity_type: Task
hierarchy: [entity.Asset.sg_asset_type, entity, content]
filters:
- [entity, is_not, null]
- [entity, type_is, Asset]
- [task_assignees, is, '{context.user}']
- [project, is, '{context.project}']
```

### 过滤发布

我们可以对加载器从 {% include product %} 加载发布数据时所执行的发布查询应用 {% include product %} 过滤器。此功能由 `publish_filters` 参数控制，可用于隐藏尚未获得批准的发布或其关联的审看版本尚未得到批准的发布。

### 求助，不显示任何动作！

加载器针对每个插件随附了一些不同的动作。**例如，对于 Nuke，有两个动作：“导入脚本”和“创建读取节点”。动作在挂钩中定义，这意味着您可以修改它们的行为，或根据需要添加附加动作。然后，在加载器的配置中，可以将这些动作绑定至某些“发布类型”。**将一个动作绑定至一个发布类型，也就意味着该动作将显示在加载器内该类型的所有项的动作菜单上。

例如，默认情况下，Nuke 的映射关系设置如下：

```
action_mappings:
  Nuke Script: [script_import]
  Rendered Image: [read_node]
```

如果您发现不显示任何动作菜单，可能是因为您为当前使用的发布类型选择了不同的名称。如果是这样，请进入配置并添加这些类型，以便在加载器内显示它们。

### 管理动作

加载器支持的每个应用程序都有一个对应的动作挂钩，用于执行该应用程序支持的动作。例如，在 Maya 这样的应用程序中，默认挂钩将执行 `reference`、`import` 和 `texture_node` 动作，每个动作执行特定的 Maya 命令，将内容导入当前的 Maya 场景中。与所有挂钩一样，我们完全可以改写和更改这些设置，还可根据内置挂钩创建派生挂钩，这样不必复制大量代码就能轻松向内置挂钩中添加其他动作。

在动作挂钩中定义了动作列表后，您便可以将这些动作绑定至发布文件类型。例如，如果您的工作流中有一个名为“Maya 场景”(Maya Scene)的发布文件类型，可以在配置中将此类型绑定至挂钩中定义的 `reference` 和 `import` 动作。这样，Toolkit 会向显示的每个 Maya 场景发布中添加一个引用动作和一个导入动作。像这样将发布类型与实际挂钩分离开来，将更易于重新配置加载器，使其适用于默认配置随附的类型以外的发布类型设置。

加载器使用 Toolkit 第二代挂钩界面，具有更强的灵活性。此挂钩的格式采用经过改进的语法。您可以在加载器安装的默认配置设置中查看此语法，类似下面所示：

```
actions_hook: '{self}/tk-maya_actions.py'
```

`{self}` 关键字指示 Toolkit 在应用的 `hooks` 文件夹中查找挂钩。如果您要使用自己的执行改写此挂钩，请将值更改为 `{config}/loader/my_hook.py`。这将指示 Toolkit 使用您的配置文件夹中称为 `hooks/loader/my_hook.py` 的挂钩。

加载器使用的第二代挂钩的另一个功能是，挂钩不再需要具有 `execute()` 方法。相反，挂钩更像一个普通类，并可包含一套适合组合在一起的方法。在使用加载器时，您的动作挂钩需要执行以下两个方法：

```
def generate_actions(self, sg_publish_data, actions, ui_area)
def execute_multiple_actions(self, actions)
```

有关详细信息，请参见应用随附的挂钩文件。挂钩还会利用继承性，这意味着您不需要改写挂钩中的所有内容，而是可以更轻松地用各种方式对默认挂钩进行扩展或补充，使挂钩更易于管理。

请注意，在 `v1.12.0` 之前的版本中，应用程序会调用 `execute_action` 挂钩来执行动作。而较新的版本会调用 `execute_multiple_actions` 挂钩。为了向后兼容现有挂钩，`execute_multiple_actions` 挂钩实际为提供的每个动作调用 `execute_action`。如果应用程序在升级到 `v1.12.0` 或更高版本后提示未定义 `execute_multiple_actions` 挂钩，请确保环境中的 `actions_hook` 设置正确地从内置挂钩 `{self}/{engine_name}_actions.py` 继承设置。要了解有关如何从内置挂钩派生自定义挂钩的详细信息，请参见 [Toolkit 参考文档](http://developer.shotgridsoftware.com/tk-core/core.html#hook)。

LINKBOX_DOC:5#The%20hook%20data%20type：单击此处详细了解第二代挂钩格式。

通过在挂钩中运用继承性，您可以像下面这样向默认挂钩中添加附加动作：

```python
import sgtk
import os

# toolkit will automatically resolve the base class for you
# this means that you will derive from the default hook that comes with the app
HookBaseClass = sgtk.get_hook_baseclass()

class MyActions(HookBaseClass):

    def generate_actions(self, sg_publish_data, actions, ui_area):
        """
        Returns a list of action instances for a particular publish.
        This method is called each time a user clicks a publish somewhere in the UI.
        The data returned from this hook will be used to populate the actions menu for a publish.

        The mapping between Publish types and actions are kept in a different place
        (in the configuration) so at the point when this hook is called, the loader app
        has already established *which* actions are appropriate for this object.

        The hook should return at least one action for each item passed in via the
        actions parameter.

        This method needs to return detailed data for those actions, in the form of a list
        of dictionaries, each with name, params, caption and description keys.

        Because you are operating on a particular publish, you may tailor the output
        (caption, tooltip etc) to contain custom information suitable for this publish.

        The ui_area parameter is a string and indicates where the publish is to be shown.
        - If it will be shown in the main browsing area, "main" is passed.
        - If it will be shown in the details area, "details" is passed.
        - If it will be shown in the history area, "history" is passed.

        Please note that it is perfectly possible to create more than one action "instance" for
        an action! You can for example do scene introspection - if the action passed in
        is "character_attachment" you may for example scan the scene, figure out all the nodes
        where this object can be attached and return a list of action instances:
        "attach to left hand", "attach to right hand" etc. In this case, when more than
        one object is returned for an action, use the params key to pass additional
        data into the run_action hook.

        :param sg_publish_data: {% include product %} data dictionary with all the standard publish fields.
        :param actions: List of action strings which have been defined in the app configuration.
        :param ui_area: String denoting the UI Area (see above).
        :returns List of dictionaries, each with keys name, params, caption and description
        """

        # get the actions from the base class first
        action_instances = super(MyActions, self).generate_actions(sg_publish_data, actions, ui_area)

        if "my_new_action" in actions:
            action_instances.append( {"name": "my_new_action",
                                      "params": None,
                                      "caption": "My New Action",
                                      "description": "My New Action."} )

        return action_instances


    def execute_action(self, name, params, sg_publish_data):
        """
        Execute a given action. The data sent to this be method will
        represent one of the actions enumerated by the generate_actions method.

        :param name: Action name string representing one of the items returned by generate_actions.
        :param params: Params data, as specified by generate_actions.
        :param sg_publish_data: {% include product %} data dictionary with all the standard publish fields.
        :returns: No return value expected.
        """

        # resolve local path to publish via central method
        path = self.get_publish_path(sg_publish_data)

        if name == "my_new_action":
            # do some stuff here!

        else:
            # call base class implementation
            super(MyActions, self).execute_action(name, params, sg_publish_data)
```

然后，我们可以在配置中将这个新动作绑定到一组发布类型：

```yaml
action_mappings:
  Maya Scene: [import, reference, my_new_action]
  Maya Rig: [reference, my_new_action]
  Rendered Image: [texture_node]
```

按上面所示从挂钩派生的自定义挂钩代码只需要包含实际添加的业务逻辑，因此维护和更新起来更加简单。

## 参考

在应用实例上可以使用以下方法。

### open_publish()
显示“打开文件”风格的加载器版本，让用户可以选择发布。  然后将返回选定的发布。  在此模式下运行时，不允许使用为应用配置的普通动作。

app.open_publish( `str` **title**, `str` **action**, `list` **publish_types** )

**参数和返回值**
* `str` **title** - 打开发布对话框中显示的标题。
* `str` **action** - 用于“打开”(Open)按钮的动作名称。
* `list` **publish_types** - 一个发布类型列表，用于过滤可用的发布列表。  如果此值为空/None，将显示所有发布。
* **返回值：**用户选择的 {% include product %} 实体词典的列表。

**示例**

```python
>>> engine = sgtk.platform.current_engine()
>>> loader_app = engine.apps.get["tk-multi-loader2"]
>>> selected = loader_app.open_publish("Select Geometry Cache", "Select", ["Alembic Cache"])
>>> print selected
```
