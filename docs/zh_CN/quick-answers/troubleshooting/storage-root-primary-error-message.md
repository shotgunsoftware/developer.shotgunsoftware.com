---
layout: default
title: 警告 存储根主存储无法映射到 SG 本地存储
pagename: review-error-message-root
lang: zh_CN
---

# 警告: 存储根主存储无法映射到 SG 本地存储

## 用例

尝试使用“驱动器文件”流设置项目并将 Google Drive 用作主存储时，项目向导在访问存储配置时在控制台中发出警告：

`[WARNING] Storage root primary could not be mapped to a SG local storage`

按**“继续”**不起作用。

## 如何修复

如果存储名称中存在拼写错误，则可能会导致此问题。确保它与 Google Drive 的名称完全匹配。

此外，使用 Google Drive 时，请确保将其设置为始终将文件保留在本地，以避免出现重复的项目。

## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/11185)