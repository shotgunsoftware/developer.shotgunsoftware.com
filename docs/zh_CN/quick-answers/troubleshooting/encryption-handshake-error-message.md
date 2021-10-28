---
layout: default
title: 尝试在未完成加密握手的情况下进行通信
pagename: encryption-handshake-error-message
lang: zh_CN
---

# `[ERROR]` 尝试在未完成加密握手的情况下进行通信

## 用例：

无法启动和运行 {% include product %} Desktop 的浏览器集成。

启动 Shotgun Desktop 会指示 Web 服务器正在运行：

```
[    INFO] WebSocketServerFactory (TLS) starting on 9000
[    INFO] Starting factory
```

...后跟大量没有显示任何错误的调试记录。

登录 {% include product %} 站点时，会出现：

```
[ INFO] Connection accepted.
```

在项目上单击鼠标右键会指示 {% include product %} 正在检索动作，并提供以下日志输出：

```
[    INFO] Connection accepted.
[   ERROR] Attempted to communicate without completing encryption handshake.
[   ERROR] Attempted to communicate without completing encryption handshake.
[    INFO] Connection closed.
[   DEBUG] Reason received for connection loss: [Failure instance: Traceback (failure with no frames): : Connection to the other side was lost in a non-clean fashion: Connection lost.
```

在 {% include product %} 中打开项目会生成以下日志输出：

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

## 如何修复：

将 `shotgunlocalhost.com` 添加到代理绕过列表。

## 导致此错误的原因示例：

代理配置。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/shotgun-desktop-browser-integration/3574)。

