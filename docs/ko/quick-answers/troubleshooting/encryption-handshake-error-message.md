---
layout: default
title: 암호화 핸드쉐이크를 완료하지 않고 통신을 시도함
pagename: encryption-handshake-error-message
lang: ko
---

# `[ERROR]` 암호화 핸드쉐이크를 완료하지 않고 통신을 시도함

## 활용 사례:

{% include product %} 데스크톱의 브라우저 통합을 시작하고 실행하는 데 문제가 있습니다.

Shotgun 데스크톱을 시작하면 웹 서버가 실행 중임을 알 수 있습니다.

```
[    INFO] WebSocketServerFactory (TLS) starting on 9000
[    INFO] Starting factory
```

...그 다음에는 오류를 표시하지 않는 디버그 레코드가 로드됩니다.

{% include product %} 사이트에 로그인할 때 다음과 같은 메시지가 표시됩니다.

```
[ INFO] Connection accepted.
```

프로젝트를 마우스 오른쪽 버튼으로 클릭하면 {% include product %}에서 작업을 검색 중이라고 표시되고 다음과 같은 로그 출력이 제공됩니다.

```
[    INFO] Connection accepted.
[   ERROR] Attempted to communicate without completing encryption handshake.
[   ERROR] Attempted to communicate without completing encryption handshake.
[    INFO] Connection closed.
[   DEBUG] Reason received for connection loss: [Failure instance: Traceback (failure with no frames): : Connection to the other side was lost in a non-clean fashion: Connection lost.
```

{% include product %}에서 프로젝트를 열면 다음과 같은 로그 출력이 생성됩니다.

```
[    INFO] Connection accepted.
[   ERROR] Attempted to communicate without completing encryption handshake.
[   ERROR] Attempted to communicate without completing encryption handshake.
[   ERROR] Attempted to communicate without completing encryption handshake.
[   ERROR] Attempted to communicate without completing encryption handshake.
[ WARNING] dropping connection to peer tcp4:127.0.0.1:52451 with abort=True: WebSocket closing handshake timeout (peer did not finish the opening handshake in time)
[    INFO] Connection closed.
[   DEBUG] Reason received for connection loss: [Failure instance: Traceback (failure with no frames): : Connection to the other side was lost in a non-clean fashion: Connection lost.
```

## 해결 방법:

프록시 무시 목록에 `shotgunlocalhost.com`을 추가합니다.

## 이 오류가 발생하는 원인의 예:

프록시 구성

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/shotgun-desktop-browser-integration/3574)하십시오.

