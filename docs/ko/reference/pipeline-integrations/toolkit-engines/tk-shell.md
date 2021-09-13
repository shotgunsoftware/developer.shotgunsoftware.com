---
layout: default
title: 쉘
pagename: tk-shell
lang: ko
---

# 쉘

쉘용 {% include product %} 엔진은 명령행 상호 작용을 처리하며 Core API의 일부로 배포되는 `tank` 명령과 완전히 통합됩니다. 터미널에서 `tank` 명령을 실행하면 툴킷은 엔진을 시작하여 앱 실행을 처리합니다.

tank 명령에 대한 자세한 내용은 [고급 툴킷 관리 설명서](https://developer.shotgridsoftware.com/425b1da4/?title=Advanced+Toolkit+Administration#using-the-tank-command)를 참조하십시오.

![엔진](../images/engines/sg_shell_1.png)

## 설치 및 업데이트

### {% include product %} Pipeline Toolkit에 이 엔진 추가

asset 환경의 XYZ 프로젝트에 이 엔진을 추가하려면 다음 명령을 실행합니다.


```
> tank Project XYZ install_engine asset tk-shell
```

### 최신 버전으로 업데이트

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

{% include product %} Pipeline Toolkit에 액세스할 수 있다면 모든 앱, 엔진 및 프레임워크가 저장 및 관리되는 Github에서 그 소스 코드에도 액세스할 수 있습니다. 이러한 항목을 자유롭게 개선하여 향후 독립적인 개발을 위한 기반으로 사용하고 변경 후 다시 사용자 요청을 제출하거나, 아니면 그냥 조금만 손을 보고 어떻게 빌드되었는지, 툴킷이 어떻게 작동하는지 확인해 보십시오. https://github.com/shotgunsoftware/tk-shell에서 이 코드 리포지토리에 액세스할 수 있습니다.