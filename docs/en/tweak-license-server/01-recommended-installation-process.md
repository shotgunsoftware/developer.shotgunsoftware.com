---
layout: default
title: Recommended Installation Process
permalink: /rv/tweak-license-server/01-recommended-installation-process/
lang: en
---

# Recommended Installation Process

You’ll find platform specific notes on installing `tlm_server` as a daemon or service below. But we recommend that you first follow these steps to getting the server working:

1. Install the server by unpacking the package into a suitable directory (On OS X, run the installer - see below). Note that the server must run on a machine with a MAC address (host ID) that corresponds to that in the licenses that it will serve.

2. Run `tlm_server` from the command line with the `-fg` flag and no `-log` flag, like this:

```
tlm_server -fg -f <my_license_file>.gto
```
(**Note:** on windows you must use the `.exe` extension, or tlm_server will not run. On OSX the installer puts the tlm_server executable in `/Applications/Utilities/tlm_server/bin`.)

You should see something like this

```
Tweak License Server
Started: Fri Feb 26 15:17:41 2010
tlm_server running on host 'myhost' port 5436
Version: 2.6.0

License 1: rvsolo 3.*.* :: 0 in use, 5 available, 5 total
License 2: rvio 3.*.* :: 0 in use, 5 available, 5 total
```   

3. Run RV or RVIO clients and watch the output from `tlm_server`. You should see licenses being `APPROVED` and `RELEASED`. (You may also see some rejections during normal operation, since RV tries to used the “least desirable” (IE least expensive) license types first.

Note that RV needs to know how to contact the license server. If you are running RV for the first time, it’ll start the license installer and you can use the *Set License Server* button at the bottom. Or you can install a site-wide or per-machine client license as described below in the *Client Licenses* section

4. If everything looks good, kill the running server (`ctrl-C`) and start a new server as a daemon (in the background), with logging:

```
        tlm_server -f <my_license_file>.gto -log <my_log_file>
```

(**Note:** on windows you must use the `.exe` extension, or tlm_server will not run.)

The server process will print `Running in background ...` and you can then close the terminal in which you started `tlm_server`.

5. At this point the server is fully functional, and you can just check the `tlm_server` log file periodically to make sure that things are working as you expect. But eventually you’ll probably want to install the server so that it starts automatically when the server machine reboots. As this process is very platform-dependent please refer to the appropriate following section.
