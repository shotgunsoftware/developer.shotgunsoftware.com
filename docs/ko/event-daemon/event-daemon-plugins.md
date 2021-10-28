---
layout: default
title: 플러그인
pagename: event-daemon-plugins
lang: ko
---

# 플러그인 개요

플러그인 파일은 구성 파일에 지정된 플러그인 경로의 *.py* 파일입니다.

코드 다운로드 시 `src/examplePlugins` 폴더에 몇 가지 예시 플러그인이 제공됩니다. 이러한 플러그인은 생성된 특정 이벤트를 찾기 위해 자체 플러그인을 빌드하고 해당 이벤트에 작동하여 {% include product %} 인스턴스에서 다른 값을 변경하는 방법에 대한 간단한 예제를 제공합니다.

플러그인을 업데이트할 때마다 데몬을 다시 시작할 필요가 없으며 데몬이 플러그인이 업데이트되었음을 감지하고 자동으로 다시 로드합니다.

플러그인에서 오류가 발생할 경우 데몬이 충돌하지 않습니다. 플러그인은 다시 업데이트(수정)될 때까지 비활성화됩니다. 다른 모든 플러그인은 계속 실행되고, 이벤트는 계속 처리됩니다. 데몬은 오류가 발생한 플러그인이 성공적으로 처리된 마지막 이벤트 ID를 계속해서 트래킹합니다. 플러그인이 업데이트(수정)되면 데몬이 이를 다시 로드하고 해당 플러그인이 중단된 위치부터 이벤트를 처리하려고 시도합니다. 다시 모든 것이 정상이라고 가정하면 데몬은 현재 이벤트까지 플러그인을 포착한 다음 정상적으로 모든 플러그인을 사용하여 이벤트를 계속 처리합니다.

{% include product %} 이벤트 처리 플러그인에는 두 가지 주요 부분이 있습니다. 콜백 등록 함수와 콜백 수입니다.

<a id="registerCallbacks_function"></a>
## registerCallbacks 함수

프레임워크에서 로드하려면 플러그인이 최소한 다음 함수를 구현해야 합니다.

```python
def registerCallbacks(reg):
    pass
```

이 함수는 이벤트 처리 시스템에 이벤트를 처리하기 위해 호출할 함수를 전달하는 데 사용됩니다.

이 함수는 [`Registrar`](./event-daemon-api.md#Registrar) 객체인 하나의 인수를 사용해야 합니다.

[`Registrar`](./event-daemon-api.md#Registrar)는 아주 중요한 한 가지 메서드를 사용합니다([`Registrar.registerCallback`](./event-daemon-api.md#registercallback)).

{% include product %} 이벤트를 처리해야 하는 각 함수에 대해 [`Registrar.registerCallback`](./event-daemon-api.md#registerCallback)을 적절한 인수와 함께 한 번 호출합니다.

원하는 수만큼 함수를 등록할 수 있으며, 파일의 모든 함수를 이벤트 처리 콜백으로 등록해야 하는 것은 아닙니다.

<a id="Callbacks"></a>
## 콜백

시스템에 등록할 콜백은 다음 4개의 인수를 사용해야 합니다.

- 추가 정보를 위해 {% include product %}를 쿼리해야 하는 경우 {% include product %} 연결 인스턴스
- 보고에 사용해야 하는 Python Logger 객체. 오류 및 중요 메시지는 구성된 모든 사용자에게 이메일을 통해 전송됩니다.
- 처리할 {% include product %} 이벤트
- 콜백 등록 시 전달되는 `args` 값. (참조 항목: [`Registrar.registerCallback`](./event-daemon-api.md#wiki-registerCallback))

{% include info title="경고" content="플러그인에서 원하는 모든 작업을 수행할 수 있지만 예외가 프레임워크에 다시 발생하면 디스크의 파일이 변경될 때까지(읽기: 수정) 잘못된 콜백(및 포함된 모든 콜백)이 있는 플러그인이 비활성화됩니다." %}

<a id="Logging"></a>
## 로깅

이벤트 플러그인에서 print 문을 사용하는 것은 권장되지 않습니다. Python 표준 라이브러리에서 표준 로깅 모듈을 사용하는 것이 좋습니다. 로거 객체는 다양한 함수로 제공됩니다.

```python
def registerCallbacks(reg):
    reg.setEmails('root@domain.com', 'tech@domain.com') # Optional
    reg.logger.info('Info')
    reg.logger.error('Error') # ERROR and above will be sent via email in default config
```

및

```python
def exampleCallback(sg, logger, event, args):
    logger.info('Info message')
```

이벤트 프레임워크가 데몬으로 실행 중인 경우 이 프레임워크가 파일에 로깅되며, 그렇지 않으면 stdout에 로깅됩니다.

<a id="Robust"></a>
## 강력한 플러그인 빌드

데몬은 {% include product %}에 대해 쿼리를 실행하지만 실패할 경우 find() 명령을 재시도하는 기본 기능이 포함되어 있어 데몬 자체에 특정한 수준의 안전성을 제공합니다.

[https://github.com/shotgunsoftware/shotgunEvents/blob/master/src/shotgunEventDaemon.py#L456](https://github.com/shotgunsoftware/shotgunEvents/blob/master/src/shotgunEventDaemon.py#L456)

플러그인에 네트워크 리소스(즉, {% include product %} 또는 다른 리소스)가 필요한 경우 자체 재시도 메커니즘/안전성을 제공해야 합니다. {% include product %} 액세스의 경우 데몬의 항목을 제거하고 해당 기능을 플러그인에 제공할 수 있는 도우미 함수 또는 클래스를 만들 수 있습니다.

{% include product %} Python API가 이미 네트워크 문제에 대해 어느 정도 재시도하지만 몇 분 동안 실행할 수 있는 {% include product %} 유지보수 기간에 도달하거나 네트워크 문제가 발생하면 충분하지 않을 수 있습니다.

[https://github.com/shotgunsoftware/python-api/blob/master/shotgun_api3/shotgun.py#L1554](https://github.com/shotgunsoftware/python-api/blob/master/shotgun_api3/shotgun.py#L1554)

플러그인이 수행하는 작업에 따라 이벤트를 처리하는 동안 문제가 발생하는 경우 트래킹을 계속하도록 플러그인을 등록할 수도 있습니다. registerCallback 함수의 stopOnError 인수를 확인합니다.

[https://github.com/shotgunsoftware/shotgunEvents/wiki/API#wiki-registerCallback](https://github.com/shotgunsoftware/shotgunEvents/wiki/API#wiki-registerCallback)

{% include info title="참고" content="플러그인이 중지되지 않지만 실패한 시도는 재시도하지 않습니다." %}
