---
layout: default
title: 기술적 상세 정보
pagename: event-daemon-technical-details
lang: ko
---

# 기술 개요

<a id="Event_Types"></a>

## 이벤트 유형

알림을 받을 수 있게 트리거를 등록할 수 있는 이벤트 유형은 일반적으로 다음 양식을 따릅니다. `Shotgun_[entity_type]_[New|Change|Retirement|Revival]`. 다음은 이 패턴의 몇 가지 예입니다.

    Shotgun_Note_New
    Shotgun_Shot_New
    Shotgun_Task_Change
    Shotgun_CustomEntity06_Change
    Shotgun_Playlist_Retirement
    Shotgun_Playlist_Revival

이 패턴의 일부는 엔티티 레코드 활동과 관련되지 않고 응용프로그램 동작의 요점과 관련된 이벤트에 사용됩니다.

    CRS_PlaylistShare_Create
    CRS_PlaylistShare_Revoke
    SG_RV_Session_Validate_Success
    Shotgun_Attachment_View
    Shotgun_Big_Query
    Shotgun_NotesApp_Summary_Email
    Shotgun_User_FailedLogin
    Shotgun_User_Login
    Shotgun_User_Logout
    Toolkit_App_Startup
    Toolkit_Desktop_ProjectLaunch
    Toolkit_Desktop_AppLaunch
    Toolkit_Folders_Create
    Toolkit_Folders_Delete

이 목록은 완벽하지는 않지만 시작하기에 적합합니다. {% include product %} 사이트의 활동 및 이벤트 유형에 대해 자세히 알아보려면 다른 엔티티 유형의 다른 그리드 페이지를 통해 필터링하고 검색할 수 있는 EventLogEntries 페이지를 참조하십시오.

### 썸네일의 이벤트 로그 항목

엔티티에 대한 새 썸네일이 업로드되면 `` `Type` == `Shotgun_<Entity_Type>_Change` ``인 이벤트 로그 항목이 생성됩니다(예: `Shotgun_Shot_Change`).

1. `‘is_transient’` 필드 값은 true로 설정됩니다.

```
{ "type": "attribute_change","attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11656,
 "is_transient": true
}
```

2. 썸네일을 사용할 수 있게 되면 이제 `‘is_transient’` 필드 값을 false로 설정하여 새 이벤트 로그 항목이 생성됩니다.

```
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11656,
 "is_transient": false
}
```

3. 썸네일을 다시 업데이트하면 다음 새 이벤트 로그 항목이 표시됩니다.

```
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": 11656, "new_value": 11657,
 "is_transient": true
}
{ "type": "attribute_change", "attribute_name": "image",
 "entity_type": "Shot", "entity_id": 1286, "field_data_type": "image",
 "old_value": null, "new_value": 11657,
 "is_transient": false
}
```

4. 첨부 파일의 썸네일이 자리 표시자 썸네일인 경우 `‘old_value’` 필드는 null로 설정됩니다.

<a id="Plugin_Processing_Order"></a>

## 플러그인 처리 순서

각 이벤트는 항상 동일한 예측 가능한 순서로 처리되므로 플러그인이나 콜백이 상호 종속적인 경우 처리를 안전하게 구성할 수 있습니다.

구성 파일은 하나 이상의 플러그인 위치를 포함하는 `paths` 구성을 지정합니다. 목록의 위치가 앞쪽일수록 포함된 플러그인이 더 빨리 처리됩니다.

플러그인 경로 내의 각 플러그인은 알파벳 오름차순으로 처리됩니다.

{% include info title="참고" content="내부적으로 파일 이름은 목록에 추가되고 정렬됩니다." %}

마지막으로, 플러그인에 의해 등록된 각 콜백이 등록 순서대로 호출됩니다. 첫 번째 등록된 콜백이 첫 번째로 실행됩니다.

하나 이상의 콜백과 같은 플러그인에서 상태를 공유해야 하는 기능을 유지하는 것이 좋습니다.

<a id="Sharing_State"></a>

## 상태 공유

여러 콜백에 대해 상태를 공유해야 하는 여러 옵션이 있습니다.

- 전역 변수. Ick. 이 작업을 수행하지 마십시오.
- 상태 정보가 들어 있는 가져온 모듈. Ick, 단순한 전역보다는 낫습니다.
- `args`[`Registrar.registerCallback`API#wiki-registerCallback](을 호출할 때 ) 인수로 전달된 변경 가능한 것. 설계의 상태 객체 또는 `dict`처럼 간단한 것. 선호.
- 객체 인스턴스에 대해 `__call__`과 같은 콜백을 구현하고 콜백 객체 초기화 시 일부 공유 상태 객체를 제공합니다. 가장 강력하면서도 가장 어려운 방법입니다. 위의 args 인수 방법에 비해 중복될 수 있습니다.

<a id="Event_Backlogs"></a>

## 이벤트 백로그

이 프레임워크는 모든 플러그인이 관심 있는 모든 단일 이벤트를 예외 없이 정확히 한 번만 처리하도록 설계되었습니다. 이를 위해, 프레임워크는 각 플러그인에 대해 처리되지 않은 이벤트의 백로그를 저장하고 각 플러그인이 제공된 마지막 이벤트를 기억합니다. 다음은 백로그가 발생할 수 있는 상황에 대한 설명입니다.

### 이벤트 로그 항목 시퀀스의 간격으로 인한 백로그

{% include product %}에서 발생하는 각 이벤트(필드 업데이트, 엔티티 생성, 엔티티 삭제 등)는 해당 이벤트 로그 항목에 대한 고유 ID 번호가 있습니다. 경우에 따라 ID 번호 시퀀스에 간격이 있을 수 있습니다. 이러한 간격은 여러 가지 이유로 발생할 수 있지만 그중 하나는 아직 완료되지 않은 대규모 데이터베이스 트랜잭션입니다.

이벤트 로그 시퀀스에 간격이 생길 때마다 이후 처리를 위해 "누락된" 이벤트 ID가 백로그에 입력됩니다. 이렇게 하면 이벤트 데몬이 긴 데이터베이스 트랜잭션이 완료된 후 이 트랜잭션의 이벤트를 처리할 수 있습니다.

실패한 트랜잭션 또는 되돌린 페이지 설정 수정과 같이 이벤트 로그 시퀀스의 간격을 채울 수 없는 경우도 있습니다. 이 경우 5분 시간 제한 후 시스템이 이벤트 로그 항목 ID 번호를 더 이상 기다리지 않고 백로그에서 제거합니다. 이렇게 되면 "백로그 이벤트 ID #에서 시간 제한이 경과됨"이라는 메시지가 표시됩니다. 이벤트 시퀀스의 간격이 처음 표시되고 이미 시간 제한을 초과한 것으로 간주되면 메시지가 “이벤트 # 발생하지 않음 - 무시 중”으로 표시되고 첫 번째 위치의 백로그에 입력되지 않습니다.

### 플러그인 오류로 인한 백로그

정상적으로 작동하는 동안 프레임워크는 항상 각 플러그인에서 처리된 마지막 이벤트를 트래킹합니다. 어떤 이유로든 실패한 플러그인이 있는 경우 추가 이벤트 처리를 중지합니다. 예를 들어 버그를 수정함으로써 플러그인을 수정하면, 마지막으로 저장된 이벤트에서 수정된 플러그인에 대한 이벤트 처리가 시작됩니다. 이 작업은 새로 수정된 플러그인이 과거에 실패와 수정 사이에 발생한 이벤트를 포함하여 모든 이벤트를 처리하도록 하기 위해 수행됩니다. 오래 전에 오류가 발생했다면 많은 이벤트를 재검토해야 할 수 있으며, 수정된 플러그인이 정상적으로 작동하던 다른 플러그인을 따라잡는 데 시간이 걸릴 수 있습니다.

수정된 플러그인이 따라잡는 동안 다른 플러그인은 동일한 플러그인에 의해 단일 이벤트가 두 번 처리되지 않도록 하기 위해 이러한 이벤트를 무시합니다. 이렇게 되면 "이벤트 X가 너무 오래되었습니다. 마지막으로 처리된 이벤트는 (Y)입니다."라는 메시지가 나타납니다. 이 메시지는 디버그 메시지이며 무시해도 됩니다.

이를 회피할 수 있는 공식적인 방법은 없습니다. 이 프레임워크는 모든 단일 플러그인이 모든 이벤트를 한 번만 처리하도록 설계되었습니다. 그러나 Python과 그 pickle 데이터 형식에 익숙하다면 데몬을 중지하고 Python 인터프리터/대화식 셸로 .id 파일을 열고 해당 내용을 pickle 모듈로 디코딩하고 해당 내용을 편집하여 저장된 ID를 제거하면 누적 백로그를 건너뛸 수 있습니다. 이 방법은 지원되지 않으며 사용자 자신의 책임하에 수행해야 합니다. 이 작업을 수행하기 전에 `.id` 파일을 적절하게 백업하십시오.
