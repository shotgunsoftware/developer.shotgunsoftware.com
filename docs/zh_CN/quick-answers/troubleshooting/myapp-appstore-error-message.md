---
layout: default
title: 应用商店不包含名为 my-app 的项
pagename: myapp-appstore-error-message
lang: zh_CN
---

# 错误: 应用商店不包含名为 my-app 的项

## 如何修复：

这与自定义应用上的位置描述符有关 - [查看此文档](https://developer.shotgridsoftware.com/zh_CN/2e5ed7bb/#part-6-preparing-your-first-release)。

对于位置，请使用路径描述符设置 my-app - [请在此处了解详细信息](https://developer.shotgridsoftware.com/tk-core/descriptor.html#pointing-to-a-path-on-disk)。

## 导致此错误的原因示例：

tk-multi-snapshot 未显示在 Maya 中，尝试使用 tank 验证时，如果尝试验证自定义应用，则会显示此错误，指出它不在应用商店中。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/tank-validate-errors-on-custom-apps/10674)。

