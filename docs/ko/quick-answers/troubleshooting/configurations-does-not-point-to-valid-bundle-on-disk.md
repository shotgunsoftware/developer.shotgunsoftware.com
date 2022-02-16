---
layout: default
title: 구성이 디스크의 유효한 번들을 가리키지 않습니다!
pagename: configurations-does-not-point-to-valid-bundle-on-disk
lang: ko
---

# 구성이 디스크의 유효한 번들을 가리키지 않습니다!

## 활용 사례

{% include product %} 데스크톱을 처음 설치할 때 프로젝트를 연 후 파일 경로 뒤에 이 오류가 표시될 수 있습니다.

## 해결 방법

프로젝트의 파이프라인 구성 엔티티는 Windows의 구성에 대한 `...\{% include product %}\Configurations` 경로를 가리킵니다. 이는 올바른 경로가 아닐 수 있으므로 첫 단계에서 경로가 존재하는지 확인하거나 경로를 수정하십시오.

또는 해당 경로 위치에 대한 액세스 권한이 없는 중앙 집중식 설정에서 액세스하려고 하는 것일 수도 있습니다. 이 경우 분산 설정으로 전환하면 도움이 됩니다.


## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/first-time-setting-up-shotgun-and-i-have-this-error/9384)