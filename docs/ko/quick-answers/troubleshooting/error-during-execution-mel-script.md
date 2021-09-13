---
layout: default
title: 작업 영역 변경 실패 - MEL 스크립트를 실행하는 동안 오류 발생
pagename: error-during-execution-mel-script
lang: ko
---

# 작업 영역 변경 실패 - MEL 스크립트를 실행하는 동안 오류 발생

## 활용 사례

네트워크에 대한 액세스 권한이 없는 프리랜서를 위해 새 특수 파이프라인 구성을 만들 때 새 루트 이름을 만들고 다른 경로를 지정했습니다. 프로덕션 파이프라인 구성에는 파일 서버를 가리키는 루트 경로가 있습니다.

그러나 Maya에서 `tk-multi-workfiles`를 사용하여 새 파일을 만들 때 다음 오류가 발생합니다.

```
Failed to change work area - Error during execution of MEL script: file: C:/Program files/Autodesk/Maya2019/scripts/others/setProject.mel line 332: New project location C:\VetorZero\work\Shotgun-workflow_completo\sequences\Seq_001\SH_010\ANIM\maya is not a valid directory, project not created.
Calling Procedure: setProject, in file “C:\Program Files\Shotgun\c” set project(“C:\Vetorzero\work\SHOTGUN-workflow_completo\sequences\Seq_001\SH_010\ANIM\maya”)
```

폴더를 만들었지만 "maya" 폴더가 만들어지지 않았습니다.

## 해결 방법

"maya" 폴더가 실수로 삭제되지 않았는지 확인합니다. "maya" 폴더가 삭제된 경우 이 오류가 표시됩니다.

## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/new-file-maya-action-error/8225)