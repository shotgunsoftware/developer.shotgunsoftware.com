---
layout: default
title: Anatomy of a Tweak License File
permalink: /rv/tweak-license-server/anatomy-of-a-tweak-license-file/
lang: en
---

# Anatomy of a Tweak License File

A license file can hold any number of licenses. The server will examine them all to determine which can satisfy the incoming request and if a currently checked-out licenses can be used to satisfy the request without consuming an additional license.

If more than one license in the file could satisfy the requests, the license consumed with be the latest in the file, so you can order the licenses in the file to determine the order of consumption.

```
GTOa (3)

048340189d06b475b271bd090dce56fd77827c7e : License (2) # License Name : File Version
{
     license
     {
          string package =  "rv"                  # Name of licensed software package
          string version =  "3.4.*"               # Version licensed
          string expires =  "29-Apr-2008"         # Expiration date, can be "permanent"
          string updatesUntil =  "25-Apr-2008"    # Expiration date for update rights
          int count =  1                          # Number of seats licensed
          string hostID =  "00:17:F2:CA:09:1A"    # Host ID
          string issued =  "15-Apr-2008"          # Issue date
          string reason =  "eval"                 # Reason for license
          string licensee =  "Facility Name"      # Optional field
          string email =  "contact@facility.com"  # Optional field
          string machine =  "servername"          # Optional field
          string os =  "any"                      # Operating System licensed
          string card =  "cardname"               # Optional field
     }
}

a79302764e96c74e0064d6a652000a54288e5abd : License (2)
{
     license
     {
          string replaces =  "048340189d06b475b271bd090dce56fd77827c7e"
                              # License superseded by this one.
                              # Replaced license must be present
                              # in the file or tlm_server will fail
          string package =  "rv"
          string version =  "3.4.*"
          string expires =  "permanent"
          string updatesUntil =  "25-Apr-2009"
          int count =  1
          string hostID =  "00:17:F2:CA:09:1A"
          string issued =  "25-Apr-2008"
          string reason =  "commercial"
          string licensee =  "Facility Name"
          string email =  "contact@facility.com"
          string machine =  "servername"
          string os =  "any"
          string card =  "cardname"
     }
}
```
