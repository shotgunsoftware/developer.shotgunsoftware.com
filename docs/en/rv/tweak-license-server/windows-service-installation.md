---
layout: default
title: Windows Service Installation
permalink: /rv/tweak-license-server/windows-service-installation/
lang: en
---

# Windows Service Installation

After you’ve installed the the server and confirmed that it works as you expect, you probably want to make a Windows Service from the `tlm_server` executable.

On all versions of windows, we recommend Ian Patterson’s “Non-Sucking Service Manager”, available [here](http://iain.cx/src/nssm/).

Here are the steps (as Administrator):

1. Unpack tlm_server zip somewhere (`c:\Program Files (x86)\tlm_server-win32-x86-2.6.0` in what follows)

2. Download and install NSSM somewhere (`c:\nssm-2-5` in what follows)

3. Create the service:

```
c:\nssm-2.5\win64\nssm.exe install TLM "c:\Program Files (x86)\tlm_server-win32-x86-2.6.0\bin\tlm_server.exe"
"-log \"c:\Program Files (x86)\tlm_server-win32-x86-2.6.0\tlm_server.log\" -f \"c:\Program Files (x86)\tlm_server-win32-x86-2.6.0\etc\license.gto\""
```

You should see “Service TLM installed successfully!”. **Please Note:**

* The entire command above must be typed on a **single line**.
* You need those **double quotes** and you need the **escaped double quotes** too if your paths have spaces in them.
* Don’t forget to swap in the path to your actual **log file** and **license file**.
* The argument to the `-log` option above is a **file**, not a **directory**. It will be created if it does not exist.

4. Now you can start the service explicitly with the windows adminstrative tool “Services”, or just reboot.

If anything goes wrong and you need to uninstall the service, you can:

1. Stop the service with the windows admin tools “Services”.
2. Remove the service with NSSM:

```
c:\nssm-2.5\win64\nssm.exe remove TLM confirm
```

## Network Timeouts on Windows

If RV exits for any reason, the licenses should be released immediately. If the server looses contact with machine running RV (for example, if network service to that machine is interrupted), the connection will time out and the the license will be released in 2-3 minutes.
