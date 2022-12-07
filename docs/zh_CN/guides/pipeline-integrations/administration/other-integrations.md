---
layout: default
title: 其他集成
pagename: other-integrations
lang: zh_CN
---

# 其他集成

借助 {% include product %} 的 API，您可以集成许多第三方软件包。但是，{% include product %} 本身已经集成了一些软件包。

## cineSync

cineSync 允许您在多个位置之间同时进行同步播放。{% include product %} 的集成允许您创建版本的播放列表，在 cineSync 中播放它，以及将您在会话期间所做的注释直接发送回 {% include product %}。

有关详细信息，请参见 [https://www.cinesync.com/manual/latest](https://www.cinesync.com/manual/latest/)。

## Deadline

{% include product %}+Deadline 集成允许您自动将包含缩略图、指向帧的链接和其他元数据的渲染版本提交到 {% include product %}。

有关详细信息，请参见 [https://docs.thinkboxsoftware.com/products/deadline/5.2/User%20Manual/manual/shotgunevent.html](https://docs.thinkboxsoftware.com/products/deadline/5.2/User%20Manual/manual/shotgunevent.html)。

## Rush

与 Deadline 集成很像，{% include product %}+Rush 集成允许您自动将包含缩略图、指向帧的链接和其他元数据的渲染版本提交到 {% include product %}。

有关详细信息，请参见 [https://seriss.com/rush-current/index.html](https://seriss.com/rush-current/index.html)。

## Subversion (SVN)

{% include product %} 简单而灵活的集成（我们在内部使用），让我们可以跟踪修订并将其链接至 {% include product %} 中的工单和发布版本。我们还提供了指向 Trac 的链接以与外部 Web SVN 库查看器集成。 操作方法为：向 SVN 添加一个发布-提交挂钩，这是一个 {% include product %} API 脚本，用于从提交中获取某些环境变量，然后在 {% include product %} 中创建一个修订实体，并在其中填充各种字段。可以对其进行修改以满足您的工作室的需求，由于它仅使用 API，因此可以用于本地或托管安装。有关详细信息，请参见 [https://subversion.apache.org/docs](https://subversion.apache.org/docs/)。
