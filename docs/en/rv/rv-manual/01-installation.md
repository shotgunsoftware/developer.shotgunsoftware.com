---
layout: default
title: Installation
permalink: /rv/rv-manual/01-installation/
lang: en
---

# Installation

## Overview

On Windows, RV is packaged with an installer program or as a zip file. On Linux RV is packaged as a tarball. On Mac OS X, RV is packaged as a dmg file. In all cases, RV requires a Shotgun account or a license file from Tweak in order to run. See below for details on Shotgun licensing. If you elect to use a node-locked or floating “traditional” license, select the “I have an RV license” option from the License Manager and follow the directions. The Tweak License Installer will launch and you can browse to the license file from Tweak, install, save, and restart RV.

> **Please Note**: in large installations, where the license is installed and managed by a central authority and individual users should never be installing licenses, the environment variable TWEAK_NO_LIC_INSTALLER can be set in the global environment. This will prevent RV from ever launching the license installer, even when no valid license can be found.

### Shotgun Licensing on All Platforms

As of RV6, RV can be licensed using your Shotgun username and password.

When RV starts without a license (or when you select “License Manager” from the File menu), you’ll be presented with this dialog:

<center>![RV/Shotgun License Manager](../../../../images/rv/rv-shotgun-license-manager.png)</center>

<center>*RV/Shotgun License Manager*</center>


Just enter the name or URL of your Shotgun server, and your username/password to license RV.

Some additional details:

* The current licensing style is always configurable via the &#8216;License Manager’ item on the &#8216;File’ menu.
* The RV (and RV-SDI) version 6.0 executables support both licensing systems (standard Tweak licensing and licensing via Shotgun).
* RV-SDI can be licensed via Shotgun only at sites using Super Awesome support.
* There’s no requirement that a given site use only one style of licensing.
* RV licensed via Shotgun is functionally identical to RV licensed the usual way.
* A user can switch from Tweak-standard to via-Shotgun licensing and back (the choice is stored as a preference).
* At a facility where standard Tweak RV licensing is set up and working, there will be no change when the user runs RV6 (they will be able to try out via-Shotgun licensing by selecting a menu item if they wish).
* Licensing RV via Shotgun does not produce any requirement to use Shotgun for other purposes. For example, users may license RV via Shotgun, but not use Screening Room.
* A user who authenticates RV via Shotgun username/passwd once, and then runs RV at least once a week, will not have to authenticate again. (The original authentication will be refreshed on each run, assuming that the Shotgun server is accessible, and the username/passwd is still valid).
* Similarly, an RV user who authenticates via Shotgun will be able to use RV offline (when the Shotgun server is unavailable) for 30 days, starting from the most recent online use.
* Using RVIO to export from RV is allowed as long as RV is licensed (with any licensing scheme). Usage of RVIO on the farm (or otherwise unassociated with any local RV process) still requires a standard Tweak license.

For “traditional” licensing, select the second option in the License Manager dialog, and follow instructions to install a license (or just exit RV to return to an existing “traditional” licensing setup).

#### Site-wide Control of Server URL or Login Default Values

If the user hasn’t authenticated with Shotgun yet, and the environment variable *RV_SHOTGUN_DEFAULT_SERVER_URL* is set, its value will be used as the default server URL in the dialogs. If you as the admin of a site can predict the user name as well (for example if everyone uses *First.Last*) you could set the environment variable *RV_SHOTGUN_DEFAULT_LOGIN* in the user’s dot files or whatever, and that value will be used as the default login.

#### Proxy Configuration

If a network proxy is required to access your Shotgun server, you can configure RV to use that proxy server with environment variables, as described below.

| | | | |
|-|-|-|-|
| RV_NETWORK_PROXY_HOST | string | required | Proxy host name or IP address |
| RV_NETWORK_PROXY_PORT | int | required | Proxy port number |
| RV_NETWORK_PROXY_USER | string | optional | User name for proxy service |
| RV_NETWORK_PROXY_PASSWORD | string | optional | Password for proxy service |

<center>*Proxy Configuration Environment Variables*</center>

#### A Note on “Legacy” Shotgun Integration Set-ups

Prior to the release of Shotgun6 / RV6, users of the RV/Shotgun integration were required to set up a “custom config module” that specified the Shotgun URL server and “script key” in order to authenticate with the server. Since the new code will authenticate with login/password (and the script key authentication is a giant security hole), the custom config module is no longer needed for that purpose. However, you can also use a custom config to fit the integration to your non-standard Shotgun entity/field structure, or to add support for additional fields. If you have a custom config and want to continue using it for that purpose, we recommend that you adjust the serverMap() function in your config module to return an empty string. (Note that most of the new stuff should still work with the “old” serverMap, but it can interfere with env var control mentioned above.)

#### Local Servers That Only Support HTTP (not HTTPS)

The RV/Shotgun integration and licensing will always attempt to use the https protocol for maximum security. This can cause problems in some local Shotgun installations which only support http (or only partially support https). In those cases the environment variable *RV_SHOTGUN_AUTH_NO_HTTPS* can be set to prevent the use of https unless it is specifically requested in the URL.

## Mac OS X

### Requirements

RV requires a recent mac running the latest OS X 10.6 (Snow Leopard) or better. In order to use new features OS X 10.7 (Lion) is required in order to use OpenGL 3.2.

### Installation and Licensing

Download the latest Mac version of RV onto your Macintosh. This will be a .dmg file. Double click on the .dmg icon. Once the folder opens, drag the RV application onto the Applications link.

RV requires a license file from Tweak in order to run. If you do not have a valid license file installed, RV will launch a dialog for installing your license. Use the &#8216;add license’ button on the license manager dialog to browse to the license file you have received from Tweak. Make sure to save before you close the license manager. Then restart RV.

If you don’t yet have a license, you will need to get one from Tweak. RV’s licenses are locked to your computer using the *Ethernet ID.* Send this ID to Tweak to have a license generated for your computer. The Ethernet ID looks something like this: 00:19:E3:04:8B:80, and can be found in the OS X network preferences, under the option *Built-in Ethernet* in the *Ethernet* tab. It is easy to accidentally find the ID for the Airport or other device on your Macintosh, so double check to make sure you have the correct ID. If you computer has multiple network ports, choose the first one.

### Structure of RV on OS X

In OS X, RV is built as an Application bundle (.app). The bundle contains all of the same types of files found in the Linux distribution tree, but also contains OS X specific files like icons and user interface elements (.nib files). The application bundle can be installed at any location in a Mac file system or may be installed on an NFS mounted file system.

If you wish to use RV command line tools, you will need to add the MacOS directory to your path. The directory is located relative to wherever you have installed RV. For example, if you installed RV in the default location, the /Applications directory, then the path would be /Applications/RV.app/Contents/MacOS. Or /Applications/RV64.app/Contents/MacOS for the 64-bit version.)

If you wish to use RV as the protocol handler for the rvlink URL protocol (see Appendix [C](c-the-rv-link-protocol.html), run RV once with the -registerHander command-line option. This will register the rvlink protocol handler with the operating system.

## Linux

### Requirements

RV is built to work with NVidia graphics cards on Linux. A current NVidia driver (which supports OpenGL 3.2 or newer) is required.

### Installation and Licensing

RV for Linux is distributed as a gzipped tarball. Un-tar this archive into the directory in which you would like to install RV with some version of the tar command, like this.

```
tar -zxf rv-Linux-x86_64-3.5.1.tar.gz
```

Edit your dot files to include the rv/bin directory in your PATH. You can use the Tweak license installer to install your license, or can copy it directly in the $RV_HOME/etc subdirectory and name it “license.gto.”

### Structure of RV on Linux

On Linux, the directory tree resulting from the above &#8216;untar’ can be installed anywhere. The directory tree contains the RV binary, start-up script, and runtime support files as well as documentation. In order to use rv from a shell, you will need to have the bin directory of the RV distribution tree in your path.

RV is split into two programs: rv and rv.bin. rv is a shell script which sets a number of environment variables including plugin directory locations in the RV tree and search paths for user plugins and scripts. Currently the shell script makes sure the following environment variables are set properly:

**RV_HOME**
  The location of the RV distribution tree.
**LD_LIBRARY_PATH**
  inserts $RV_HOME/lib in front of existing directories
**MU_MODULE_PATH**
  sets to $RV_HOME/plugins/Mu
**MAGICK_CONFIGURE_PATH**
  sets to $RV_HOME/etc/config

The rv shell script also contains two optional environment variables related to RV’s audio configuration. These are commented out, but you may need to or choose to set them to fine tune RV’s audio performance depending on the vintage and flavor of Linux. See the appendix for an in depth discussion of Linux audio configuration.

Once it has finished setting up the environment the startup script executes the RV binary rv.bin with the default UI script. If you have some of these variables set prior to calling the start up script, they will be modified or augmented to meet RV’s requirements.

If you wish to use RV as the protocol handler for the rvlink URL protocol (see Appendix [C](c-the-rv-link-protocol.html), the protocol handler must be registered. Unlike Windows and Mac, Linux protocols are registered at the desktop environment level, not the OS level. After you’ve installed RV on your machine, you can run the rv.install_handler script in the install’s bin directory. This script will register RV with both the KDE and Gnome desktop environments.

Some application-specific notes:

**Firefox** may or may not respect the gnome settings, in general, we’ve found that if there is enough of the gnome environment installed that gconfd is running (even if you’re using KDE or some other desktop env), Firefox will pick up the gnome settings. If you can’t get this to work, you can register the rvlink protocol with Firefox directly as described here [on the Mozilla website](http://support.mozilla.com/en-US/kb/The+protocol+is+not+associated+with+any+program#Register_the_protocol_in_Firefox).

**Konqueror** sadly seems to munge URLs before giving them to the protocol handler. For example by swapping upper for lowercase letters. And sometimes it does not pass them on at all. This means some rvlink URLs will work and some won’t, so we recommend only baked rvlink urls with Konqueror at the moment. (see Appendix [C](c-the-rv-link-protocol.html)

## Windows

### Requirements

RV requires NVIDIA or AMD FirePro graphics cards that are OpenGL 3.2 capable running up-to-date drivers.

### Installation and Licensing

Download the latest Windows version of RV onto your Windows PC. For 32-bit RV, this will be a windows installer executable. Double click on the installer icon. Follow the instructions to install RV. For 64-bit windows, the download will by a zip file that you can unzip into the desired location.

RV requires a license file from Tweak in order to run. If you do not have a valid license file installed, RV will launch a dialog for installing your license. Use the &#8216;add license’ button on the license manager dialog to browse to the license file you have received from Tweak. Make sure to save before you close the license manager.

If you don’t yet have a license, you will need to get one from Tweak. RV’s licenses are locked to your computer using the *HostID.* Send this ID to Tweak to have a license generated for your computer. The Ethernet ID looks something like this: 00:19:E3:04:8B:80. The correct HostID for your computer will be displayed in the license manager dialog in the HostID field on the left.

<center>![Tweak License Installer](../../../../images/rv/tweak_tli.jpg)</center>

<center>*Tweak License Installer*</center>

### Structure of RV on Windows

RV is installed by default into `C:\Program Files\Tweak\RV-3.12\`. You are given the option of creating a desktop shortcut during installation. RV and other Tweak executable files (rv.exe, rvio.exe, etc.) are placed in the bin subdirectory.

If you wish to use RV as the protocol handler for the rvlink URL protocol (see Appendix [C](c-the-rv-link-protocol.html), the protocol handler must be registered. If you used the .exe windows installer, RV was registered as the rvlink protocol handler as part of that process. If you installed from the zip package, you can edit the file rvlink.reg, in the etc directory, to point to the location where you installed RV. Then run this file (double-click) to edit the registry to register RV as the rvlink protocol handler.
