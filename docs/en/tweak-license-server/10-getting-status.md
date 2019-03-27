---
layout: default
title: Getting Status
permalink: /rv/tweak-license-server/10-getting-status/
lang: en
---

# Getting Status

You can get the status of a running license server on an remote machine (or the local machine) by running another copy of `tlm_server` using the `-s` option:

```
shell> tlm_server -s -h hostmachine -p portnum
asking for status, hostmachine, portnum

RESPONSE: tlm_server running on host 'hostmachine' port portnum
Version: 2.6.0

License 1: rv *.*.* :: 1 in use, 0 available, 1 total, maint expires Sat Jun 16 12:13:00 2010
     -> alan@127.0.0.1 checked out at Sat Feb 27 16:15:40 2010
```

Status information includes, for each license, the users who currently have the license checked out, the number of available seats, and licenses expiration and maintenance expiration dates, if applicable.
