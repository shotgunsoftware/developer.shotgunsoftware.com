---
layout: default
title: Specifying License File Location
permalink: /rv/rv-client-license-management/specifying-license-file-location/
lang: en
---

# Specifying License File Location

Each platform has a set of default license file locations, as described below, but these can be overriden either from the command line with the “-lic” command-line flag, or by setting an environment variable: either a per-application location (for example _RV_LICENSE_FILE_), or _TWEAK_LICENSE_FILE_ which will apply to all Tweak applications (note that a license file can contain any number/kind of licenses, or in fact a pointer to a license server which can serve any number/kind of licenses).

The argument to the “-lic” command line flag (or the contents of the environment variable) must be the complete path to the license file, which can have any name (as long as the extension is “.gto”).

## OS X

On OS X, RV looks in four separate places to find the license file:

1. In your home directory at `~/Library/Application Support/RV/license.gto`
2. In the system directory at `/Library/Application Support/RV/license.gto`
3. On the Network at `/Network/Library/Application Support/RV/license.gto`
4. Inside the `Application` at `RV.app/Contents/Resources/license.gto` (for example `/Applications/RV.app/Contents/Resources/license.gto`)

RV will look for the file in the order above. The first license it requires is the one which it will use.

When RV starts without a license, it will open the License Installer application. This application will merge licenses and/or add a server license if needed. The installer always adds the server license last so that machine locked licenses are used first. When you save the license file it is saved in two places:

1. Inside the application at `RV.app/Contents/Resouces/license.gto`
2. In the system directory at `/Library/Application Support/RV/license.gto`

The installer may require authentication.

## Linux

On Linux, RV looks for the license file in three locations:

1. In your home directory at `~/.rv/license.gto`.
2. In the current directory.
3. Inside the RV package directory at `etc/license.gto` (for example `/usr/local/rv-install/etc/license.gto`).

RV will look for the file in the order above. The first license it requires is the one which it will use.

When RV starts without a license, it will open the License Installer application. This application will merge licenses and/or add a server license if needed. The installer always adds the server license last so that machine locked licenses are used first. When you save the license file it will be saved inside the RV package directory at `etc/license.gto`.

## Windows

On Windows, RV looks for the license file these two locations:

1. In your home directory at `$HOME/AppData/Roaming/RV/license.gto`.
2. Inside the RV package directory at `etc/license.gto` (for example `C:/Program Files (x86)/Tweak/RV-3.12.20-32/etc/license.gto`).

RV will look for the file in the order above. The first license it requires is the one which it will use.

When RV starts without a license, it will open the License Installer application. This application will merge licenses and/or add a server license if needed. The installer always adds the server license last so that machine locked licenses are used first. When you save the license file it will be saved inside the RV package directory at `etc/license.gto`.
