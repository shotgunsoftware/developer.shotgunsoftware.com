---
layout: default
title: 技术细节
pagename: event-daemon-technical-details
lang: zh_CN
---

# 技术概述

<a id="Event_Types"></a>

## 事件类型

您的触发器可以注册以接收通知的事件类型通常遵循以下形式：`Shotgun_[entity_type]_[New|Change|Retirement|Revival]`。下面是这种模式的一些示例：

    Shotgun_Note_New
    Shotgun_Shot_New
    Shotgun_Task_Change
    Shotgun_CustomEntity06_Change
    Shotgun_Playlist_Retirement
    Shotgun_Playlist_Revival

对于不涉及实体记录活动但关系到应用程序行为关键节点的事件，其模式可能与上述模式存在明显偏差。

    CRS_PlaylistShare_Create
    CRS_PlaylistShare_Revoke
    SG_RV_Session_Validate_Success
    Shotgun_Attachment_View
    Shotgun_Big_Query
    Shotgun_NotesApp_Summary_Email
    Shotgun_User_FailedLogin
    Shotgun_User_Login
    Shotgun_User_Logout
    Toolkit_App_Startup
    Toolkit_Desktop_ProjectLaunch
    Toolkit_Desktop_AppLaunch
    Toolkit_Folders_Create
    Toolkit_Folders_Delete

此列表并不完整，但是是一个很好的起点。如果您想要了解有关 {% include product %} 站点上的活动和事件类型的详细信息，请参考事件日志条目页面。在此页面上，您可以像任何其他实体类型的任何其他网格页面一样进行过滤和搜索。

### 缩略图的事件日志条目

每次为实体上传新缩略图时，系统都会使用 `` `Type` == `Shotgun_<Entity_Type>_Change` ``（例如 `Shotgun_Shot_Change`）创建事件日志条目。

1. `‘is_transient’` 字段值设置为 true：

```
{ "type": "attribute_change","attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11656,
 "is_transient": true
}
```

2. 当缩略图可用时，将创建一个新的事件日志条目，此时 `‘is_transient’` 字段值设置为 false：

```
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11656,
 "is_transient": false
}
```

3. 如果我们再次更新缩略图，即可得到这些新事件日志条目：

```
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": 11656, "new_value": 11657,
 "is_transient": true
}
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11657,
 "is_transient": false
}
```

4. 请注意，当附件的缩略图为占位符缩略图时，`‘old_value’` 字段将设置为空。

<a id="Plugin_Processing_Order"></a>

## 插件处理顺序

始终按相同的可预测顺序处理每个事件，如此一来，如果任何插件或回调存在相互依赖关系，即可放心地对其处理工作进行规划。

配置文件会指定一个 `paths` 配置，其中包含一个或多个插件位置。在列表中的位置越靠前，包含的插件就会越早被处理。

系统将按字母顺序升序处理插件路径中的每个插件。

{% include info title="注意" content="从内部来说，系统列出文件名列表并对其进行排序。" %}

最后，将按注册顺序调用插件注册的每个回调。先注册，先运行。

我们建议将需要在一定程度上共享状态的功能保存在与一个或多个回调相同的插件中。

<a id="Sharing_State"></a>

## 共享状态

有许多选项可用于需要共享状态的多个回调。

- 全局变量。呃，请不要这样做。
- 一个包含状态信息的已导入模块。这样也不行，但比完全是全局变量好一点。
- 一个在调用 [`Registrar.registerCallback`](API#wiki-registerCallback) 时传入 `args` 参数的可变要素。一个设计状态对象，或仅仅是一个 `dict`。首选。
- 在对象实例上执行回调（如 `__call__`），并在回调对象初始化时提供一些共享状态对象。最强大但也最复杂的方法。与上述 args 参数方法相比，可能有些不必要。

<a id="Event_Backlogs"></a>

## 事件积压

该框架旨在让每个插件对其感兴趣的每个事件进行一次处理，并且不会出现异常。为确保实现这一目标，框架会存储每个插件积压的未处理事件，并记住为每个插件提供的最后一个事件。下面简单介绍了可能出现积压的一些情况。

### 由于事件日志条目序列不连贯导致的积压

对于 {% include product %} 中发生的每个事件（字段更新、实体创建、实体停用等），其事件日志条目都具有唯一的 ID 编号。ID 编号序列有时并不是连贯的。导致这种不连贯的原因有很多，其中一个就是大型数据库事务尚未完成。

每次事件日志序列出现不连贯现象时，“空缺”的事件 ID 都会被纳入积压工作，以便日后处理。这样，事件进程便可在结束时处理来自长数据库事务的事件。

有时，事件日志序列中的“空缺”永远无法填补，例如当事务失败或还原页面设置更改时。在这种情况下，超过 5 分钟时限后，系统便不再等待相应事件日志条目 ID 编号，并将其从积压工作中移除。此时，系统将显示“积压事件 ID # 已超时”(Timeout elapsed on backlog event id #)消息。如果事件序列首次出现不连贯现象且系统已将其视为超时，此时将显示“事件 # 从未发生 - 忽略”(Event # never happened - ignoring)消息，并且此事件不会在第一时间纳入积压工作。

### 由于插件错误而导致的积压

在正常操作期间，框架会持续跟踪各个插件处理的最后一个事件。如果某个插件因任何原因发生故障，该插件将停止处理后续事件。修复插件后，例如修复某个错误后，该框架将从修复的插件所存储的最后一个事件之处开始处理事件。这样做是为了确保新修复的插件能够处理所有事件，包括那些在发生故障到修复错误期间发生的事件。如果故障是在很久以前发生的，这可能意味着需要回访大量事件，如此一来，已修复的插件可能需要一段时间来赶上其他正常运行的插件的进度。

在已修复的插件追赶进度时，其他插件会忽略相应事件，确保相同的插件不会对任何一个事件进行两次处理。此时，系统会显示“事件 X 过于久远。最后处理的事件是(Y)”(Event X is too old. Last event processed is (Y))消息。这是调试消息，可以放心地忽略。

目前没有正式的方法来跳过这一提示。该框架旨在确保每个插件仅对每个事件进行一次处理。但是，如果您了解 Python 及其 pickle 数据格式，那么您可以停止进程，通过 Python 解释器/交互式 Shell 打开 .id 文件，然后利用 pickle 模块解码文件内容并加以编辑，以便移除存储的 ID，这样就可以跳过累积积压工作了。我们不支持这种做法，风险由您自行承担。请在执行此操作之前正确备份 `.id` 文件。
