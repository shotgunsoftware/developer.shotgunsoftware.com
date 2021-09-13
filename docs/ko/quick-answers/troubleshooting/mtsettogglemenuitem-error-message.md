---
layout: default
title: ”MTsetToggleMenuItem” 프로시저를 찾을 수 없음
pagename: mtsettogglemenuitem-error-message
lang: ko
---

# "MTsetToggleMenuItem" 프로시저를 찾을 수 없음

## 관련 오류 메시지:

일반적인 시작 화면 후 전체 창을 로드하기 직전에 Maya에서 충돌이 발생합니다.
- "MTsetToggleMenuItem" 프로시저를 찾을 수 없음

## 해결 방법:

Maya를 시작하기 전에 before_app_launch 후크에서 의도치 않게 특정 항목이 경로에서 제거되어 Maya 시작 시 오류가 발생할 수 있습니다. 이 경우 Python 설치를 `PTHONPATH`에 추가하면 Maya 2019에서 플러그인 경로를 찾을 수 없습니다.

## 이 오류가 발생하는 원인의 예:
이 후크에서 `C:\Python27`이 `PYTHONPATH`로 설정되고 이 `PYTHONPATH`를 사용하여 워크스테이션을 실제로 설치했을 때 사용자에게 몇 가지 문제가 있었습니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/tk-maya-cannot-find-procedure-mtsettogglemenuitem/4629)하십시오.

