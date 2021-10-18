---
layout: default
title: TankError 尝试从模板解析路径
pagename: tank-error-tried-to-resolve-a-path
lang: zh_CN
---

# TankError: 尝试从模板解析路径

## 用例 1

当为 SGTK 设置新配置时，尝试通过“文件打开”(File Open)对话框（在 tk-multi-workfiles2 中）创建新文件时，会出现以下错误：

```
TankError: Tried to resolve a path from the template <Sgtk TemplatePath asset_work_area_maya:
```

## 用例 2

当尝试在某些任务中保存时，会收到错误：

```
TankError: Tried to resolve a path from the template <Sgtk TemplatePath nuke_shot_work:
```


## 如何修复

对于用例 1：检查 `asset.yml` 文件，它可能缺少过滤器：

` - { "path": "sg_asset_type", "relation": "is", "values": [ "$asset_type"] }`

对于用例 2：这可能是由于场被重命名，并留下一些 FilesystemLocation，从而给 Toolkit 造成混乱。

修复：

- 在 Shotgun 中删除旧的 FilesystemLocation
- 从 Toolkit 中取消注册与旧 FilesystemLocation 相关的文件夹
- 从 Toolkit 再次注册文件夹


## 相关链接

[单击此处在社区中查看完整主题](https://community.shotgridsoftware.com/t/6468/10)，[也可以单击此处在此社区主题中进行查看](https://community.shotgridsoftware.com/t/9686)。