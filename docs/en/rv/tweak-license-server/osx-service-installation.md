---
layout: default
title: OS X Service Installation
permalink: /rv/tweak-license-server/osx-service-installation/
lang: en
---

# OS X Service Installation

The OS X installer installs the server binaries into `/Applications/Utilities/tlm_server` and creates a startup item in `/Library/StartupItems.` Before the server can successfully approve license requests from applications, it must find a valid license file in one of these locations:

```
/Applications/Utilities/tlm_server/etc/license.gto
/Library/Application Support/RV/license.gto
/Library/Application Support/TLM/license.gto
/var/tweak/license.gto
```

So during a first install, we advise that you first go through the Recommended Installation Process as described above. To run the command line examples above, use the server executable in `/Applications/Utilities/tlm_server/bin/tlm_server`.

After you’ve confirmed that the server works as expected, install a license file in one of the above locations and restart the server like this:

```
sudo /Library/StartupItems/TLMServer/TLMServer start
```

Once the server is running, `ps` will show you a command line that looks something like this:

```
tlm_server -f /Applications/Utilities/tlm_server/etc/license.gto -log /var/log/tlm_server.log
```

And you can monitor the behavior of the license server in the log file `/var/log/tlm_server.log`.

## Network Timeouts on OS X

If RV exits for any reason, the licenses should be released immediately. If the server looses contact with machine running RV (for example, if network service to that machine is interrupted), the connection will time out and the the license will be released in an amount of time determined by some system-level settings. To check those settings, run the command:

```
% sysctl -A |& grep net.inet.tcpkeep
net.inet.tcp.keepidle: 7200000
net.inet.tcp.keepintvl: 75000
```

The values shown here are typical, and will cause the license to be released in about 130 minutes. This should be fine in many cases, but if you want the license to be released sooner, you can

```
sudo sysctl -w net.inet.tcp.keepidle=60000
sudo sysctl -w net.inet.tcp.keepintvl=60000
```

This will cause the timeout and license release to happen after about 10 minutes. These numbers will be reset at the next system restart. To make them permanent, add these lines to the file `/etc/sysctl.conf`.

```
net.inet.tcp.keepidle=60000
net.inet.tcp.keepintvl=60000
```
