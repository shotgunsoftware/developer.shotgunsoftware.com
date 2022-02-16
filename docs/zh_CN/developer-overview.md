---
layout: default
title: 开发人员概述
pagename: developer-overview
lang: zh_CN
---

# 开发人员概述

### Python API

{% include product %} 软件提供基于 Python 的 API，用于访问 {% include product %} 以及与其他工具相集成。API 遵循 CRUD 模式，允许在 {% include product %} 服务器上执行创建、读取、更新和删除动作。每个请求作用于单个实体类型，根据特定动作，可以定义过滤器、返回的列、排序信息以及一些其他选项。

* [代码库](https://github.com/shotgunsoftware/python-api)
* [文档](http://developer.shotgridsoftware.com/python-api/)
* [论坛](https://community.shotgridsoftware.com/c/pipeline/6)

### 事件触发器框架

如果要访问 {% include product %} 事件流，首选方法是监视事件表、获取任何新事件并对其进行处理，然后重复上述动作。

需要执行许多工作才可顺利完成此流程，这些工作可能与需要应用的业务规则并无任何直接关系。

框架的作用是使业务逻辑实施者摆脱任何繁琐的监视任务。

该框架是一个守护进程，可在服务器上运行并监视 {% include product %} 事件流。找到事件时，守护进程会将事件分发给一系列注册的插件。每个插件可以根据情况处理事件。

* [代码库](https://github.com/shotgunsoftware/shotgunevents)
* [文档](https://github.com/shotgunsoftware/shotgunevents/wiki)

### 动作菜单项框架

API 开发人员可以按实体自定义上下文菜单项。例如，在“版本”(Versions)页面中，可以选择多个版本，单击鼠标右键，然后...。生成 PDF 报告（例如）。我们将其称为动作菜单项 (AMI)。

* [文档]()
* [示例代码库](http://developer.shotgridsoftware.com/python-api/cookbook/examples/ami_handler.html)
