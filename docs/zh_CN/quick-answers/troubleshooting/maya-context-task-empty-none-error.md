---
layout: default
title: 在 Maya 中，当我输出 context.task 时，它为空白“无”(None)
pagename: maya-context-task-empty-none-error
lang: zh_CN
---

# 在 Maya 中，当我输出 context.task 时，它为空白“无”(None)

## 用例

在 Maya 中，在输出 `context.task` 后，它是 `empty “None”`，但尝试其他步骤/任务中的其他布局文件时，会显示 `context.task` 详细信息。在导航浏览 `Open > Layout > new file` 时，也可以输出 `context.task` 详细信息，但通过“文件保存”(File Save)保存文件时，`context.task` 为“无”(None)。

## 如何修复

尝试[取消注册文件夹](https://community.shotgridsoftware.com/t/how-can-i-unregister-folders-when-using-a-distributed-config/189)，以获取其中一个不起作用的镜头，然后再次运行文件夹创建。


## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/context-task-none/3705)