---
layout: default
title: Create
pagename: tk-create
lang: ko
---

# {% include product %} 작성

Desktop2 엔진은 [{% include product %} Create](https://help.autodesk.com/view/SGSUB/KOR/?guid=SG_Supervisor_Artist_sa_create_sa_intro_create_html) 응용프로그램 내부에서 실행되는 엔진입니다. 브라우저 통합을 통해 {% include product %} 웹 응용프로그램에서뿐만 아니라 .{% include product %} Create에서도 DCC 시작을 처리합니다.

tk-desktop2 엔진은 {% include product %} Create와 툴킷을 통합할 수 있도록 합니다. {% include product %} Create는 [DCC 시작](https://help.autodesk.com/view/SGSUB/KOR/?guid=SG_Supervisor_Artist_sa_create_sa_create_artists_html#launching-your-creative-apps)을 비롯해 툴킷 사용자에게 익숙한 기능을 지원합니다.

![](../images/engines/create-dcc-01.png)

![](../images/engines/create-dcc-02.png)

## 설치 및 업데이트

### {% include product %} Pipeline Toolkit에 이 엔진 추가

asset 환경의 XYZ 프로젝트에 이 엔진을 추가하려면 다음 명령을 실행합니다.

```
> tank Project XYZ install_engine asset tk-desktop2
Updating to the latest version
```

프로젝트에 이 항목이 이미 설치되어 있는 경우 최신 버전을 얻으려면 `update` 명령을 실행할 수 있습니다. 특정 프로젝트와 함께 제공되는 tank 명령을 탐색하여 다음과 같이 실행할 수 있습니다.

```
> cd /my_tank_configs/project_xyz
> ./tank updates
```

또는 스튜디오 `tank` 명령을 실행하고 업데이트 확인을 실행할 프로젝트 이름을 지정할 수 있습니다.

```
> tank Project XYZ updates
```

## 협업 및 개선

{% include product %} Pipeline Toolkit에 액세스할 수 있다면 모든 앱, 엔진 및 프레임워크가 저장 및 관리되는 Github에서 그 소스 코드에도 액세스할 수 있습니다. 이러한 항목을 자유롭게 개선하여 향후 독립적인 개발을 위한 기반으로 사용하고 변경 후 다시 사용자 요청을 제출하거나, 아니면 그냥 조금만 손을 보고 어떻게 빌드되었는지, 툴킷이 어떻게 작동하는지 확인해 보십시오. https://github.com/shotgunsoftware/tk-desktop2에서 이 코드 리포지토리에 액세스할 수 있습니다.

## 특별 요구 사항

이 기능을 이용하려면 {% include product %} Pipeline Toolkit Core API 버전 v0.19.1 이상이 필요합니다.