---
layout: default
title: Alias
pagename: tk-alias
lang: zh_CN
---

# Alias

{% include product %} Alias 插件包含一个用于在 Alias 中集成 {% include product %} 应用的标准平台。它采用轻量型设计，操作简单直观，并会向 Alias 菜单中添加一个 {% include product %} 菜单。

## 支持的应用程序版本

此插件已经过测试，已知可支持以下应用程序版本： 

{% include tk-alias %}

请注意，此插件也许（甚至非常有可能）支持更新的发行版本，但是尚未正式在这些版本中进行测试。

## Python 版本支持

> **重要信息：**随着 Alias {% include product %} Toolkit 插件 v2.1.5 的发布，我们不再支持 Python v2.7.x。[请下载 {% include product %} Desktop v1.7.3（或更高版本），以确保默认使用 Python 3](https://community.shotgridsoftware.com/t/a-new-version-of-shotgrid-desktop-has-been-released/13877/14)。

## 旧版本

[有关 Python 版本对旧版本支持的详细信息，请单击此处](https://github.com/shotgunsoftware/tk-alias/wiki/Python-Version-Support#older-versions)。

***
### 备注

本地安装的解释器可能会导致出现意外行为。如果您想在工作室环境中使用此解释器，请[联系技术支持](https://knowledge.autodesk.com/zh-hans/contact-support)。

## 应用开发人员须知
    
### PySide

{% include product %} Alias 插件使用随 {% include product %} Desktop 发行的 PySide 版本，并在必要时将其激活。 

### Alias 项目管理

{% include product %} Alias 插件在每次启动时，都会将 Alias 项目设置为指向此插件的设置中定义的位置。这意味着，当您打开新文件时，项目也可能会发生变化。设置Shotgun Alias 项目的详细信息，可以使用模板系统，在配置文件中配置。

***

## 使用 tk-alias

此 {% include product %} 集成支持 Alias 应用程序系列（Concept、Surface 和 AutoStudio）。

当 Alias 打开时，{% include product %} 菜单（Alias 插件）会添加到菜单栏中。

![其他应用](../images/engines/alias-other-apps.png)


### “File Open”和“File Save”

使用“我的任务”(My Tasks)和“零部件”(Assets)选项卡可以查看您的所有已分配任务，并浏览零部件。 在右侧，使用这些选项卡可以查看所有文件、与左侧选定内容关联的工作文件或已发布文件。

![File Open](../images/engines/alias-file-open.png)

![File Save](../images/engines/alias-file-save.png)


### 发布(Publish)

打开“发布”(Publish)对话框以将文件发布到 {% include product %}，然后供下游艺术家使用。有关详细信息，请参见[在 Alias 中发布](https://github.com/shotgunsoftware/tk-alias/wiki/Publishing)。 

![发布(Publish)](../images/engines/alias-publish.png)


### 加载器(Loader)

打开内容加载器应用，从而可以将数据加载到 Alias 中。有关详细信息，请参见[在 Alias 中加载](https://github.com/shotgunsoftware/tk-alias/wiki/Loading)。

![加载器(Loader)](../images/engines/alias-loader.png)

### Scene Breakdown

打开“Scene Breakdown”对话框，其中显示已参考（WREF 参考）内容的列表，以及场景中过时或使用备用版本的 PublishedFile 的内容。有关详细信息，请参见 [Alias 中的场景细分](https://github.com/shotgunsoftware/tk-alias/wiki/Scene-Breakdown)。

![Scene Breakdown](../images/engines/alias-breakdown.png)

