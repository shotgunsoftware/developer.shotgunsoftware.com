---
layout: default
title: Attempted to communicate without completing encryption handshake
pagename: encryption-handshake-error-message
lang: en
---

# `[ERROR]` Attempted to communicate without completing encryption handshake

## Use case:

Having trouble getting the browser integration of {% include product %} Desktop up and running.

Launching Shotgun Desktop tells me the webserver is running:

```
[    INFO] WebSocketServerFactory (TLS) starting on 9000
[    INFO] Starting factory 
```

…followed by loads of debug records which do not show any errors.

When logging into the {% include product %} site, I get:

```
[ INFO] Connection accepted.
```

Right-clicking on a project tells me that {% include product %} is retrieving actions and gives me the following log output:

```
[    INFO] Connection accepted.
[   ERROR] Attempted to communicate without completing encryption handshake.
[   ERROR] Attempted to communicate without completing encryption handshake.
[    INFO] Connection closed.
[   DEBUG] Reason received for connection loss: [Failure instance: Traceback (failure with no frames): : Connection to the other side was lost in a non-clean fashion: Connection lost.
```

Opening a project in shotgun produces the following log output:

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

## How to fix:
Add `shotgunlocalhost.com` to the proxy bypass list. 

## Example of what's causing this error: 
Proxy configuration.

[See the full thread in the community](https://community.shotgridsoftware.com/t/shotgun-desktop-browser-integration/3574).

