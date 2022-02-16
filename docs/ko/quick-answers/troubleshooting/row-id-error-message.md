---
layout: default
title: 경로에 대한 행 ID를 확인할 수 없습니다!
pagename: row-id-error-message
lang: ko
---

# 경로에 대한 행 ID를 확인할 수 없습니다!

## 관련 오류 메시지:

- 경로에 대한 행 ID를 확인할 수 없습니다!
- 데이터베이스 동시성 문제: `<PATH>` 경로가 {% include product %} 엔티티 `<ENTITY>`와 이미 연결되어 있습니다.

## 예시:

툴킷 사용자가 폴더를 만들 때 "경로에 대한 행 ID를 확인할 수 없습니다!" 라는 오류가 표시됩니다.

일반적으로 이 오류는 FileSystemLocation 엔티티를 만들지만 경우에 따라 중복 항목이 생성되어 전체 호스트 문제를 일으킬 수 있습니다.

전체 오류는 다음과 같습니다.

```
Creating folders, stand by...

ERROR: Could not resolve row id for path! Please contact support! trying to
resolve path '\\server\nas_production\CLICK\00_CG\scenes\Animation\01\001'.
Source data set: [{'path_cache_row_id': 8711, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001',
'metadata': {'type': '{% include product %}_entity', 'name': 'sg_scenenum', 'filters':
[{'path': 'sg_sequence', 'values': ['$sequence'], 'relation': 'is'}],
'entity_type': 'Shot'}, 'primary': True, 'entity': {'type': 'Shot', 'id':
1571, 'name': '001_01_001'}}, {'path_cache_row_id': 8712, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001\\Fx',
'metadata': {'type': '{% include product %}_step', 'name': 'short_name'}, 'primary': True,
'entity': {'type': 'Step', 'id': 6, 'name': 'FX'}}, {'path_cache_row_id':
8713, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001\\Comp',
```
_참고: 이보다 훨씬 더 길게 표시될 수 있습니다._

## 오류의 원인은 무엇입니까?

이 오류는 {% include product %}(사이트 기본 설정(Site Prefs) -> 파일 관리(File Management))에서 지정된 저장소 루트와 파이프라인 구성의 c`onfig/core/roots.yml` 간의 불일치를 가리킵니다.

Windows를 실행하는 스튜디오에서 대소문자 불일치로 인해 종종 발생합니다. 해당 경로는 대소문자를 구분하지 않지만, 구성은 대소문자를 구분합니다. `E:\Projects`와 `E:\projects`처럼 간단한 차이로도 이 오류가 발생할 수 있습니다.

## 백그라운드에서 어떤 일이 발생합니까?

코드는 방금 생성한 경로에 대한 FilesystemLocation 엔티티를 {% include product %}에서 만들고, {% include product %}의 저장소 루트를 사용하여 경로의 루트를 결정합니다. 그런 다음 로컬 캐시에 동일한 항목을 만들고 데이터베이스에서 저장할 위치를 결정해야 합니다. 로컬 캐시의 경우 `roots.yml`을 사용하여 경로의 루트를 확인하며, 대소문자가 일치하지 않기 때문에 생성 경로가 {% include product %}에서 입력한 경로와 일치하지 않습니다. 여기서 오류가 발생합니다.

특히 오류가 명확하게 발생하지 않아 좋지 않은 결과가 발생했습니다. 폴더가 작성되고, FilesystemLocation 항목이 작성되고, 로컬 경로 캐시에서 동기화되지 않았으며, 저장소 루트가 일치하지 않아 동기화할 수도 없습니다.

## 해결 방법

먼저 사이트 기본 설정(Site Prefs)의 저장소 루트 경로가 `config/core/roots.yml`의 경로와 일치하는지 확인합니다. 불일치를 수정하면 후속 폴더 생성 호출 시 오류가 사라집니다.

그런 다음 잘못된 FilesystemLocation 엔티티를 지웁니다. 잘못된 FilesystemLocation 엔티티 세트로 범위를 좁힐 수 있는 경우 해당 엔티티 세트를 제거합니다. 그러나 대부분의 경우 프로젝트의 모든 경로가 손상되어 모두 이동해야 합니다.

- FilesystemLocation 엔티티를 지우는 방법: 이상적으로는 `tank unregister_folders`를 실행할 수 있습니다. 모든 엔티티를 지우려면 tank `unregister_folders --all`을 실행합니다. (`tank unregister_folders`의 모든 옵션에 대해 인자 없이 실행하면 사용 정보가 출력됩니다.)
- 그러나 DB가 이미 불안정한 상태이므로 작동하지 않거나 부분적으로만 작동할 수 있습니다. 명령을 실행하고 나면 {% include product %}의 FilesystemLocations로 돌아가서 삭제될 것으로 예상되는 항목이 실제로 사라졌는지 확인합니다. 그렇지 않은 경우 잘못된 엔티티를 선택하고 수동으로 휴지통으로 이동합니다.

이때 {% include product %}의 FilesystemLocations는 정리되지만 아티스트의 로컬 캐시에 변경 사항이 반영되지 않을 수 있습니다. 마지막 단계는 각 사용자의 컴퓨터에서 로컬 캐시를 실제로 동기화하는 것입니다. 이렇게 하려면 tank `synchronize_folders --full`을 실행해야 합니다.

이 모든 단계를 수행하고 나면 경로 캐시가 양호한 상태가 되고 해당 오류가 더 이상 나타나지 않아야 합니다.

## 관련 링크

- [해당 코드의 내용](https://github.com/shotgunsoftware/tk-core/blob/01bb9547cec19cc2a959858b09a8b349a388b56f/python/tank/path_cache.py#L491-L498)
- [경로 캐시는 무엇입니까? 파일 시스템 위치는 무엇입니까?](https://developer.shotgridsoftware.com/ko/cbbf99a4/)

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/how-to-troubleshoot-folder-creation-errors/3578)하십시오.

