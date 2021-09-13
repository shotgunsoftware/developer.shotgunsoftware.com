---
layout: default
title: 폴더 작성이 중단됨
pagename: folder-creation-aborded
lang: ko
---

# 폴더 작성 실패: 폴더를 작성하지 못함

## 활용 사례

현재 웹 인터페이스에서 새 프로젝트를 만든 다음 {% include product %} 데스크톱을 사용하여 툴킷을 중앙 집중식 설정으로 구성합니다. 하지만 에셋 이름을 편집하려고 하면 더 이상 작동하지 않고(아티스트가 Maya와 같은 CCD에서 편집하기 위해 파일을 열 수 없음) "폴더를 작성하지 못함"이라는 오류가 반환됩니다. {% include product %}에서는 문제를 해결하기 위해 tank 명령을 다시 실행하여 에셋을 등록 해제한 후 다시 등록하라고 하는 데 어디서 실행해야 할지 알 수 없습니다.

## 해결 방법

프로젝트에서 고급 설정 마법사를 실행하면 이 마법사를 실행하는 옵션이 의도적으로 제거됩니다. 하지만 원하는 경우 [프로젝트를 다시 설정](https://developer.shotgunsoftware.com/fb5544b1/)할 수 있습니다.

오류 메시지에 언급된 tank 명령을 실행해야 합니다.

```
tank.bat Asset ch03_rockat_drummer unregister_folders
```

`tank.bat`는 설치한 구성의 루트에서 찾을 수 있으며 위치를 잘 모르는 경우 [이 항목](https://community.shotgridsoftware.com/t/how-do-i-find-my-pipeline-configuration/191)을 참조하십시오.

## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/error-in-toolkit-after-renaming-asset/4108)