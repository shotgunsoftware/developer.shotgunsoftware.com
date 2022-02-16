---
layout: default
title: 找不到程序“MTsetToggleMenuItem”
pagename: mtsettogglemenuitem-error-message
lang: zh_CN
---

# 找不到程序“MTsetToggleMenuItem”

## 相关的错误消息：

Maya 在加载完整窗口之前、显示常见启动屏幕之后崩溃：
- 找不到程序“MTsetToggleMenuItem”

## 如何修复：

启动 Maya 之前，在 before_app_launch 挂钩中，可能有某些内容被意外从路径中移除，从而导致 Maya 启动时出错。在这种情况下，将 Python 安装添加到 `PTHONPATH` 会阻止 Maya 2019 查找插件路径。

## 导致此错误的原因示例：
用户遇到了多个问题，因为此挂钩确保 `C:\Python27` 已设置为 `PYTHONPATH`，并且他们实际上已使用此 `PYTHONPATH` 安装工作站。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/tk-maya-cannot-find-procedure-mtsettogglemenuitem/4629)。

