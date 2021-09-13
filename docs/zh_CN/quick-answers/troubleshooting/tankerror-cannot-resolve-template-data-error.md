---
layout: default
title: 无法解析上下文的模板数据
pagename: tankerror-cannot-resolve-template-data-error
lang: zh_CN
---

# TankError: 无法解析上下文的模板数据

## 用例

对新项目执行高级项目设置，并使用 {% include product %} Desktop 中的单机版发布器应用为我创建的新资产任务发布某些图像时，在选择上下文以验证发布后，出现以下错误：


```
creation for %s and try again!" % (self, self.shotgun_url))
TankError: Cannot resolve template data for context ‘concept, Asset door-01’ - this context does not have any associated folders created on disk yet and therefore no template data can be extracted. Please run the folder creation for and try again!
```

在终端中运行 `tank.bat Asset door-01 folders` 可解决此问题。但是，以前的任何项目中都从未出现过这种情况。

## 如何修复

这可能是因为这是第一次尝试在不先通过 DCC 的情况下为新实体/任务执行单机发布。

之前可能没有发生这种情况的原因是，您在使用单机版发布器之前已在软件中开始处理资产，因此文件夹已创建/同步。启动软件（通过 Toolkit）将为启动的上下文创建文件夹，打开的应用将为启动新文件的上下文创建文件夹。因此，通常不需要专门创建文件夹。

通常的做法是，工作室一般会在镜头/资产添加到 {% include product %} 中后手动创建文件夹。

另请记住，这受“文件夹数据结构”的影响，如果它与模板不完全匹配，则可能会导致奇怪的问题。

## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/tank-folder-creation/8674/5)