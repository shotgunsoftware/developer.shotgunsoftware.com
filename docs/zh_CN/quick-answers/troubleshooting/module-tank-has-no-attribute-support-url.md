---
layout: default
title: "启动 {% include product %} Desktop 时，错误模块“tank”没有属性“support_url”"
pagename: module-tank-has-no-attribute-support-url
lang: zh_CN
---

# 启动 {% include product %} Desktop 时，错误模块“tank”没有属性“support_url”

## 问题

升级版本后，启动 {% include product %} Desktop 时显示以下消息：

```
{% include product %} Desktop Error:
Error: module 'tank' has no attribute 'support_url'
```

## 原因

描述符版本与较新的 {% include product %} Desktop版本 1.7.3 不兼容。在 tk-core v0.19.18 中引入了“support_url”。

## 解决方案

要解决此问题，请执行以下操作：

1. 访问 {% include product %} 网站上的“工作流配置列表”(Pipeline Configuration List)页面。
2. 检查“描述符”(Descriptor)字段是否具有与较新的 {% include product %} Desktop 版本不兼容的旧版本。

## 相关链接

- [知识库支持文章](https://knowledge.autodesk.com/zh-hans/support/shotgrid/troubleshooting/caas/sfdcarticles/sfdcarticles/CHS/Error-module-tank-has-no-attribute-support-url-when-launching-ShotGrid-Desktop.html)

