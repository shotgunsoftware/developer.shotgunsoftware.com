---
layout: default
title: Running SG Desktop v1.7.3 in Rocky Linux 8
pagename: where-are-my-log-files
lang: en
---

# Running SG Desktop v1.7.3 in Rocky Linux 8

These workaround steps apply to SG Desktop v1.7.3 (the latest version) and they have been tested on Rocky Linux 8.6. 

1. Install SG Desktop v1.7.3:
```
$ sudo yum -y install 'shotgrid_desktop-current-1.x86_64.rpm' 
```
2. Remove `libcrypto` and `libssl` OS files: 
```
$ sudo rm -rf /opt/Shotgun/Python3/lib/libcrypto.so.1* 
$ sudo rm -rf /opt/Shotgun/Python3/lib/libssl.so.1* 
```
3. Copy the `libssl` and `libcrypto` OS files from the operating system: 
```
$ sudo cp /usr/lib64/libssl.so.1.1  /opt/Shotgun/Python3/lib/ 
$ sudo cp /usr/lib64/libcrypto.so.1.1  /opt/Shotgun/Python3/lib/ 
```
4. Check the `/opt/Shotgun/Python3/lib/` directory,  where it should have this now: 
```
$ ls /opt/Shotgun/Python3/lib/ 
libcrypto.so libcrypto.so.1.1  libpython3.7m.so  libpython3.7m.so.1.0  libpython3.so libssl.so libssl.so.1.1 pkgconfig  python3.7
```
5. Now, you should be able to launch and use SG Desktop: 
```
$ cd /opt/Shotgun && ./Shotgun
```