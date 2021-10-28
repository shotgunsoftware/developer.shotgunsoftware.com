---
layout: default
title: Attempted to communicate without completing encryption handshake
pagename: encryption-handshake-error-message
lang: ja
---

# `[ERROR]` Attempted to communicate without completing encryption handshake

## 使用例:

{% include product %} Desktop のブラウザ統合を起動して実行するときに問題が発生しました。

Shotgun Desktop を起動すると、Web サーバが実行されていることが通知されます。

```
[    INFO] WebSocketServerFactory (TLS) starting on 9000
[    INFO] Starting factory
```

...その後に、エラーが表示されないデバッグ レコードがロードされます。

{% include product %} サイトにログインすると、次のように表示されます。

```
[ INFO] Connection accepted.
```

プロジェクトを右クリックすると、{% include product %} がアクションを取得していることが示され、次のログ出力が表示されます。

```
[    INFO] Connection accepted.
[   ERROR] Attempted to communicate without completing encryption handshake.
[   ERROR] Attempted to communicate without completing encryption handshake.
[    INFO] Connection closed.
[   DEBUG] Reason received for connection loss: [Failure instance: Traceback (failure with no frames): : Connection to the other side was lost in a non-clean fashion: Connection lost.
```

{% include product %} でプロジェクトを開くと、次のログ出力が生成されます。

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

## 修正方法:

プロキシ バイパス リストに `shotgunlocalhost.com` を追加します。

## このエラーの原因の例:

プロキシ設定

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/shotgun-desktop-browser-integration/3574)を参照してください。

