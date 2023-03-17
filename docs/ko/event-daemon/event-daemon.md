---
layout: default
title: 이벤트 구동 트리거 작성
pagename: event-daemon
lang: ko
---

# {% include product %} 이벤트 프레임워크
이 소프트웨어는 [Rodeo Fx](https://rodeofx.com) 및 Oblique의 지원을 받아 [Patrick Boucher](https://www.patrickboucher.com)에서 처음 개발했습니다. 이제 [{% include product %} 소프트웨어](https://www.shotgridsoftware.com) [오픈 소스 이니셔티브](https://github.com/shotgunsoftware)의 일부가 되었습니다.

이 소프트웨어는 라이선스 파일 또는 [오픈 소스 이니셔티브](https://www.opensource.org/licenses/mit-license.php) 웹 사이트에서 찾을 수 있는 MIT 라이선스로 제공됩니다.

**컨텐츠:**

- [개요](#overview)
- [프레임워크의 이점](#advantages-of-the-framework)
- [이벤트 구동 트리거 작성](#writing-event-driven-triggers)
   - [활용 사례](#example-use-cases)
   - [이벤트 구동 트리거의 작동 방식](#how-event-driven-triggers-work)
   - [EventLog 폴링과 트리거 비교](#polling-the-eventlog-versus-triggers)
   - [이벤트 유형](#event-types)
   - [트랜잭션 및 잠재적 누락 이벤트](#transactions-and-potentially-missing-events)

## 개요

{% include product %} 이벤트 스트림에 액세스하려면 이벤트 테이블을 모니터링하고 새로운 이벤트를 파악하여 처리하는 작업을 반복하는 것이 좋습니다.

많은 항목이 성공적으로 작동하려면 이 프로세스를 거쳐야 하며, 비즈니스 규칙과 직접적인 관련이 없는 항목은 적용해야 하는지 여부를 결정해야 합니다.

프레임워크의 역할은 비즈니스 로직 구현자를 대신해 따분한 모니터링 작업을 처리해 주는 것입니다.

이 프레임워크는 서버에서 실행되면서 {% include product %} 이벤트 스트림을 모니터링하는 데몬 프로세스입니다. 이벤트가 발견되면 데몬은 이벤트를 일련의 등록된 플러그인으로 전달합니다. 각각의 플러그인은 원하는 대로 이벤트를 처리할 수 있습니다.

데몬은 다음을 처리합니다.

- 지정된 하나 이상의 경로에서 플러그인 등록
- 충돌하는 플러그인을 모두 비활성화
- 플러그인이 디스크에서 변경된 경우 다시 로드
- {% include product %} 이벤트 스트림 모니터링
- 마지막으로 처리된 이벤트 ID와 백로그 기억
- 데몬 시작 시 마지막으로 처리된 이벤트 ID부터 시작
- 연결 오류 확인
- 필요에 따라 stdout, 파일 또는 이메일에 정보 로깅
- 콜백에서 사용되는 {% include product %}에 대한 연결 설정
- 등록된 콜백으로 이벤트 전달

플러그인은 다음을 처리합니다.

- 콜백의 번호를 프레임워크에 등록
- 프레임워크에서 이벤트를 제공하는 경우 단일 이벤트 처리


## 프레임워크의 이점

- 스크립트당이 아니라 모든 스크립트에 대해 하나의 모니터링 메커니즘만 처리합니다.
- 네트워크 및 데이터베이스 로드를 최소화합니다(단일 모니터만으로 여러 이벤트 처리 플러그인에 이벤트 공급).

# 이벤트 구동 트리거 작성

**참고:** 이벤트 구동 트리거에 대한 자세한 정보는 [https://github.com/shotgunsoftware/shotgunEvents](https://github.com/shotgunsoftware/shotgunEvents)의 설명서를 참조하십시오.

{% include product %} 소프트웨어는 {% include product %}에서 수행된 모든 작업에 대해 [이벤트 로그 항목](https://help.autodesk.com/view/SGSUB/KOR/?guid=SG_Administrator_ar_data_management_ar_event_logs_html)을 작성합니다. 이 이벤트는 {% include product %} 사이트와 {% include product %} API를 통해 확인할 수 있습니다.

{% include product %}에서 이벤트 세부 기록을 확인하는 것뿐 아니라, EventLog를 폴링하고 사용자가 관심을 두고 있는 특정 이벤트에 대해 작동하는 이벤트 리스너 스크립트를 직접 작성할 수도 있습니다. 이 스크립트는 파이프라인 내 다른 내부 스크립트를 실행하거나 {% include product %} API를 사용하여 {% include product %} 내 다른 정보를 업데이트할 수 있으며, 그 둘 모두도 가능합니다.

## 활용 사례

다음은 이벤트 구동 트리거의 몇 가지 활용 사례입니다.

* 샷의 '레이아웃(Layout)' 태스크 상태가 '최종(final)'으로 지정되면 '애니메이션(Animation)' 태스크 상태가 '시작 준비(ready to start)'로 자동 설정되기 때문에 애니메이터가 샷 작업을 시작할 수 있음을 알게 됩니다.
* 새 샷이 {% include product %}에 생성되면 적절한 샷 디렉토리가 파일 시스템에 생성됩니다.
* 샷이 '대기 중(on hold)' 상태가 되면 이 샷에 할당된 아티스트에게 알림이 전달됩니다.
* 자산이 마무리되면 디렉토리가 읽기 전용으로 설정됩니다.
* {% include product %}에서 버전이 리뷰에 추가되면 해당 버전(또는 테이크) 정보를 데일리 시스템에 복사합니다.
* 씬이 25개 샷으로 커지면 씬의 설명 필드에 적힌 세 번째 단어와 같은 글자로 시작하는 문구를 무작위로 트윗합니다.

## 이벤트 구동 트리거의 작동 방식

아래는 {% include product %}에서 생성된 EventLogEntries의 간단한 다이어그램입니다. 스크립트는 API를 사용하여 마지막으로 요청한 이후 발생한 이벤트 목록을 가져옵니다. 그런 다음 각 이벤트 유형(예: {% include product %}_Task_Change)을 살펴보고, 관심을 두고 있는 항목이 있는지 확인합니다.

해당 이벤트를 찾으면 이벤트의 상세 정보(예: 변경된 필드, 변경된 값 등. 이 시점에서 API를 사용하여 필요한 엔티티에 대한 추가 정보를 요청할 수도 있음)를 확인합니다.

이벤트가 유의미한 것으로 증명되면 스크립트가 해당 이벤트에 작동하여 사용자가 실행하도록 결정한 코드({% include product %} API를 사용하거나 파이프라인 내 항목을 사용하거나, 둘 다 사용할 수 있음)를 실행합니다. 살펴볼 이벤트가 더 이상 없으면 프로세스를 반복하면서 API를 사용하여 마지막으로 요청한 이후 발생한 이벤트 목록을 가져옵니다.

![이벤트 로그 폴링](/images/dv-writing-event-triggers-event-log-polling-01.png)

## EventLog 폴링과 트리거 비교

{% include product %} 소프트웨어는 지속적인 이벤트 정보 스트림을 제공하며, 사용자는 이를 모두 수신하다가 원하는 이벤트에만 반응하면 됩니다. 이렇게 하면 {% include product %} 소프트웨어가 트리거를 직접 제어하도록 하는 것과 비교해 다음과 같은 이점이 있습니다.

* **유연성**: 사용자의 트리거 스크립트가 {% include product %} 소프트웨어와 무관하게 실행될 수 있습니다. 덕분에 스크립트가 {% include product %} 및 사용자 파이프라인 모두와 원하는 방식으로 상호 작용할 수 있습니다. 사용자는 어떠한 제약도 없이 원하는 대로 규칙 및 액션을 정의할 수 있습니다. {% include product %} 소프트웨어는 사용자의 이벤트 트리거에 관해 아무것도 알 필요가 없습니다. 수행할 일이라고는 EventLogEntries를 지속적으로 생성하는 것뿐입니다. 그 뒤에 일어나는 다른 모든 일들은 사용자가 제어합니다.
* **원격**: 사용자 스크립트가 네트워크를 통해 {% include product %} 서버에 액세스할 수 있는 모든 위치에서 실행될 수 있습니다. 스크립트 실행에 필요한 것은 API 액세스뿐입니다.
* **다중성**: 여러 스크립트를 동시에 실행할 수 있습니다. 각 부서마다 요구 사항이 서로 다르기 때문에 서로 다른 이벤트를 수신하는 경우가 있을 수 있습니다. 이런 경우에도 동일한 스크립트를 통해 모든 트리거를 실행하는 데 아무런 제약이 없습니다. 트리거를 개별적인 여러 논리 스크립트로 분할할 수도 있습니다. 폴링 쿼리는 매우 가볍기 때문에 성능에 별다른 영향을 미치지 않습니다.
* **책임성**: 스크립트가 {% include product %}에 어떤 변화를 가져오면 자체 이벤트도 생성하기 때문에 스크립트가 어떤 변화를 일으켰는지 정확하게 확인할 수 있습니다.

## 이벤트 유형

모든 내부 이벤트 유형은 **`Shotgun_[entity_type]_[New|Change|Retirement]`** 형식을 따릅니다. 예를 들어 `Shotgun_Shot_New` 및 `Shotgun_Asset_Change`가 있습니다. 자세한 정보는 [이벤트 유형 설명서](https://github.com/shotgunsoftware/shotgunEvents/wiki/Technical_Overview#event-types)를 참조하십시오.

## 트랜잭션 및 잠재적 누락 이벤트

{% include product %} 소프트웨어는 트랜잭션에서 파괴적(destructive) 데이터베이스 쿼리를 실행하고, 트랜잭션이 완료된 경우에만 EventLog를 작성합니다. 이 때문에 여기에서 "highest ID" 방식을 사용하는 이벤트를 놓칠 수도 있습니다. 하지만 [GitHub 사이트의 이벤트 트리거 프레임워크](https://github.com/shotgunsoftware/shotgunEvents)에 이 상황을 처리해 줄 코드가 있습니다.