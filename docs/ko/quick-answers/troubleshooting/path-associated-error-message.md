---
layout: default
title: “<PATH>” 경로가 {% include product %} 엔티티 “<ENTITY>”와 이미 연결되어 있음
pagename: path-associated-error-message
lang: ko
---

# 데이터베이스 동시성 문제: `<PATH>` 경로가 {% include product %} 엔티티 `<ENTITY>`와 이미 연결되어 있음

## 관련 오류 메시지:

- 데이터베이스 동시성 문제: `<PATH>` 경로가 {% include product %} 엔티티 `<ENTITY>`와 이미 연결되어 있습니다.
- 경로에 대한 행 ID를 확인할 수 없습니다!

## 예시:

이 오류는 툴킷 사용자가 폴더를 작성하려고 할 때 발생합니다. 다음은 전체 오류입니다.

```
ERROR: Database concurrency problems: The path
'Z:\projects\SpaceRocks\shots\ABC_0059' is already associated with
Shotgun entity {'type': 'Shot', 'id': 1809, 'name': 'ABC_0059'}. Please re-run
folder creation to try again.
```
## 오류의 원인은 무엇입니까?

이미 FilesystemLocation 엔티티가 있는 폴더에 대해 이 엔티티를 만들려고 하는 경우에 발생합니다.

## 해결 방법

잘못된 FilesystemLocation 엔티티를 지웁니다. 잘못된 FilesystemLocation 엔티티 세트로 범위를 좁힐 수 있는 경우 해당 엔티티 세트를 제거합니다. 그러나 대부분의 경우 프로젝트의 모든 경로가 손상되어 모두 이동해야 합니다.

- FilesystemLocation 엔티티를 지우는 방법: 이상적으로는 `tank unregister_folders`를 실행할 수 있습니다. 모든 엔티티를 지우려면 tank `unregister_folders --all`을 실행합니다. (`tank unregister_folders`의 모든 옵션에 대해 인자 없이 실행하면 사용 정보가 출력됩니다.)
- 그러나 DB가 이미 불안정한 상태이므로 작동하지 않거나 부분적으로만 작동할 수 있습니다. 명령을 실행하고 나면 {% include product %}의 FilesystemLocations로 돌아가서 삭제될 것으로 예상되는 항목이 실제로 사라졌는지 확인합니다. 그렇지 않은 경우 잘못된 엔티티를 선택하고 수동으로 휴지통으로 이동합니다.

이때 {% include product %}의 FilesystemLocations는 정리되지만 아티스트의 로컬 캐시에 변경 사항이 반영되지 않을 수 있습니다. 마지막 단계는 각 사용자의 컴퓨터에서 로컬 캐시를 실제로 동기화하는 것입니다. 이렇게 하려면 tank `synchronize_folders --full`을 실행해야 합니다.

이 모든 단계를 수행하고 나면 경로 캐시가 양호한 상태가 되고 해당 오류가 더 이상 나타나지 않아야 합니다.

## 관련 링크

- [해당 코드의 내용](https://github.com/shotgunsoftware/tk-core/blob/01bb9547cec19cc2a959858b09a8b349a388b56f/python/tank/path_cache.py#L491-L498)
- [경로 캐시는 무엇입니까? 파일 시스템 위치는 무엇입니까?](https://developer.shotgridsoftware.com/ko/cbbf99a4/)

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/how-to-troubleshoot-folder-creation-errors/3578)하십시오.

