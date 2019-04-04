---
layout: default
title: Troubleshooting Networking
permalink: /rv/rv-manual/troubleshooting-networking/
lang: en
---

# F: Troubleshooting Networking

**Connections only work from one direction or are always refused**

Some operating systems have a firewall on by default that may be blocking the port RV is trying to use. When you start RV on the machine with the firewall and start networking it appears to be functioning correctly, but no one can connect to it. Check to see if the port that RV wants to use is available through the firewall.

This is almost certainly the case when the connection works from one direction but not the other. The side which can make the connection is usually the one that has the firewall blocking RV (it won’t let other machines in).
