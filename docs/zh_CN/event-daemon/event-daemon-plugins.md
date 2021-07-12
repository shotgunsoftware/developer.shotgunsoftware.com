---
layout: default
title: 插件
pagename: event-daemon-plugins
lang: zh_CN
---

# 插件概述

插件文件是配置文件中指定的插件路径中的任何 _.py_ 文件。

在您下载的代码中，`src/examplePlugins` 文件夹中提供了一些示例插件。其中通过简单的示例介绍了如何构建自己的插件来查找所生成的特定事件，并对这些事件执行操作，从而更改 {% include product %} 实例上的其他值。

您无需在每次更新插件后重新启动进程，因为进程将检测插件是否已更新并自动重新加载插件。

即使插件发生错误，也不会导致进程崩溃。系统会禁用发生错误的插件，直到其再次更新（可能已修复）时才会启用。其他所有插件将继续运行，并继续处理事件。进程将对故障插件成功处理的最后一个事件的 ID 加以跟踪。此插件更新（可能已修复）后，进程将重新加载此插件，并尝试从插件之前停止的位置处理事件。当一切恢复正常之后，进程会促使插件赶上当前事件处理进度，然后继续以正常方式处理所有插件的事件。

{% include product %} 事件处理插件有两个主要部分：回调注册函数和任意数量的回调。

<a id="registerCallbacks_function"></a>

## registerCallbacks 函数

要想由框架加载插件，此插件至少应执行以下函数：

```python
def registerCallbacks(reg):
    pass
```

该函数的作用是，告诉事件处理系统需要调用哪些函数来处理事件。

此函数应使用一个参数，即 [`Registrar`](./event-daemon-api.md#Registrar) 对象。

[`Registrar`](./event-daemon-api.md#Registrar) 拥有一个非常重要的方法：[`Registrar.registerCallback`](./event-daemon-api.md#registercallback)。

对于每个需要处理 {% include product %} 事件的函数，应使用相应的参数调用 [`Registrar.registerCallback`](./event-daemon-api.md#registerCallback) 一次。

您可以根据需要注册任意数量的函数，而不需要将文件中的所有函数注册为事件处理回调。

<a id="Callbacks"></a>

## 回调

通过系统注册的回调必须使用四个参数：

- 一个 {% include product %} 连接实例，用于查询 {% include product %} 以获取更多信息。
- 一个 Python Logger 对象，用于报告。错误和关键消息将通过电子邮件发送给任何已配置的用户。
- 要处理的 {% include product %} 事件。
- 在回调注册时传入的 `args` 值。（请参见 [`Registrar.registerCallback`](./event-daemon-api.md#wiki-registerCallback)）

{% include info title="警告" content="您可以在插件中采取任何操作，但如果导致框架出现任何异常，系统将停用故障回调（及所有内含回调）所在的插件，直至磁盘上的文件发生变化（显示“已修复”）。" %}

<a id="Logging"></a>

## 日志记录

建议不要在事件插件中使用输出语句。而应使用 Python 标准库中的标准日志记录模块。系统会向您的众多函数提供一个日志记录程序对象

```python
def registerCallbacks(reg):
    reg.setEmails('root@domain.com', 'tech@domain.com') # Optional
    reg.logger.info('Info')
    reg.logger.error('Error') # ERROR and above will be sent via email in default config
```

并且

```python
def exampleCallback(sg, logger, event, args):
    logger.info('Info message')
```

如果事件框架作为进程运行，则其会记录到文件，否则，将记录到标准输出。

<a id="Robust"></a>

## 构建强大的插件

该进程针对 {% include product %} 运行查询，但进程具有内置功能，可在 find() 命令无法生效时重试此命令，从而为进程本身赋予一定的稳定性。

[https://github.com/shotgunsoftware/shotgunEvents/blob/master/src/shotgunEventDaemon.py#L456](https://github.com/shotgunsoftware/shotgunEvents/blob/master/src/shotgunEventDaemon.py#L456)

如果插件需要网络资源（即 {% include product %} 或其他资源），则需要自行提供重试机制/稳定性。如果通过 {% include product %} 进行访问，您可以关闭进程中的内容，并生成可向插件提供相应功能的辅助函数或类。

{% include product %} Python API 确实能够针对网络问题进行一定程度的重试，但是对于需要运行好几分钟的 {% include product %} 维护窗口，或者临时网络故障，该 API 可能就捉襟见肘了。

[https://github.com/shotgunsoftware/python-api/blob/master/shotgun_api3/shotgun.py#L1554](https://github.com/shotgunsoftware/python-api/blob/master/shotgun_api3/shotgun.py#L1554)

根据插件的用途，还可以注册该插件，以便在处理事件时遇到问题之际，保持平稳推进。了解 registerCallback 函数的 stopOnError 参数：

[https://github.com/shotgunsoftware/shotgunEvents/wiki/API#wiki-registerCallback](https://github.com/shotgunsoftware/shotgunEvents/wiki/API#wiki-registerCallback)

{% include info title="注意" content="插件不会停止运行，但不会在出现故障时进行重试。"%}
