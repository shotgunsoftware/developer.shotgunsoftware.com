---
layout: default
title: 安装两种扩展时的 Photoshop 集成疑难解答
pagename: two-photoshop-shotgun-extensions
lang: zh_CN
---

# 安装两种扩展时的 Photoshop 集成疑难解答

## 问题是什么？

在发布的 After Effects 集成中，包含一个与 {% include product %} 集成的所有 Adobe 应用都可使用的通用插件。作为此更改的一部分，我们需要重命名扩展，以便可以保留与较早的 Photoshop 集成的向后兼容性，并使工作室能够顺利过渡到更新。

不幸的是，这也意味着升级的同时可能安装两种 {% include product %} 扩展：

![Photoshop 菜单中显示的多个 {% include product %} 扩展](./images/photoshop-extension-panel.png)

**{% include product %} Adobe Panel** 为新扩展，应该在使用 `v1.7.0` 或更新版本的 Photoshop 集成时使用。

## 如何解决？

要删除旧扩展，可将其从您的主目录中的 Adobe 安装位置移除。启动 Photoshop 后，此扩展对应的文件夹可在调试输出中看到，位于

- OSX：`~/Library/Application Support/Adobe/CEP/extensions/com.sg.basic.ps`
- Windows：`%AppData%\Adobe\CEP\extensions\com.sg.basic.ps`

![Photoshop 菜单中显示的多个 {% include product %} 扩展](./images/shotgun-desktop-console-photoshop-extension.png)

如果退出 Photoshop 并移除该目录，则重新启动时应只有一个扩展。

{% include info title="注意" content="如果在多个环境或多个配置中具有 Photoshop 集成，并且新旧插件混合存在，则用户启动包含旧集成的 Photoshop 时，将返回旧插件。建议全面更新 Photoshop，以便只需执行一次清理。" %}