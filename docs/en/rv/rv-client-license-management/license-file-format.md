---
layout: default
title: License File Format
permalink: /rv/rv-client-license-management/license-file-format/
lang: en
---

# License File Format

The license file is a text GTO file which contains any number of machine locked licenses and/or locations of servers to contact to find a license. RV will ignore licenses which do not apply to the machine it is running on, so its OK to have many machine locked licenses in a single file. A typical license file will look something like this:

```
    GTOa (3)

    c498a8f831da62168d21065af1bedbac0038273a : license (1)
    {
        license
        {
            string package = "rv"
            string version = "any"
            string expires = "permanent"
            int count = 1
            string hostID = "00:0A:95:AE:F9:E0"
            string issued = "12-Jul-2006"
            int duration = 0
            string reason = "web"
            string licensee = "Jack Foo Bar"
            string email = "jackfoobar@myemail.com"
            string machine = "brutus"
            string os = "any"
        }
    }
```

In this case, there is a single machine locked license. The first line of the file identifies the file type and is not part of the license. Some of the information is for the licensee’s use only (machine name, etc). Multiple licenses in one file would have the form:

```
    GTOa (3)

    c498a8f831da62168d21065af1bedbac0038273a : license (1)
    {
        license
        {
            ... etc ...
        }
    }

    q431a8f831da62168d21065af1bedbac0038c421 : license (1)
    {
        license
        {
            ... etc ...
        }
    }
    ... etc ...
```

Here each block starting with the long hash is the start of a license for an individual machine. If the file is indicating to the client that it should look up a server, it would look like this:

```
    GTOa (3)

    server : floatinglicense (1)
    {
        id
        {
            string hostname = "licenseserver.ourdomain.local"
            int port = 5445
        }
    }
```

In this case licenserver.outdomain.local would be the name of the machine running the license server that RV should contact to obtain a license. A GTO file can contain any combination of machine locked licenses and server floating licenses.

The first license in the file that works is the one used. If you wish to have both machine locked and floating licenses in one file, the best behavior is usually obtained by putting the machine locked licenses before the server. This way the dedicated licenses are used up before the floating licenses.
