---
layout: default
title: as_template_fields() 缺少我的上下文中的现有值
pagename: as-template-fields-missing-values
lang: zh_CN
---

# as_template_fields() 缺少我的上下文中的现有值

[as_template_fields()](https://developer.shotgridsoftware.com/tk-core/core.html?#sgtk.Context.as_template_fields) 方法使用缓存路径，因此，如果尚未创建与模板中的键相对应的文件夹，系统将不会返回字段。发生这种情况的原因有很多：

- 模板定义和数据结构需要同步。如果您已经在工作流配置中修改了此模板定义或数据结构，但未同时修改二者，预期字段将不会返回。
- 还没有为此特定上下文创建文件夹。如果尚未创建这些文件夹，则缓存路径中将不存在匹配的记录，预期字段将不会返回。
