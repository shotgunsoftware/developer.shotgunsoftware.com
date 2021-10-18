---
layout: default
title: 错误 18:13:28.365:Hiero(34236): 错误！任务类型
pagename: hiero-task-type-error-message
lang: zh_CN
---

# 错误 18:13:28.365:Hiero(34236): 错误! 任务类型

## 用例：
更新到 `config_default2` 后，nuke_studio 不会初始化。在 Nuke 12.0 Studio 中，脚本编辑器未出现错误，但在 Nuke 11.1v3 中出现错误：

```
ERROR 18:13:28.365:Hiero(34236): Error! Task type tk_hiero_export.sg_shot_processor.ShotgunShotProcessor Not recognised
```

回滚后不会失败，但仍不会初始化 tk-nuke 插件，并且 {% include product %} 无法加载任何内容...

[社区帖子](https://community.shotgridsoftware.com/t/cant-get-shotgun-toolkit-to-work-with-nuke-studio-config-default2/4586)包含完整日志，以提供更多详细信息。

## 导致错误的原因是什么？
它不是将其视为 NukeStudio 启动，而是可能将其视为标准 Nuke 启动。

定义的 Nuke Studio 软件实体具有路径，并将参数设置为 `-studio`。参数必须是 `--studio`。

## 如何修复
软件实体上的参数需要设置为 `-studio`。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/cant-get-shotgun-toolkit-to-work-with-nuke-studio-config-default2/4586)。

