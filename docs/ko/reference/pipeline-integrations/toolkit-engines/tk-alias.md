---
layout: default
title: Alias
pagename: tk-alias
lang: ko
---

# Alias

Alias용 {% include product %} 엔진에는 {% include product %} 앱을 Alias에 통합하기 위한 표준 플랫폼이 포함되어 있습니다. 직접적으로 실행되는 경량의 플랫폼으로, Alias 메뉴에 {% include product %} 메뉴를 추가합니다.

# 앱 개발자를 위한 정보

## PySide

Alias용 {% include product %} 엔진은 {% include product %} 데스크톱과 함께 제공되는 PySide 설치를 사용하며 필요할 때마다 활성화됩니다.

## Alias 프로젝트 관리

Alias용 {% include product %} 엔진이 시작되면 Alias 프로젝트가 이 엔진 설정에서 정의된 위치를 가리키도록 설정됩니다. 즉, 새 파일을 열면 프로젝트가 변경될 수도 있습니다. 파일을 기반으로 Alias 프로젝트가 설정되는 방법과 관련된 상세 정보는 템플릿 시스템을 사용하여 구성 파일에서 구성할 수 있습니다.

***

# tk-alias 작업

이 {% include product %} 통합은 Alias 응용프로그램 제품군(Concept, Surface 및 AutoStudio)을 지원합니다.

Alias가 열리면 {% include product %} 메뉴(Alias 엔진)가 메뉴 막대에 추가됩니다.

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunOtherApps.png)


### 파일 열기 및 저장

내 태스크(My Tasks) 및 에셋(Assets) 탭을 사용하여 할당된 모든 태스크를 보고 에셋을 찾을 수 있습니다.오른쪽에서 이 탭을 사용하여 왼쪽에 선택된 항목과 연관된 모든 파일, 작업 파일 또는 게시된 파일을 볼 수 있습니다.

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunFileOpen.png)

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunFileSave.png)


### Snapshot

현재 씬의 빠른 백업을 작성하기 위한 스냅샷 대화상자를 엽니다.

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunSnapshot.png)


### Publish

파일을 {% include product %}에 게시하기 위한 게시(Publish) 대화상자를 엽니다. 게시하면 아티스트 다운스트림에서 사용할 수 있습니다. 자세한 내용은 [Alias에서 게시](https://github.com/shotgunsoftware/tk-alias/wiki/Publishing)를 참조하십시오.

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunPublish.png)


### Loader

Alias로 데이터를 로드할 수 있는 컨텐츠 Loader 앱을 엽니다. 자세한 내용은 [Alias에 로드](https://github.com/shotgunsoftware/tk-alias/wiki/Loading)를 참조하십시오.

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunLoader.png)

### Scene Breakdown

기한이 만료된 씬의 항목과 함께 참조된 (WREF 참조) 컨텐츠 목록을 표시하는 분할(Breakdown) 대화상자를 엽니다. 하나 이상의 항목을 선택하고 선택 항목 업데이트(Update Selected)를 클릭하여 전환하고 최신 버전의 컨텐츠를 사용합니다. 자세한 내용은 [Alias의 씬 분할](https://github.com/shotgunsoftware/tk-alias/wiki/Scene-Breakdown)을 참조하십시오.

![](https://help.autodesk.com/cloudhelp/2020/ENU/Alias-Shotgun/images/ShotgunBreakdown.png)

