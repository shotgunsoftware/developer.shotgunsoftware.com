---
layout: default
title: 개발자 개요
pagename: developer-overview
lang: ko
---

# 개발자 개요

### Python API

{% include product %} 소프트웨어는 {% include product %}에 액세스하고 다른 도구와 통합하는 데 사용할 수 있는 Python 기반 API를 제공합니다. 이 API는 {% include product %} 서버에서 생성, 읽기, 업데이트 및 삭제 액션의 실행을 허용하는 CRUD 패턴을 따릅니다. 각 요청은 단일 엔티티 유형에 작용하며, 특정 액션에 따라 필터, 반환할 열, 정렬 정보, 그 밖에 추가 옵션을 정의할 수 있습니다.

* [코드 리포지토리](https://github.com/shotgunsoftware/python-api)
* [설명서](http://developer.shotgridsoftware.com/python-api/)
* [포럼](https://community.shotgridsoftware.com/c/pipeline/6)

### 이벤트 트리거 프레임워크

{% include product %} 이벤트 스트림에 액세스하려면 이벤트 테이블을 모니터링하고 새로운 이벤트를 파악하여 처리하는 작업을 반복하는 것이 좋습니다.

많은 항목이 성공적으로 작동하려면 이 프로세스를 거쳐야 하며, 비즈니스 규칙과 직접적인 관련이 없는 항목은 적용해야 하는지 여부를 결정해야 합니다.

프레임워크의 역할은 비즈니스 로직 구현자를 대신해 따분한 모니터링 작업을 처리해 주는 것입니다.

이 프레임워크는 서버에서 실행되면서 {% include product %} 이벤트 스트림을 모니터링하는 데몬 프로세스입니다. 이벤트가 발견되면 데몬은 이벤트를 일련의 등록된 플러그인으로 전달합니다. 각각의 플러그인은 원하는 대로 이벤트를 처리할 수 있습니다.

* [코드 리포지토리](https://github.com/shotgunsoftware/shotgunevents)
* [설명서](https://github.com/shotgunsoftware/shotgunevents/wiki)

### 액션 메뉴 항목 프레임워크

API 개발자는 엔티티별로 상황에 맞는 메뉴 항목을 커스터마이즈할 수 있습니다. 예를 들어, 버전 페이지에서 여러 버전을 선택하고 마우스 오른쪽 버튼을 클릭한 후 PDF 보고서 작성 등을 선택할 수 있습니다. 이를 액션 메뉴 항목(AMI)이라고 합니다.

* [설명서]()
* [코드 리포지토리 예](http://developer.shotgridsoftware.com/python-api/cookbook/examples/ami_handler.html)
