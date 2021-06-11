---
layout: default
title: API
pagename: event-daemon-api
lang: ko
---

# API

<a id="registerCallbacks"></a>
## registerCallbacks

프레임워크에 플러그인의 이벤트 처리 진입점에 대해 알리는 데 사용되는 모든 플러그인의 전역 수준 함수입니다.

**registerCallbacks(reg)**

* reg: [`Registrar`](#Registrar)과 상호 작용하여 프레임워크에 호출할 함수를 알립니다.


<a id="Registrar"></a>
## Registrar

Registrar은 프레임워크에 플러그인과 상호 작용하는 방법을 알리는 데 사용되는 객체이며 [`registerCallbacks`](#registerCallbacks) 함수로 전달됩니다.

### 속성

<a id="logger"></a>
**logger**

[`getLogger`](#getLogger)를 참조하십시오.

### 메서드

<a id="getLogger"></a>
**getLogger**

플러그인 내에서 메시지를 기록하는 데 사용되는 python Logger 객체를 가져옵니다.



__setEmails(*emails)__

이 플러그인 또는 해당 콜백 중 하나에서 잘못된 상황이 발생하는 경우 오류 및 중요한 알림을 수신해야 하는 이메일을 설정합니다.

구성 파일에 지정된 기본 주소로 이메일을 보내려면(기본값)

```python
reg.setEmails(True)
```

이메일을 비활성화하려면(오류 메시지를 받아볼 수 없게 되므로 이 방법은 권장되지 않음)

```python
reg.setEmails(False)
```

특정 주소로 이메일을 보내려면

```python
reg.setEmails('user1@domain.com')
```

또는

```python
reg.setEmails('user1@domain.com', 'user2@domain.com')
```

<a id="registerCallback"></a>
**registerCallback(sgScriptName, sgScriptKey, callback, matchEvents=None, args=None, stopOnError=True)**

이 플러그인에 대해 엔진에 콜백을 등록합니다.

* `sgScriptName`: {% include product %} 스크립트 페이지에서 가져온 스크립트의 이름입니다.
* `sgScriptKey`: {% include product %} 스크립트 페이지에서 가져온 스크립트의 응용프로그램 키입니다.
* `callback`: `__call__` 메서드가 있는 함수 또는 객체입니다. [`exampleCallback`](#exampleCallback)을 참조하십시오.
* `matchEvents`: 콜백에 전달하려는 이벤트 필터입니다.
* `args`: 프레임워크가 콜백으로 다시 전달되게 하려는 모든 객체입니다.
* `stopOnError`: 부울이며 이 콜백의 예외가 이 플러그인의 모든 콜백에 의한 이벤트 처리를 중단해야 합니다. 기본값은 `True`입니다.

`sgScriptName`은 {% include product %}에 대한 플러그인을 식별하는 데 사용됩니다. 모든 이름은 여러 콜백에서 공유되거나, 단일 콜백에 대해 고유할 수 있습니다.

`sgScriptKey`는 {% include product %}에 대한 플러그인을 식별하는 데 사용되며 지정된 `sgScriptName`에 적합한 키여야 합니다.

필터와 일치하는 이벤트를 처리해야 하는 경우 지정된 콜백 객체가 호출됩니다. 호출 가능한 모든 객체를 실행할 수 있어야 하지만 여기에 클래스를 사용하는 것은 적합하지 않습니다. 함수 또는 `__call__` 메서드가 있는 인스턴스를 사용하는 것이 더 적합합니다.

`matchEvent` 인수는 등록 중인 콜백의 관심 이벤트를 지정할 수 있는 필터입니다. `matchEvents`가 지정되지 않았거나 None을 지정하면 모든 이벤트가 콜백으로 전달됩니다. 그렇지 않으면 `matchEvents` 필터의 각 키는 이벤트 유형이고 각 값은 가능한 속성 이름 목록입니다.

```python
matchEvents = {
    'Shotgun_Task_Change': ['sg_status_list'],
}
```

여러 이벤트 유형 또는 속성 이름이 있을 수 있습니다.

```python
matchEvents = {
    'Shotgun_Task_Change': ['sg_status_list'],
    'Shotgun_Version_Change': ['description', 'sg_status_list']
}
```

지정된 속성 이름이 있는 이벤트 유형을 필터링할 수 있습니다.

```python
matchEvents = {
    '*': ['sg_status_list'],
}
```

또한 지정된 이벤트 유형의 속성 이름을 필터링할 수도 있습니다.

```python
matchEvents = {
    'Shotgun_Version_Change': ['*']
}
```

다음은 유효하며 아무것도 지정하지 않는 것과 같은 기능을 하지만 실제로는 쓸모가 없습니다.

```python
matchEvents = {
    '*': ['*']
}
```

“_New” 또는 “_Retirement” 등 필드용이 아닌 특정 이벤트 유형에 대해 일치시키는 경우 목록을 제공하지 않고 대신 `None`을 값으로 전달합니다.

```python
matchEvents = {
    'Shotgun_Version_New': None
}
```

`args` 인수는 이벤트 프레임워크 자체에서 사용되지 않지만 수정 없이 콜백으로 다시 전달됩니다.

{% include info title="참고" content="`args` 인수의 요점은 [`registerCallbacks`](#registerCallbacks) 함수에서 시간이 많이 걸리는 작업을 처리할 수 있고 이벤트 처리 시 사용자에게 다시 전달할 수 있다는 것입니다." %}

`args` 인수의 또 다른 용도는 데이터를 공유하도록 여러 콜백에 대한 변경 가능한 공통 인수로 전달하는 것입니다(예: `dict`).

`stopOnError` 인수는 이 콜백의 예외가 플러그인 내 모든 콜백에 대한 이벤트 처리가 중지될 수 있는지 여부를 시스템에 알려 줍니다. 기본적으로 이 값은 `True`이지만 `False`로 전환할 수 있습니다. 오류가 있는 경우 오류에 대한 메일 알림이 계속 표시되지만 이벤트 처리는 중지되지 않습니다. 콜백당 설정이므로 `True`인 중요한 콜백을 사용할 수 있지만 `False`인 다른 콜백을 사용할 수 있습니다.

<a id="Callback"></a>
## 콜백

[`Registrar.registerCallback`](#registerCallback)에 의해 등록된 모든 플러그인 진입점은 일반적으로 다음과 같은 전역 수준 함수입니다.

<a id="exampleCallback"></a>
**exampleCallback(sg, logger, event, args)**

* `sg`: {% include product %} 연결 인스턴스
* `logger`: 사용자를 위해 미리 구성된 Python logging.Logger 객체
* `event`: 처리할 {% include product %} 이벤트
* `args`: 콜백 등록 시간에 지정된 args 인수

{% include info title="참고" content="콜백을 객체 인스턴스에 대한 `__call__` 메서드로 구현할 수 있지만 사용자를 위한 연습으로 남겨둡니다." %}
