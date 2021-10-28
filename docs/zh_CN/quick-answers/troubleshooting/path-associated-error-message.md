---
layout: default
title: 路径“<PATH>”已与 {% include product %} 实体“<ENTITY>”关联
pagename: path-associated-error-message
lang: zh_CN
---

# 数据库并发问题：路径 `<PATH>` 已与 {% include product %} 实体 `<ENTITY>` 关联

## 相关的错误消息：

- 数据库并发问题: 路径 `<PATH>` 已与 {% include product %} 实体 `<ENTITY>` 关联。
- 无法解析路径的行 ID！

## 示例：

当 Toolkit 用户尝试创建文件夹时，会发生此错误。以下是完整错误：

```
ERROR: Database concurrency problems: The path
'Z:\projects\SpaceRocks\shots\ABC_0059' is already associated with
Shotgun entity {'type': 'Shot', 'id': 1809, 'name': 'ABC_0059'}. Please re-run
folder creation to try again.
```
## 导致错误的原因是什么？

当您尝试为已具有 FilesystemLocation 实体的文件夹创建 FilesystemLocation 实体时，会发生这种情况。

## 如何修复

清除错误的 FilesystemLocation 实体。如果可以缩小到一组错误的 FilesystemLocation 实体，只需移除这些实体即可。但是，在许多情况下，项目的所有路径都会受到影响，因此它们都需要处理。

- 如何清除 FilesystemLocation 实体：理想情况下，您可以运行 `tank unregister_folders`。要清除所有这些，请运行 tank `unregister_folders --all`。（对于 `tank unregister_folders` 的所有选项，只需运行它而不使用任何参数，它将输出用法说明。）
- 但是，由于数据库已处于不稳定状态，因此这可能不起作用，或者可能仅部分起作用。运行该命令后，返回到 {% include product %} 中的 FilesystemLocations，确认您预期删除的内容已消失。如果没有，请选择坏实体，然后手动将其移动到垃圾桶。

此时，{% include product %} 中的 FilesystemLocations 是干净的，但艺术家的本地缓存可能不反映您所做的更改。最后一步是实际同步每个用户计算机上的本地缓存。为此，应运行 tank `synchronize_folders --full`。

执行所有这些步骤后，缓存路径应处于良好状态，并且不再显示错误。

## 相关链接

- [下面是相关代码](https://github.com/shotgunsoftware/tk-core/blob/01bb9547cec19cc2a959858b09a8b349a388b56f/python/tank/path_cache.py#L491-L498)
- [什么是缓存路径？什么是文件系统位置？](https://developer.shotgridsoftware.com/zh_CN/cbbf99a4/)

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/how-to-troubleshoot-folder-creation-errors/3578)。

