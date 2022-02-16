---
layout: default
title: TankError 템플릿에서 경로를 확인하려고 시도했습니다.
pagename: tank-error-tried-to-resolve-a-path
lang: ko
---

# TankError: 템플릿에서 경로를 확인하려고 시도했습니다.

## 활용 사례 1

SGTK에 대한 새 구성을 설정하고 파일 열기(File Open) 대화상자(tk-multi-workfiles2에서)를 통해 새 파일을 작성하려고 하면 다음 오류가 발생합니다.

```
TankError: Tried to resolve a path from the template <Sgtk TemplatePath asset_work_area_maya:
```

## 활용 사례 2

특정 작업에서 저장하려고 하면 다음 오류가 발생합니다.

```
TankError: Tried to resolve a path from the template <Sgtk TemplatePath nuke_shot_work:
```


## 해결 방법

사례 1의 경우: `asset.yml` 파일을 확인합니다. 필터가 누락되었을 수 있습니다.

` - { "path": "sg_asset_type", "relation": "is", "values": [ "$asset_type"] }`

사례 2의 경우: 시퀀스의 이름이 바뀌고 몇 개의 FilesystemLocations 뒤에 숨겨져 있어 툴킷에 혼동이 있을 수 있습니다.

해결 방법:

- Shotgun에서 오래된 FilesystemLocations를 삭제합니다.
- 툴킷에서 오래된 FilesystemLocations와 관련된 폴더의 등록을 해제합니다.
- 툴킷에서 폴더를 다시 등록합니다.


## 관련 링크

[여기](https://community.shotgridsoftware.com/t/6468/10)에서 커뮤니티의 전체 스레드를 확인하고 [여기](https://community.shotgridsoftware.com/t/9686)에서 이 커뮤니티 스레드를 참조하십시오.