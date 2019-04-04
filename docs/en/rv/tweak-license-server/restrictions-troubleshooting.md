---
layout: default
title: Restrictions/Troubleshooting
permalink: /rv/tweak-license-server/restrictions-troubleshooting/
lang: en
---

# Restrictions/Troubleshooting

There are a few restrictions which will prevent the server from running, or from serving a particular license:

* The server will not accept a license whose host ID (MAC address) does not match any available host IDs on the server machine. Starting `tlm_server` in the foreground, with the `-fg` flag, will report errors related to the license file and enumerate valid host IDs.

```
shel>> tlm_server -f bad.gto -fg
LICENSE FAILURE: 00:11:22:33:44:55 not found on this machine
HOSTID #0 = 00:E0:81:57:3F:58
HOSTID #1 = 00:E0:81:57:3F:59
HOSTID #2 = 00:50:56:C0:00:08
HOSTID #3 = 00:50:56:C0:00:01
LICENSE FAILURE: Ignoring modified license 4be52c90ee74321999ca981db5affc5d7ed3d083
ERROR: license file contained no useful licenses or servers
Error reading bad.gto...
```

The server installation contains a program, `tlm_hostid`, that will list valid host IDs.

* Sometimes the license file has been corrupted by email or some other process. We usually send licenses as text files, since many facilities have email filters set up to reject zip files. If the file is corrupted (meaning extra characters are inserted into it) then you will get an error stating that this is “Not a Valid GTO file.” If you have this problem, you can request a new license and we will send you a zipped version.

* The name of the binary must be “tlm_server” (“tlm_server.exe” on Windows). Renamed binaries will not function.

* You can only run one copy of `tlm_server` on a given machine.

* `tlm_server` does not accept version 1 license files. The version is indicated by a number at the end of the license object. These licenses **will** work when used with the client as a node-locked licenses. `tlm_server` v2.4 accepts version 2 and 3 licenses.

```
        GTOa (3)

        832b961633628232d4ef8d3060a1c10693af08af : license (1) # <--- (1) is the version
        {
         .
         .
         .
        }
```

* tlm_server will run in parallel with an older version of the license server (tweakLicenseServer) as long as they are using different ports.

Once a server is running and hosting at least one valid license, if you have trouble trouble acquiring licenses, check the server log output. The server will give a reason in the log output for each rejected license request. Note that a correctly set up license server will still have many `REJECTED` notes in the log, since Tweak apps will try to acquire the “least desirable” (least expensive) license types first.

Reasons for rejecting a license request that you may see in the log include:

| | |
|-|-|
| **Package Name Mis-Match** | The most common reason, since Tweak software asks for several packages in hopes of consuming the least desirable licenses first. |
| **Version Mis-Match** | This request is for a version of the package that this license does not support. |
| **Maintenance Expired** | The compile date of the package requesting a license exceeds the maintenance expiration date of the license (this date is labeled updatesUntil in the license file). |
| **Start Date Not Reached** | Licenses may have a `startDate` field which prevents their use until that date is reached. |
| **License Count Exceeded** | Granting this license request would push the number of concurrent users above the allowed limit for this license (this is the `count` field in the license file).<br/><br/>If you want to take the license manager completely out of the equation, and use a given license directly from RV or RVIO, you can install licenses manually by naming them correctly, and placing them in the right directory. |
| **Manual License setup** | You can install licenses manually on all operating systems. Rename the license file to “license.gto” and the place in the correct directory. On Linux and Windows, there is a directory named etc that can be found under the main RV directory (wherever RV is installed). You can copy the license.gto file into that directory. On the Mac, the license file is stored in the directory: /Library/Application Support/RV |
