---
layout: default
title: 文件夹创建中止
pagename: folder-creation-aborded
lang: zh_CN
---

# 无法创建文件夹: 文件夹创建中止

## 用例

目前，我们在 Web 界面上创建新项目，然后使用 {% include product %} Desktop 将 Toolkit 配置为集中式设置。但是，当尝试编辑资产名称时，它不再起作用（艺术家无法在 Maya 等 CCD 中打开文件进行编辑），并返回错误“无法创建文件夹”。{% include product %} 要求重新运行 tank 命令以取消注册资产并重新注册它以进行修复，但我们不知道在何处运行这些命令。

## 如何修复

在项目上运行高级设置向导后，会有意移除用于运行该向导的选项。但是，如果需要，可以[重新设置项目](https://developer.shotgunsoftware.com/zh_CN/fb5544b1/)。

您需要运行错误消息中提及的 tank 命令：

```
tank.bat Asset ch03_rockat_drummer unregister_folders
```

`tank.bat` 位于您设置的配置的根目录中，如果您不确定它在何处，[此主题](https://community.shotgridsoftware.com/t/how-do-i-find-my-pipeline-configuration/191)应该可以帮助您找到它。

## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/error-in-toolkit-after-renaming-asset/4108)