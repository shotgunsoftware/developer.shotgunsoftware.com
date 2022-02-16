---
layout: default
title: Maya
pagename: tk-maya
lang: ko
---

# Maya

Maya용 {% include product %} 엔진에는 {% include product %} 앱을 Maya에 통합하기 위한 표준 플랫폼이 포함되어 있습니다. 직접적으로 실행되는 경량의 플랫폼으로, Maya 메뉴 막대에 {% include product %} 메뉴를 추가합니다.

![엔진](../images/engines/maya_menu.png)

## Pyside

Maya용 {% include product %} 엔진에는 PySide 설치가 포함되어 있으며 필요할 때마다 활성화됩니다.

## Maya 프로젝트 관리

Maya용 {% include product %} 엔진이 시작되면 Maya 프로젝트가 이 엔진 설정에서 정의된 위치를 가리키도록 설정됩니다. 즉, 새 파일을 열면 프로젝트가 변경될 수도 있습니다. 파일을 기반으로 Maya 프로젝트가 설정되는 방법과 관련된 상세 정보는 템플릿 시스템을 사용하여 구성 파일에서 구성할 수 있습니다.

## 지원되는 응용프로그램 버전

이 항목은 테스트를 거쳐 2014-2022 응용프로그램 버전에서 작동하는 것으로 알려져 있습니다. 최신 릴리즈에서는 더 완벽하게 작동할 수 있지만 이러한 버전에서 아직 공식적으로 테스트되지는 않았습니다.

## 설치 및 업데이트

{% include product %} Pipeline Toolkit에 이 엔진 추가
asset 환경의 XYZ 프로젝트에 이 엔진을 추가하려면 다음 명령을 실행합니다.

```
> tank Project XYZ install_engine asset tk-maya
```

### 최신 버전으로 업데이트

프로젝트에 이 항목이 이미 설치되어 있는 경우 최신 버전을 얻으려면 `update` 명령을 실행할 수 있습니다. 특정 프로젝트와 함께 제공되는 tank 명령을 탐색하여 다음과 같이 실행할 수 있습니다.

```
> cd /my_tank_configs/project_xyz
> ./tank updates
```

또는 스튜디오 tank 명령을 실행하고 업데이트 확인을 실행할 프로젝트 이름을 지정할 수 있습니다.

```
> tank Project XYZ updates
```

## 협업 및 개선

{% include product %} Pipeline Toolkit에 액세스할 수 있다면 모든 앱, 엔진 및 프레임워크가 저장 및 관리되는 Github에서 그 소스 코드에도 액세스할 수 있습니다. 이러한 항목을 자유롭게 개선하여 향후 독립적인 개발을 위한 기반으로 사용하고 변경 후 다시 사용자 요청을 제출하거나, 아니면 그냥 조금만 손을 보고 어떻게 빌드되었는지, 툴킷이 어떻게 작동하는지 확인해 보십시오. https://github.com/shotgunsoftware/tk-maya에서 이 코드 리포지토리에 액세스할 수 있습니다.





