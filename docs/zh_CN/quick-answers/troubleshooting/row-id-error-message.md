---
layout: default
title: 无法解析路径的行 ID！
pagename: row-id-error-message
lang: zh_CN
---

# 无法解析路径的行 ID！

## 相关的错误消息：

- 无法解析路径的行 ID！
- 数据库并发问题: 路径 `<PATH>` 已与 {% include product %} 实体 `<ENTITY>` 关联。

## 示例：

当 Toolkit 用户创建文件夹时收到错误“无法解析路径的行 ID！”。

奇怪的是，这会创建 FileSystemLocation 实体，但有时会导致重复项，这可能会导致一系列问题。

完整的错误如下所示：

```
Creating folders, stand by...

ERROR: Could not resolve row id for path! Please contact support! trying to
resolve path '\\server\nas_production\CLICK\00_CG\scenes\Animation\01\001'.
Source data set: [{'path_cache_row_id': 8711, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001',
'metadata': {'type': '{% include product %}_entity', 'name': 'sg_scenenum', 'filters':
[{'path': 'sg_sequence', 'values': ['$sequence'], 'relation': 'is'}],
'entity_type': 'Shot'}, 'primary': True, 'entity': {'type': 'Shot', 'id':
1571, 'name': '001_01_001'}}, {'path_cache_row_id': 8712, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001\\Fx',
'metadata': {'type': '{% include product %}_step', 'name': 'short_name'}, 'primary': True,
'entity': {'type': 'Step', 'id': 6, 'name': 'FX'}}, {'path_cache_row_id':
8713, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001\\Comp',
```
_注意：它的运行时间可能比这长得多。_

## 导致错误的原因是什么？

此错误指出，工作流配置中的 {% include product %}（“站点偏好设置 -> 文件管理”(Site Preferences -> File Management)）和 c`onfig/core/roots.yml` 中指定的存储根之间不匹配。

这通常是由于运行 Windows 的工作室中的大小写不匹配而导致的。它们的路径不区分大小写，但我们的配置区分大小写。像 `E:\Projects` 与 `E:\projects` 这样简单的差异都可能会导致此错误。

## 在后台发生了什么？

代码在 {% include product %} 中为刚创建的路径创建了 FilesystemLocation 实体，使用 {% include product %} 的存储根来确定路径的根。然后，它在本地缓存中创建相同的条目，并且必须确定将其放置在数据库中的哪个位置。对于本地缓存，它使用 `roots.yml` 确定路径的根，并且由于大小写不匹配，它生成的路径与刚在 {% include product %} 中输入的路径不匹配。此时，它将引发错误。

这尤其糟糕，因为错误不清晰：创建了文件夹，创建了 FilesystemLocation 条目，它们没有在本地缓存路径中同步，由于存储根不匹配，它们也无法同步。

## 如何修复

首先，确保“站点偏好设置”(Site Preferences)中的存储根路径与 `config/core/roots.yml` 中的路径相匹配。要修复不匹配问题，就应该在后续的文件夹创建调用中消除错误。

然后，清除错误的 FilesystemLocation 实体。如果可以缩小到一组错误的 FilesystemLocation 实体，只需移除这些实体即可。但是，在许多情况下，项目的所有路径都会受到影响，因此它们都需要处理。

- 如何清除 FilesystemLocation 实体：理想情况下，您可以运行 `tank unregister_folders`。要清除所有这些，请运行 tank `unregister_folders --all`。（对于 `tank unregister_folders` 的所有选项，只需运行它而不使用任何参数，它将输出用法说明。）
- 但是，由于数据库已处于不稳定状态，因此这可能不起作用，或者可能仅部分起作用。运行该命令后，返回到 {% include product %} 中的 FilesystemLocations，确认您预期删除的内容已消失。如果没有，请选择坏实体，然后手动将其移动到垃圾桶。

此时，{% include product %} 中的 FilesystemLocations 是干净的，但艺术家的本地缓存可能不反映您所做的更改。最后一步是实际同步每个用户计算机上的本地缓存。为此，应运行 tank `synchronize_folders --full`。

执行所有这些步骤后，缓存路径应处于良好状态，并且不再显示错误。

## 相关链接

- [下面是相关代码](https://github.com/shotgunsoftware/tk-core/blob/01bb9547cec19cc2a959858b09a8b349a388b56f/python/tank/path_cache.py#L491-L498)
- [什么是缓存路径？什么是文件系统位置？](https://developer.shotgridsoftware.com/zh_CN/cbbf99a4/)

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/how-to-troubleshoot-folder-creation-errors/3578)。

