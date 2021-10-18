---
layout: default
title: ascii 编解码器无法解码位置 10 中的字节 0x97
pagename: ascii-error-message
lang: zh_CN
---

# ASCII 编解码器无法解码位置 10 中的字节 0x97: 序号不在范围内

## 相关的错误消息：

克隆配置时
- TankError: 无法创建文件系统结构: `ascii`！编解码器无法解码位置 10 中的字节 0x97: 序号不在范围(128)内

使用另一个项目设置项目配置时
- “ascii 编解码器无法解码位置 10 中的字节 0x97: 序号不在范围(128)内”

## 如何修复：

通常，当“config”文件夹中出现 Unicode/特殊字符时，我们会看到这一错误。我们建议您查看一下是否可以找到特殊字符。

## 导致此错误的原因示例：

在这种情况下，错误源于 Windows 在文件名末尾添加后缀 `–`。在移除所有这些文件后，它开始起作用。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/ascii-problem/7688)。

