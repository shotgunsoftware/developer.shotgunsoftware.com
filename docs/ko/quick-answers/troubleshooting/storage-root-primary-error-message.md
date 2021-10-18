---
layout: default
title: 경고: 기본 루트 저장소를 SG 로컬 저장소에 매핑할 수 없습니다.
pagename: review-error-message-root
lang: ko
---

# 경고: 기본 루트 저장소를 SG 로컬 저장소에 매핑할 수 없습니다.

## 활용 사례

드라이브 파일 스트림을 사용하여 프로젝트를 설정하고 Google Drive를 기본 저장소로 사용하려고 하면 프로젝트 마법사가 저장소 구성에 액세스할 때 콘솔에 다음 경고가 표시됩니다.

`[WARNING] Storage root primary could not be mapped to a SG local storage`

**계속(continue)**을 눌러도 작동하지 않습니다.

## 해결 방법

이 문제는 저장소 이름에 오타가 있을 때 발생할 수 있습니다. Google Drive의 이름과 정확히 일치하는지 확인하십시오.

또한 Google Drive를 사용할 때 중복 프로젝트가 나타나지 않도록 파일을 항상 로컬로 유지하도록 설정되어 있는지 확인하십시오.

## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/11185)