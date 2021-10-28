---
layout: default
title: API 개요
pagename: python-api-overview
lang: ko
---

# API 개요

**참고:** {% include product %} API에 대한 자세한 내용은 [API 설명서](http://developer.shotgridsoftware.com/python-api/)를 참조하십시오.

{% include product %} Python API(응용프로그램 인터페이스)를 통해 사용자는 {% include product %} 소프트웨어와 자신의 도구를 쉽게 통합할 수 있습니다. 이를 통해 자동화된 프로세스를 만들고, 많은 타사 소프트웨어 패키지와 통합하며, 스튜디오 내 기존 도구와 통신할 수 있습니다. 스튜디오마다 요구 사항이 매우 다르기 때문에 {% include product %} API는 강력한 로우 레벨 기능을 제공하며 대부분의 비즈니스 로직을 유지합니다.

API는 미디어 및 엔터테인먼트 업계 전반에 널리 사용되는 공통 프로그래밍 언어인 [Python](https://www.python.org/)을 사용하여 빌드됩니다. 사용자의 {% include product %} 사이트에서 [{% include product %} Python API](https://github.com/shotgunsoftware/python-api)를 무료로 사용할 수 있습니다.

API는 CRUD 패턴을 따르므로 스크립트가 단일 엔티티 유형에 대한 만들기, 읽기, 업데이트 및 삭제 액션을 실행할 수 있습니다. 많은 작업에는 필터, 반환할 열 및 정렬 결과를 정의하는 기능이 포함됩니다.

API를 통해 {% include product %} 서버와 통신하기 위해 사용자의 자격 증명을 제공하거나 스크립트 키를 사용해 서버로 스크립트를 인증할 수 있습니다. 관리자(Admin) 메뉴에 나열된 스크립트(Scripts) 페이지에서 새 스크립트 키를 생성할 수 있습니다.

![스크립트](/images/dv-developers-api-01-scripts-01.png)

**팁:** 스크립트를 별도로 등록하여 각각에 대해 개별 API 키를 생성합니다. 이렇게 하면 [이벤트 로그](https://help.autodesk.com/view/SGSUB/KOR/?guid=SG_Administrator_ar_data_management_ar_event_logs_html)에서 각 스크립트와 스크립트가 수행하는 액션을 훨씬 정확하게 모니터링할 수 있습니다.

## 일반적인 첫 번째 프로젝트

API는 [https://github.com/shotgunsoftware/python-api](https://github.com/shotgunsoftware/python-api)에서 다운로드할 수 있습니다. 다음은 몇 가지 일반적인 첫 번째 프로젝트입니다.

1. [버전을 만들고 샷에 링크](http://developer.shotgridsoftware.com/python-api/cookbook/examples/basic_create_version_link_shot.html). 리뷰를 위해 새 렌더의 제출을 자동화할 수 있습니다.
2. [썸네일 업로드](http://developer.shotgridsoftware.com/python-api/cookbook/examples/basic_upload_thumbnail_version.html). 사이트의 모든 항목은 수동으로 추가하지 않고도 최신 썸네일을 보유할 수 있습니다.
3. [SVN과 같은 코드 리포지토리와 {% include product %} 통합](http://developer.shotgridsoftware.com/python-api/cookbook/examples/svn_integration.html) . 프로젝트에 {% include product %} 소프트웨어를 활용하여 모든 소프트웨어 개발을 관리합니다.

## API를 사용하여 수행할 수 없는 작업

* 권한 규칙 액세스 또는 변경(보안상의 이유)
* 페이지 설정 읽기 또는 변경
* 개별 페이지 또는 위젯에 대한 필터 또는 쿼리 설정 액세스
* UI와 상호 작용
* 조건부 형식 지정 규칙 추가, 편집 또는 제거
* 쿼리 필드 만들기 또는 편집

## AMI(액션 메뉴 항목)

[AMI](https://developer.shotgridsoftware.com/67695b40/)를 통해 {% include product %} 인터페이스 내에서 쉽게 시작할 수 있는 스크립트를 작성할 수 있습니다. AMI는 데이터 행을 마우스 오른쪽 버튼으로 클릭할 때 나타나는 상황에 맞는 메뉴에 표시되는 커스터마이즈 가능한 옵션입니다. 해당 옵션을 클릭하면 상황에 맞는 데이터 덤프를 웹 서버 또는 커스텀 브라우저 프로토콜 처리기로 보내 커스텀 비즈니스 로직을 실행할 수 있습니다.

다른 엔티티에 다른 AMI를 설정할 수 있으며 프로젝트별 또는 권한 그룹별로 액세스를 제한할 수 있습니다.

## 이벤트 트리거 데몬

{% include product %}에서 액션이 수행될 때마다(사용자 또는 API 스크립트에 의해) 이벤트가 생성됩니다. [이벤트 데몬](https://github.com/shotgunsoftware/shotgunEvents)은 해당 이벤트 스트림을 모니터링한 다음 사용자가 정의한 조건에 따라 특정 API 스크립트를 실행할 수 있습니다. 다음과 같은 예를 들 수 있습니다.

* 업스트림 태스크 상태에 따라 다운스트림 태스크 상태를 자동으로 변경합니다.
* 값이 변경되면 관련 컷 기간 필드를 다시 계산합니다.
* 샷이 특정 상태로 설정될 때 파일 패키징 및 전송 작업을 수행합니다.

## 추가 정보

{% include product %} API에 대한 자세한 정보는 다음 문서를 참조하십시오.

* [GitHub에서 {% include product %} API 다운로드](https://github.com/shotgunsoftware/python-api/)
* [{% include product %} API 설명서](http://developer.shotgridsoftware.com/python-api/)
* [{% include product %}-dev 리스트(공개)](https://groups.google.com/a/shotgunsoftware.com/forum/?fromgroups#!forum/shotgun-dev)
* [{% include product %} 이벤트 데몬 샘플 코드](https://github.com/shotgunsoftware/shotgunEvents)
* [이벤트 구동 트리거 작성](https://developer.shotgridsoftware.com/ko/0d8a11d9/)
* [{% include product %} 스키마](https://help.autodesk.com/view/SGSUB/KOR/?guid=SG_Administrator_ar_get_started_ar_shotgun_schema_html)
* [API 모범 사례](https://developer.shotgridsoftware.com/ko/09b77cf4/)

## 기여 및 협업

{% include product %} 소프트웨어로 세계와 공유하고 싶은 놀라운 도구를 만드셨다구요? 훌륭합니다. 정보를 서로 공유하고 협력하고자 하는 사람들이 모여 활발하게 활동하는 [개발자 커뮤니티](https://community.shotgridsoftware.com/)가 있습니다. 참여하려면 다음을 수행하십시오.

* [{% include product %} 커뮤니티](https://community.shotgridsoftware.com/)에 가입합니다.
* [GitHub](https://github.com/)에 코드를 게시합니다. 코드는 특정 파이프라인에 맞게 작성되지 않고 잘 기술되어야 하며 .txt 또는 .mdk 형식의 읽어보기가 있어야 합니다.
* dev 목록에 링크와 설명을 게시합니다. Dev 커뮤니티 및 {% include product %} 개발자들이 검토한 후 피드백을 제공하고 활발하게 의견을 남길 것입니다.

우리는 고객이 만든 많은 도구 및 통합을 통해 끊임없이 놀라운 영감을 얻습니다. 여러분도 할 수 있습니다.