---
layout: default
title: Tk-desktop 控制台以静默方式忽略错误
pagename: desktop-console-silently-ignoring-errors
lang: zh_CN
---

# Tk-desktop 控制台以静默方式忽略错误

## 用例

开发 Toolkit 应用时，tk-desktop 会以静默方式忽略应用在初始化期间引发的所有异常，即使“切换调试日志记录”(Toggle debug logging)复选框处于启用状态也是如此。确定存在问题的唯一方法是，在加载项目的配置后，注册的命令不显示。

## 如何修复

当 Desktop 为项目加载应用时，该日志记录永远不会传递到 SG Desktop 主 UI 进程。但是，它应该仍会输出到 `tk-desktop.log`。检查该文件中是否存在异常。


## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/8570)