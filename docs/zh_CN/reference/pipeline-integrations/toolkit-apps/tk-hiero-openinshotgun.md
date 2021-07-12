---
layout: default
title: 在 ShotGrid 中打开 Hiero/Nuke Studio
pagename: tk-hiero-openinshotgun
lang: zh_CN
---

# 在 {% include product %} 中打开 Hiero/Nuke Studio

此应用向 Hiero 电子表格和时间线添加一个上下文菜单，让您可在 {% include product %} 中打开有对应镜头的给定轨道项。

![open_in_shotgun](../images/apps/hiero-open_in_shotgun.png)

通常，在配置此应用时，要通过向 {% include product %} Nuke 插件配置中添加以下内容，将它添加到 Hiero 中的时间线和电子表格菜单：

```yaml
timeline_context_menu:
  - {
      app_instance: tk-hiero-openinshotgun,
      keep_in_menu: false,
      name: "Open in {% include product %}",
      requires_selection: true,
    }
spreadsheet_context_menu:
  - {
      app_instance: tk-hiero-openinshotgun,
      keep_in_menu: false,
      name: "Open in {% include product %}",
      requires_selection: true,
    }
```
