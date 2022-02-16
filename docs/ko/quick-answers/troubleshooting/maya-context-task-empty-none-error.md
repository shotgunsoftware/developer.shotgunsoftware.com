---
layout: default
title: Maya에서 context.task를 출력하면 비어 있음("None")
pagename: maya-context-task-empty-none-error
lang: ko
---

# Maya에서 context.task를 출력하면 비어 있음("None")

## 활용 사례

Maya에서 `context.task`를 출력한 후에는 `empty “None”`이지만 다른 단계/태스크에서 다른 레이아웃 파일을 시도할 때는 `context.task` 상세 정보를 표시합니다. `Open > Layout > new file`을 통해 이동할 때도 `context.task` 상세 정보를 출력할 수 있지만 파일 저장(File Save)을 통해 파일을 저장할 때는 `context.task`가 없음(None)으로 표시됩니다.

## 해결 방법

작동하지 않는 샷 중 하나에 대해 [폴더 등록을 취소](https://community.shotgridsoftware.com/t/how-can-i-unregister-folders-when-using-a-distributed-config/189)한 다음 해당 폴더에 대한 폴더 생성을 다시 실행합니다.


## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/context-task-none/3705)