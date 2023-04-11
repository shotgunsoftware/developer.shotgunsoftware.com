---
layout: default
title: Python API 모범 사례
pagename: python-api-best-practices
lang: ko
---

# Python API 모범 사례


다음은 {% include product %} Python API 사용 시의 모범 사례 목록입니다.

## 성능

1.  스크립트에 필요하지 않은 필드를 요청하지 않습니다. 추가 필드를 포함하면 요청에 불필요한 오버헤드가 추가될 수 있습니다.
2.  필터는 최대한 구체적으로 만듭니다. 가능하면 결과를 얻은 후에 분석하는 것보다 API 쿼리에서 필터링하는 것이 좋습니다.
3.  정확한 일치 필터는 부분 일치 필터보다 성능이 우수합니다. 예를 들어 "포함(contains)"보다 "일치함(is)"을 사용하는 것이 더 좋습니다.

## 제어 및 디버깅

1.  스크립트에는 별도의 키를 사용하므로 모든 도구에 대해 고유한 키를 사용합니다. 이는 디버깅에 매우 중요합니다.
2.  모든 스크립트에는 소유자 또는 관리자(Admin)가 있어야 하며 관리자(Admin) 메뉴에서 스크립트(Scripts) 페이지의 정보는 최신 상태여야 합니다.
3.  [API 사용자용 읽기 전용 권한 그룹](https://developer.shotgridsoftware.com/ko/bbae2ca7/)을 만드는 것이 좋습니다. 많은 스크립트는 읽기 액세스 권한만 필요하므로 실수로 변경되는 경우를 제한할 수 있습니다.
4.  사용 중인 키를 트래킹하여 이전 스크립트를 제거할 수 있습니다. 이 작업을 쉽게 하기 위해 일부 스튜디오는 API 래퍼로 감사 정보를 스크립팅합니다.
5.  {% include product %}의 각 필드 이름은 UI에서 사용되는 표시 이름(반드시 고유하지는 않음)과 API에서 사용되는 내부 필드 이름, 두 가지가 있습니다. 표시 이름은 언제든지 변경할 수 있기 때문에 표시 이름에서 필드 이름을 안정적으로 예측할 수 없습니다. 관리자(Admin) 메뉴의 필드 옵션으로 이동하여 필드 이름을 보거나 [https://developer.shotgridsoftware.com/python-api/reference.html?%20read#working-with-the-shotgun-schema](https://developer.shotgridsoftware.com/python-api/reference.html?%20read#working-with-the-shotgun-schema)에서 설명한 대로 `schema_read(), schema_field_read(), schema_entity_read() methods`를 사용할 수 있습니다.

## 디자인

1.  큰 스튜디오의 경우 특히 API 격리 레이어(래퍼)를 사용하는 것이 좋습니다. 이렇게 하면 {% include product %} API가 변경되지 않도록 도구가 격리됩니다. 또한 API 자체를 수정할 필요 없이 API 액세스를 제어하고 디버깅을 관리하고 감사를 추적할 수 있다는 것을 의미합니다.
2.  최신 버전의 API를 사용합니다. 최신 버전에는 버그 수정 및 성능 향상이 포함됩니다.
3.  스크립트가 실행되는 위치를 알고 있어야 합니다. {% include product %}에 동일한 정보를 분당 1000번 호출하는 렌더 팜에서 실행되는 스크립트는 사이트 성능에 영향을 줄 수 있습니다. 이와 같은 경우 불필요하게 반복되는 호출을 줄이기 위해 읽기 전용 캐싱 레이어를 구현하는 것이 좋습니다.
4.  스크립트의 이벤트 생성을 해제할 수 있습니다. 이는 나중에 트래킹할 필요가 없는 이벤트를 자주 실행하는 스크립트에 가장 유용합니다. 매우 자주 실행되는 스크립트의 경우 이벤트 로그가 매우 커질 수 있으므로 이 방법을 사용하는 것이 좋습니다.