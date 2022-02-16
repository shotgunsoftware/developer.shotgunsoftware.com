---
layout: default
title: 帧服务器遇到错误
pagename: frame-server-error
lang: zh_CN
---

# 帧服务器遇到错误

## 用例

从 SG Desktop 启动 Nuke 时，显示错误消息“帧服务器遇到错误。”，您可以继续工作。

完整错误：

```
The Frame Server has encountered an error.

Nuke 12.1v5, 64 bit, built Sep 30 2020.
Copyright (c) 2020 The Foundry Visionmongers Ltd. All Rights Reserved.
Loading - init.py
Traceback (most recent call last):
File “/Applications/Nuke12.1v5/Nuke12.1v5.app/Contents/Resources/pythonextensions/site-packages/foundry/frameserver/nuke/workerapplication.py”, line 18, in
from util import(asUtf8, asUnicode)
ImportError: cannot import name asUtf8
cannot import name asUtf8
```

## 如何修复

当配置上仍存在开发路径时，可能会发生此错误。

## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/the-frame-server-has-encountered-an-error/11192)