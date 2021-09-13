---
layout: default
title: Tk-desktop 콘솔에서 자동으로 오류 무시
pagename: desktop-console-silently-ignoring-errors
lang: ko
---

# Tk-desktop 콘솔에서 자동으로 오류 무시

## 활용 사례

툴킷 앱을 개발할 때 "디버그 로깅 토글(Toggle debug logging)" 체크박스가 선택되어 있더라도 tk-desktop은 초기화 중에 앱에서 발생하는 모든 예외를 자동으로 무시합니다. 문제가 있다는 것을 아는 유일한 방법은 프로젝트의 구성을 로드한 후에 등록된 명령이 표시되지 않는다는 것입니다.

## 해결 방법

데스크톱이 프로젝트용 앱을 로드하는 경우 해당 로깅이 SG 데스크톱 기본 UI 프로세스로 전달되지 않습니다. 하지만 `tk-desktop.log`로 계속 출력되어야 합니다. 파일에서 예외를 확인합니다.


## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/8570)