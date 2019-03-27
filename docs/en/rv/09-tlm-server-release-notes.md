---
layout: default
title: TLM Server 2.6.1 Release Notes
permalink: /rv/09-tlm-server-release-notes/
lang: en
---

# TLM Server 2.6.1 Release Notes

[© Tweak Software](http://tweaksoftware.com/)

## CAVEATS

* Although Tweak tests and releases builds of `tlm_server` for all three platforms, the Linux and OS X versions are more mature and most fully tested. If possible we recommend using a Linux or OS X box as a license server, even when serving licenses to Windows clients.

## Version 2.6.1 (May 12, 2014)

**NEW**

* Increase open files resource limit.

**FIXED**

* Work-around 1024 file descriptor select() limit on linux.

## Version 2.6.0 (February 14, 2013)

**NEW**

* Support applications version 4.0 and greater.

* Improved logging of accepted license requests.

* Windows Client/Server connections use TCP/IP “keep-alive” to ensure that a client machine that crashes or otherwise goes off the network will not continue to consume a license.

**FIXED**

* A rare case involving older license types could result in a single user consuming two RV licenses on a single machine.

## Version 2.5.3 (February 7, 2011)

**NEW**

* Client/Server connections use TCP/IP “keep-alive” to ensure that a client machine that crashes or otherwise goes off the network will not continue to consume a license (Mac OS X).

## Version 2.5.2 (January 6, 2011)

**FIXED**

* Target older linux dist, to avoid runtime linking problems.

## Version 2.5.1 (November 4, 2010)

**NEW**

*   Client/Server connections use TCP/IP “keep-alive” to ensure that a client machine that crashes or otherwise goes off the network will not continue to consume a license (this change is **linux only**).

## Version 2.4 (February 28, 2010)

**NEW**

* Status report includes server version information.

* Yet more information in logs.

* On windows, when started without `-fg`, the server now disconnects from the controlling console, so you can start it “in the background,” as on Unix.

**FIXED**

* Long status report from remote server no longer truncated.

* Last-ditch default Windows license location: `C:\license.gto`

* Cleaner disconnect from Windows clients.

* In some cases clients would not release licenses when forcefully disconnecting.

* Support for Version 3.0 license files including `requires` and `startDate` fields.

* Print license status on startup.

* License status includes expiration date (if not permanent) and maintenance expiration date.

## Version 2.3 (September 10, 2009)

**NEW**

* First Windows version.

**FIXED**

* Excessive socket resource consumption on server machine

## Version 2.2 (July 20, 2009)

**NEW**

* Version number in log.

* Improved error logging.

**FIXED**

* Certain patterns of license requests to a multi-pool server could cause two licenses to be consumed by the same user.
