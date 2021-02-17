---
layout: default
title: Shotgun Desktop 能否在 Ubuntu 等 Debian 系统上运行？
pagename: sg-desktop-run-on-ubuntu
lang: zh_CN
---

# {% include product %} Desktop 能否在 Ubuntu 等 Debian 系统上运行？

目前，{% include product %} Desktop 不支持基于 Debian 的发行版。
过去，我们有一些客户曾试图让 {% include product %} Desktop 在此类系统上正常运行，使用 cpio 从 RPM 提取 {% include product %} Desktop，然后尝试满足库依存关系，但这样导致了较差的结果。有关参考，[请在我们的 dev 组中查看此主题](https://groups.google.com/a/shotgunsoftware.com/d/msg/shotgun-dev/nNBg4CKNBLc/naiGlJowBAAJ)。

请注意，我们未提供显式的库依存关系列表，因为 Python 本身位于很多系统级库之上。

目前我们还没有正式的 Debian 支持计划。Ubuntu 构建存在问题，但在更改时需要进行 QA 并支持额外的操作系统，这并不是一件简单的事情。

如果要手动运行并激活 Toolkit 而不使用 {% include product %} Desktop（[如此处文档所述](https://support.shotgunsoftware.com/hc/zh-cn/articles/219033208#Step%208.%20Run%20the%20activation%20script)），请从该文档页面下载 `activate_shotgun_pipeline_toolkit.py` 脚本 - 即手册的第 8 步，单击“单击以下载...”标题。


