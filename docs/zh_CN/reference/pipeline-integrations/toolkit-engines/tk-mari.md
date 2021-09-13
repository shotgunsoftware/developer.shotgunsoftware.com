---
layout: default
title: Mari
pagename: tk-mari
lang: zh_CN
---

# Mari

{% include product %} Mari 插件包含一个用于在 Mari 中集成 {% include product %} Toolkit 应用的标准平台。它采用轻量型设计，操作简单直观，并会向主菜单中添加一个 {% include product %} 菜单。

## 支持的应用程序版本

此插件已经过测试，已知可支持以下应用程序版本：2.6 - 4.6。请注意，它完全可能（甚至很可能）与较新版本配合使用，但尚未对这些版本进行正式测试。

## 概述视频

请参见[此处](https://youtu.be/xIP7ChBWzrY)的概述视频。

## 安装和更新

### 将此插件添加到 {% include product %} Pipeline Toolkit

如果您想将此插件添加到 Project XYZ 中名为 asset 的环境中，请执行以下命令：

```
> tank Project XYZ install_engine asset tk-mari
```

### 更新至最新版本

如果您已在某个项目中安装了此应用，要获取最新版本，可运行 `update` 命令。您可以导航到该特定项目随附的 tank 命令，并在该项目中运行它：

```
> cd /my_tank_configs/project_xyz
> ./tank updates
```

或者，也可以运行您的工作室的 `tank` 命令并指定项目名称，指示该命令要对哪个项目运行更新检查：

```
> tank Project XYZ updates
```

## 协作和代码演进

如果您可以获取 {% include product %} Pipeline Toolkit，意味着也可以获取我们在 GitHub 中存储和管理的所有应用、插件和 {% include product %} 的源代码。欢迎根据实际需要演进和完善这些内容，以它们为基础做进一步的独立开发，修改它们（以及向我们提交 Pull 请求！），或者只是随手玩一玩，简单了解它们的构建方式和 Toolkit 的工作原理。您可以访问此代码库 (https://github.com/shotgunsoftware/tk-mari)。





