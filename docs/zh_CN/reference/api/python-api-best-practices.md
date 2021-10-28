---
layout: default
title: Python API 最佳实践
pagename: python-api-best-practices
lang: zh_CN
---

# Python API 最佳实践


下面是使用 {% include product %} Python API 时的最佳实践列表。

## 性能

1. 不要请求您的脚本不需要的任何字段。包括不需要的附加字段可能会增加不必要的请求开销。
2. 过滤器应尽可能具体。尽可能在 API 查询中过滤，而不要在获得结果后进行解析，这样比较好。
3. 精确匹配过滤器的表现将优于部分匹配过滤器。例如，使用“是”(is)的效果将优于使用“包含”(contains)。

## 控制和调试

1. 对脚本使用单独的密钥，以便每个工具都具有唯一密钥。这对于调试非常有用。
2. 确保每个脚本都具有一个所有者或维护人员，且“脚本”(Scripts)页面（位于“管理”(Admin)菜单下）中的信息是最新的。
3. 考虑[为 API 用户创建只读权限组](https://developer.shotgridsoftware.com/zh_CN/bbae2ca7/)。许多脚本仅需要读取访问权限，这可以防止意外更改。
4. 跟踪正在使用哪些密钥，以便删除旧脚本。为了简化该操作，一些工作室在 API 封装器中为审核信息编写脚本。
5. 检查实体名称和字段。{% include product %} 的每个字段都有两个名称：UI 中使用的显示名称（并不一定唯一）和 API 使用的内部字段名称。显示名称可以随时更改，因此无法通过显示名称可靠地预测字段名称。可以转到“管理”(Admin)菜单中的字段选项来查看字段名称，也可以使用 `schema_read(), schema_field_read(), schema_entity_read() methods`，如 [http://developer.shotgridsoftware.com/python-api/reference.html?%20read#working-with-the-shotgun-schema](http://developer.shotgridsoftware.com/python-api/reference.html?%20read#working-with-the-shotgun-schema) 中所述。

## 概念设计

1. 尤其是对于大型工作室而言，考虑使用 API 隔离层（封装器）。它可以使工具与 {% include product %} API 中的更改隔离开来。这也意味着您可以控制 API 访问、管理调试、跟踪审核等，而无需修改 API 自身。
2. 使用最新版本的 API。它将包含错误修复和性能改进。
3. 注意脚本的起始运行环境。在渲染农场中运行的脚本（在此，对相同信息，每分钟向 {% include product %} 调用该脚本 1000 次）可能会影响站点性能。在这种情况下，请考虑实施只读缓存层以减少不必要的重复调用。
4. 可以关闭脚本的事件生成功能。对于运行频率非常高且稍后无需跟踪其事件的脚本而言，这一操作非常有用。对于运行频率极高的脚本而言，强烈建议执行这一操作，否则事件日志将变得非常大。