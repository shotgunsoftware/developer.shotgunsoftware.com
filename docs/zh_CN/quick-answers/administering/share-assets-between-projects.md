---
layout: default
title: 如何在项目之间共享资产？
pagename: share-assets-between-projects
lang: zh_CN
---

# 如何在项目之间共享资产？

很常见的做法是将某项目用作资产库，其中包含可在其他项目中加载到镜头中的资产。

要实现此目的，您可以将一个列出此资产库项目中资产的选项卡添加到[加载器应用](https://developer.shotgridsoftware.com/zh_CN/a4c0a4f1/)。要执行此操作，您必须在加载器设置中针对插件和您的工作环境对此进行定义。您可能需要在多个位置对其进行更新。

例如，要将该选项卡添加到[镜头工序环境中的 Maya 插件](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-multi-loader2.yml#L122)，您需要添加以下代码段：

```yaml
caption: Asset Library
hierarchy: [project, sg_asset_type, code]
entity_type: Asset
filters:
- [project, is, {'type': 'Project', 'id': 207}]
```

将 `207` 替换为库项目的 ID。

如果您现在正在 Maya 的镜头工序环境中工作，系统将添加一个新选项卡，其中显示该项目中所有可用的发布。如果您想将该选项卡添加到其他插件（如 Nuke、3dsmax 等）中的加载器，还需要修改其中每个插件的 `tk-multi-loader2` 设置。如果要在其他环境中启用该设置，您将需要在资产工序环境中以及您希望启用该设置的所有其他环境中执行相同的工序。操作过程有点麻烦，但可以实现某种精细控制。

通过这些设置，加载器应用应该可以显示一个列出常规项目中的发布的选项卡。