---
layout: default
title: The Frame Server has encountered an error
pagename: frame-server-error
lang: ja
---

# The Frame Server has encountered an error

## 使用例

SG Desktop から Nuke を起動すると、「The Frame Server has encountered an error」というエラー メッセージが表示され、作業を続行できます。

完全なエラーは、次のとおりです。

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

## 修正方法

このエラーは、設定にまだ dev パスが含まれている場合に発生することがあります。

## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/the-frame-server-has-encountered-an-error/11192)を参照してください。