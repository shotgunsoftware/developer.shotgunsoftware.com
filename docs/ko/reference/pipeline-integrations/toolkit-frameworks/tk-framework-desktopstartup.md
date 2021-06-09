---
layout: default
title: 데스크톱 시작
pagename: tk-framework-desktopstartup
lang: ko
---

# 툴킷 Desktop Startup Framework
Desktop Startup Framework는 {% include product %} 데스크톱의 시작 로직을 구현합니다. 주요 기능은 다음과 같습니다.

1. 브라우저 통합 초기화
2. 사용자 로그인
3. 툴킷 다운로드
4. 사이트 구성 설정
5. 필요 시 자신과 사이트 구성 자동 업데이트
6. `tk-desktop` 엔진 실행

> 내부 툴킷 프레임워크이므로 이 프레임워크가 구현하는 인터페이스는 변경될 수 있습니다. 이 프레임워크를 프로젝트에서는 사용하지 않는 것이 좋습니다.

### 시작 로직 잠금

> 이 경우 {% include product %} 데스크톱 앱 버전 `1.3.4`가 필요합니다. 응용프로그램 버전이 확실하지 않으면 {% include product %} 데스크톱을 실행하십시오. 로그인하고 나면 오른쪽 아래의 사용자 아이콘을 클릭하고, `About...`을 클릭합니다. `App Version`이 `1.3.4` 이상이어야 합니다.

기본적으로 {% include product %} 데스크톱은 `tk-framework-desktopstartup` 업데이트를 사용자 컴퓨터에 로컬로 다운로드하고, 응용프로그램 실행 시퀀스 중에 이를 사용합니다. 응용프로그램을 실행하면 툴킷이 프레임워크 업데이트를 자동으로 확인합니다. 또한 업데이트가 있으면 자동으로 다운로드하여 설치합니다.

아니면, {% include product %} 데스크톱이 로컬 사본 대신 특정 프레임워크 사본을 사용하도록 구성해도 됩니다. 이렇게 하면 자동 업데이트가 비활성화되기 때문에 시작 로직 업데이트는 여러분이 직접 책임져야 합니다. 업데이트를 최신 상태로 유지하려면 [이 페이지](https://support.shotgunsoftware.com/entries/97454918)를 구독하는 것이 좋습니다.

#### GitHub에서 특정 릴리즈 다운로드

GitHub에서는 수동으로 업데이트를 다운로드해야 합니다. 번들은 [릴리즈](https://github.com/shotgunsoftware/tk-framework-desktopstartup/releases) 페이지에서 쉽게 다운로드할 수 있고, 각각의 공식 릴리즈에 대한 자세한 정보는 [여기](https://support.shotgunsoftware.com/entries/97454918#toc_release_notes)에서 참조할 수 있습니다.

#### 특정 사본을 사용하도록 {% include product %} 데스크톱 구성

시작 로직을 잠그는 유일한 방법은 환경 변수를 사용하는 것입니다. `SGTK_DESKTOP_STARTUP_LOCATION`을 프레임워크 사본의 루트 폴더로 설정하면 {% include product %} 데스크톱으로 하여금 시작 시 이 코드 사본을 사용하도록 할 수 있습니다. 이 변수를 설정하면 {% include product %} 데스크톱을 실행할 수 있고, 그러면 이 특정한 시작 로직 사본을 사용하게 됩니다.

> 현재는 기술적 한계로 인해 시작 로직을 잠글 때 `About...` 상자의 `Startup Version` 필드는 `Undefined` 상태로 유지된다는 점에 유의해 주십시오.

#### 이전 동작으로 되돌리기

변경 사항을 되돌리려면 환경 변수 설정을 해제하고 {% include product %} 데스크톱을 실행하면 됩니다.
