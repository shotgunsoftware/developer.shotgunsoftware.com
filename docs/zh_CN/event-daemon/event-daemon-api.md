---
layout: default
title: API
pagename: event-daemon-api
lang: zh_CN
---

# API

<a id="registerCallbacks"></a>

## registerCallbacks

所有插件中的全局级别函数，用于告知框架有关插件中事件处理入口点的信息。

**registerCallbacks(reg)**

- reg：您将与之进行交互，以告知框架要调用哪些函数的 [`Registrar`](#Registrar)。

<a id="Registrar"></a>

## Registrar

Registrar 是用于告知框架如何与插件交互的对象。它将传递到 [`registerCallbacks`](#registerCallbacks) 函数。

### 属性

<a id="logger"></a>
**logger**

请参见 [`getLogger`](#getLogger)。

### 方法

<a id="getLogger"></a>
**getLogger**

获取用于从插件中记录消息的 Python Logger 对象。

**setEmails(\*emails)**

设置当此插件或其任何回调中发生错误时应接收错误和重要通知的电子邮件。

将电子邮件发送到配置文件中指定的默认地址（默认）

```python
reg.setEmails(True)
```

禁用电子邮件（不建议执行此操作，因为您不会收到错误消息）

```python
reg.setEmails(False)
```

向特定地址发送电子邮件，使用

```python
reg.setEmails('user1@domain.com')
```

或

```python
reg.setEmails('user1@domain.com', 'user2@domain.com')
```

<a id="registerCallback"></a>
**registerCallback(sgScriptName, sgScriptKey, callback, matchEvents=None, args=None, stopOnError=True)**

将回调注册到此插件的插件。

- `sgScriptName`：从 {% include product %} 脚本页面获取的脚本的名称。
- `sgScriptKey`：从 {% include product %} 脚本页面获取的脚本的应用程序密钥。
- `callback`：具有 `__call__` 方法的函数或对象。请参见 [`exampleCallback`](#exampleCallback)。
- `matchEvents`：要传递到回调的事件的过滤器。
- `args`：希望框架重新传递到回调的任何对象。
- `stopOnError`：布尔值，此回调中出现异常会导致此插件中的所有回调停止处理事件。默认值为 `True`。

`sgScriptName` 用于标识 {% include product %} 的插件。任何名称都可以在任意数量的回调之间共享，也可以是单个回调的唯一名称。

`sgScriptKey` 用于标识 {% include product %} 的插件，且应该是指定 `sgScriptName` 的相应键。

当与过滤器匹配的事件需要处理时，将调用指定的回调对象。虽然任何可调用类都应该能够运行，但不建议使用此处的类。使用具有 `__call__` 方法的函数或实例更为合适。

`matchEvent` 参数是一个过滤器，用于指定将要注册的回调感兴趣的事件。如果未指定 `matchEvents` 或指定“无”，则所有事件都将传递到回调。否则，`matchEvents` 过滤器中的每个键都是一个事件类型，而每个值是可能的属性名称的列表。

```python
matchEvents = {
    'Shotgun_Task_Change': ['sg_status_list'],
}
```

可以有多个事件类型或属性名称

```python
matchEvents = {
    'Shotgun_Task_Change': ['sg_status_list'],
    'Shotgun_Version_Change': ['description', 'sg_status_list']
}
```

可以对具有给定属性名称的任何事件类型进行过滤

```python
matchEvents = {
    '*': ['sg_status_list'],
}
```

还可以针对给定事件类型的任何属性名称进行过滤

```python
matchEvents = {
    'Shotgun_Version_Change': ['*']
}
```

尽管以下内容是有效的且功能相当于不指定任何内容，但它实际上毫无用处

```python
matchEvents = {
    '*': ['*']
}
```

与非特定于字段的事件类型（如“\_New”或“\_Retirement”）进行匹配时，不提供列表，而是将 `None` 作为值进行传递。

```python
matchEvents = {
    'Shotgun_Version_New': None
}
```

事件框架本身不会使用 `args` 参数，而只是将其重新传递到回调，不进行任何修改。

{% include info title="注意" content="使用 `args` 参数，您可以在 [`registerCallbacks`](#registerCallbacks) 函数中处理耗时的内容，并在处理事件时将其重新传递给您。" %}

`args` 参数的另一个用途是在公用的可变参数（例如 `dict`）中传递给多个回调，使其共享数据。

`stopOnError` 参数会告知系统此回调中的异常是否会导致插件中所有回调的事件处理停止。默认情况下，此参数为 `True`，但可以切换为 `False`。如果存在任何错误但事件处理不停止，您仍会收到错误通知邮件。根据回调设置，您可以具有一些关键回调，对于这些回调，此参数为 `True`，对于其他回调则为 `False`。

<a id="Callback"></a>

## 回调

[`Registrar.registerCallback`](#registerCallback) 注册的任何插件入口点通常为如下所示的全局级别函数：

<a id="exampleCallback"></a>
**exampleCallback(sg, logger, event, args)**

- `sg`：{% include product %} 连接实例。
- `logger`：为您预先配置的 Python logging.Logger 对象。
- `event`：要处理的 {% include product %} 事件。
- `args`：在回调注册时指定的 args 参数。

{% include info title="注意" content="可以在对象实例上将回调作为 `__call__` 方法实施，我们将此留给用户做练习。" %}
