---
layout: default
title: Client Licenses
permalink: /rv/tweak-license-server/08-client-licenses/
lang: en
---

# Client Licenses

As noted above, the Tweak License Server requires a license file to be installed locally. Client processes (RV, RVIO, etc) each require their own license file that points to the server. This file can be stored on the network where the package is installed (one copy of the file for all clients) or locally on each machine (one copy per machine), and should look something like the following:

```
GTOa (3)

server : ServerLicense (1)
{
     id
     {
          string hostname = "servername"
          int port = 5436
     }
}
```

The `hostname` field is the address of the machine running the license server. The `port` field should match the port specified when running the License Server on the host.
