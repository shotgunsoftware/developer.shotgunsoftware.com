---
layout: default
title: 配置未指向磁盘上的有效包！
pagename: configurations-does-not-point-to-valid-bundle-on-disk
lang: zh_CN
---

# 配置未指向磁盘上的有效包！

## 用例

首次安装 {% include product %} Desktop 时，打开项目后，文件路径后可能会出现此错误。

## 如何修复

在 Windows 上，项目的工作流配置实体指向配置的 `...\{% include product %}\Configurations` 路径。这可能不是正确的路径，因此，第一步是确保路径存在或对其进行更正。

还有一种可能，您可以尝试从您无权访问该路径位置的集中式安装进行访问。在这种情况下，切换到分布式安装将会有所帮助。


## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/first-time-setting-up-shotgun-and-i-have-this-error/9384)