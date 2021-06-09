---
layout: default
title: 我的日志文件位于何处？
pagename: where-are-my-log-files
lang: zh_CN
---

# 我的日志文件位于何处？

默认情况下，Shotgun Desktop 和 Shotgun 集成将其日志文件存储在以下目录中：

**Mac**

`~/Library/Logs/Shotgun/`

**Windows**

`%APPDATA%\Shotgun\logs\`

**Linux**

`~/.shotgun/logs/`

日志文件名采用 `tk-<ENGINE>.log` 格式。示例包括 `tk-desktop.log` 或 `tk-maya.log`。

如果您已将 [`SHOTGUN_HOME` 环境变量](http://developer.shotgunsoftware.com/tk-core/utils.html#localfilestoragemanager)设置为覆盖用户的缓存位置，那么日志文件将位于：`$SHOTGUN_HOME/logs`。

{% include info title="注意" content="您还可以从 Shotgun Desktop 访问此目录。选择一个项目，单击项目名称右侧的向下箭头按钮，然后选择**Open Log Folder**。"%}
