---
layout: default
title: 중요! 폴더 데이터로 ShotGrid를 업데이트할 수 없습니다.
pagename: could-not-update-with-folder-data
lang: ko
---

# TankError: 디스크에 폴더를 만들 수 없습니다. 오류 보고: 중요! 폴더 데이터로 {% include product %}를 업데이트할 수 없습니다.

## 활용 사례

중앙 집중식 구성을 사용하고 있으며 기존 프로젝트에 대한 Linux 지원을 추가하고 있지만 파일 시스템 구성에 문제가 있습니다.

다음 작업을 완료했습니다.

- roots.yml에 해당 루트 추가
- 파이프라인 구성, install_location.yml 등에 linux 경로 추가
- 소프트웨어 엔티티에 대한 linux 경로 추가

이제 {% include product %} 데스크톱이 성공적으로 시작되지만 프로그램을 시작하려고 하면 다음 오류가 발생합니다.

```
TankError: Could not create folders on disk. Error reported: Critical! Could not update Shotgun with folder data. Please contact support. Error details: API batch() request with index 0 failed.  All requests rolled back.
API create() CRUD ERROR #6: Create failed for [Attachment]: Path /mnt/cache/btltest3 doesn't match any defined Local Storage.
```

마찬가지로 tank 폴더 및 기타 명령을 실행하려고 하면 동일한 오류가 출력됩니다.

필요한 모든 곳에 linux 경로를 추가한 것으로 생각됩니다. 데이터베이스 동기화와 관련이 있을까요?

특히 `tank synchronize_folders`가 출력됩니다.

- 이 경로는 {% include product %} 개체와 관련이 없습니다.

## 해결 방법

사이트 기본 설정(Site Preferences) > 파일 관리(File Management)에서 {% include product %}의 로컬 저장소에 Linux 경로를 추가합니다.


## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/first-time-setting-up-shotgun-and-i-have-this-error/9384)