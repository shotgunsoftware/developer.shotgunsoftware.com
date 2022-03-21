---
layout: default
title: 如何在项目之间共享资产？
pagename: share-assets-between-projects
lang: zh_CN
---

# 如何在项目之间共享资产？

常见的做法是将某项目用作资产库，其中包含可在其他项目中加载到镜头的资产。

在“资产”(Asset)实体上引入“链接的项目”(Linked Projects)字段后，就可以将单个选项卡添加到包含所有链接项目的[加载器应用](https://help.autodesk.com/view/SGSUB/CHS/?guid=SG_Supervisor_Artist_sa_integrations_sa_integrations_user_guide_html#the-loader)。要执行此操作，您必须在加载器设置中针对插件和您的工作环境对此进行定义。您可能需要在多个位置对其进行更新。

```yaml
- caption: Assets - Linked
    entity_type: Asset
    filters:
      - [linked_projects, is, "{context.project}"]
    hierarchy: [project.Project.name, sg_asset_type, code]
```

您可以参考 [tk-multi-loader2.yml 配置文件](https://github.com/shotgunsoftware/tk-config-default2/blob/a5af14aefbafaec6cf0933db83343f600eb75870/env/includes/settings/tk-multi-loader2.yml#L343-L347)（包含在 [tk-config-default2](https://github.com/shotgunsoftware/tk-config-default2) 中）中的 Alias 插件设置，因为这是该处的默认行为。

---

在“资产”(Assets)中引入“链接的项目”(Linked Projects)字段之前，实现跨项目共享的初始方法是向[加载器应用](https://help.autodesk.com/view/SGSUB/CHS/?guid=SG_Supervisor_Artist_sa_integrations_sa_integrations_user_guide_html#the-loader)添加一个选项卡，其中列出了特定资产库项目中的资产。

例如，要将该选项卡添加到[镜头工序环境中的 Maya 插件](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-multi-loader2.yml#L122)，您需要添加以下代码段：

```yaml
- caption: Asset Library
    hierarchy: [project, sg_asset_type, code]
    entity_type: Asset
    filters:
      - [project, is, {'type': 'Project', 'id': 207}]
```

将 `207` 替换为库项目的 ID。

如果您现在正在 Maya 的镜头工序环境中工作，系统将添加一个新选项卡，其中显示该项目中所有可用的发布。如果您想将该选项卡添加到其他插件（如 Nuke、3dsmax 等）中的加载器，还需要修改其中每个插件的 `tk-multi-loader2` 设置。如果要在其他环境中启用该设置，您将需要在资产工序环境中以及您希望启用该设置的所有其他环境中执行相同的工序。操作过程有点麻烦，但可以实现某种精细控制。

通过这些设置，加载器应用应该可以显示一个列出已标识项目中的发布的选项卡。

---

{% include info title="注意" content="此处仍包含此初始技术，因为它提供了一种让加载器中标识的每个项目都拥有不同选项卡的方法。"%}

要了解有关基于 Web 的跨项目资产链接的详细信息，请访问[此处的跨项目资产链接文档](https://help.autodesk.com/view/SGSUB/CHS/?guid=SG_Administrator_ar_site_configuration_ar_cross_project_asset_linking_html)。
