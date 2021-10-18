---
layout: default
title: 프레임 서버에 오류가 발생함
pagename: frame-server-error
lang: ko
---

# 프레임 서버에 오류가 발생함

## 활용 사례

SG 데스크톱에서 Nuke를 시작할 때 "프레임 서버에 오류가 발생했습니다."라는 오류 메시지가 표시되고 계속해서 작업할 수 있습니다.

완료 오류:

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

## 해결 방법

이 오류는 구성에 아직 개발 경로가 있는 경우 발생할 수 있습니다.

## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/the-frame-server-has-encountered-an-error/11192)