---
layout: default
title: 我的日志文件位于何处？
pagename: where-are-my-log-files
lang: zh_CN
---

# 我的日志文件位于何处？

默认情况下，{% include product %} Desktop 和 ShotGrid 集成将其日志文件存储在以下目录中：

**Mac**

`~/Library/Logs/Shotgun/`

**Windows**

`%APPDATA%\Shotgun\logs\`

**Linux**

`~/.shotgun/logs/`

日志文件名采用 `tk-<ENGINE>.log` 格式。示例包括 `tk-desktop.log` 和 `tk-maya.log`。

如果已将 [`{% include product %}_HOME` 环境变量](https://developer.shotgridsoftware.com/tk-core/utils.html#localfilestoragemanager)设置为覆盖用户的缓存位置，则日志文件将位于：`$SHOTGUN_HOME/logs`。

{% include info title="注意" content="您也可以从 ShotGrid Desktop 访问此目录。选择一个项目，单击项目名称右侧的向下箭头按钮，然后选择**“打开日志文件夹”(Open Log Folder)**。" %}
