---
layout: default
title: Multiple and Fallback Servers
permalink: /rv/tweak-license-server/multiple-and-fallback-servers/
lang: en
---

# Multiple and Fallback Servers

If you have multiple sets of licenses — for example two licenses each of which allows 10 copies to be checked out — you may want to run them on different servers. To specify multiple servers in a client file:

```
GTOa (3)

server1 : ServerLicense (1)
{
     id
     {
          string hostname = "servername1"
          int port = 5436
     }
}

server2 : ServerLicense (1)
{
     id
     {
          string hostname = "servername2"
          int port = 5436
     }
}
```

If the first server is unavailable or does not have any licenses left the client will attempt to contact the second server to obtain a license.
