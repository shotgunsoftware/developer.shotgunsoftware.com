---
layout: default
title: 无法更改工作区 - 执行 MEL 脚本期间出错
pagename: error-during-execution-mel-script
lang: zh_CN
---

# 无法更改工作区 - 执行 MEL 脚本期间出错

## 用例

当为无权访问网络的自由职业者创建新的特殊工作流配置时，我们创建了新的根名称并将其指向另一个路径。制作工作流配置将根路径指向我们的文件服务器。

但是，在 Maya 上使用 `tk-multi-workfiles` 创建新文件时，出现以下错误：

```
Failed to change work area - Error during execution of MEL script: file: C:/Program files/Autodesk/Maya2019/scripts/others/setProject.mel line 332: New project location C:\VetorZero\work\Shotgun-workflow_completo\sequences\Seq_001\SH_010\ANIM\maya is not a valid directory, project not created.
Calling Procedure: setProject, in file “C:\Program Files\Shotgun\c” set project(“C:\Vetorzero\work\SHOTGUN-workflow_completo\sequences\Seq_001\SH_010\ANIM\maya”)
```

它创建了文件夹，但没有创建文件夹“maya”。

## 如何修复

检查以确保文件夹“maya”没有被错误地删除。如果存在此情况，则会出现此错误。

## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/new-file-maya-action-error/8225)