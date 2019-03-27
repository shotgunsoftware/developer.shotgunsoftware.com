---
layout: default
title: Installation
permalink: /rv/rv-maya-integration/01-installation/
lang: en
---

# Installation

The first step on any platform is to activate the integration package. That is, go to the *Packages* tab of the RV Preferences dialog, and click the Load button next to “Maya Tools”, then restart RV.

## Linux and Windows

On Linux and Windows, the only remaining task is to fill in the Application and Flags to run RV. In Maya open the Preferences, and go to the *Applications* section (titled “External Applications: Settings”). In the entry marked *Application Path for Viewing Sequences* enter the complete path to the *RVPUSH* executable. For example:

**Linux**

```
    /usr/local/bin/rv-3.12.15/bin/rvpush
```

**Windows**

```
    C:\Program Files (x86)\Tweak\RV-3.12.15-32\bin\rvpush.exe
```

Then, in the entry marked *Optional Flags*, type this:

```
    -tag playblast merge %f
```

## OSX (Maya 2012 or Maya 2013)

On OSX, using Maya 2012 or Maya 2013, after turning on the Maya integration as described above and restarting RV, you need to install a tiny MEL script to handle the Maya side of the playblasting. In RV, go to the Maya menu, and select *Install Maya Support File.* (The file is installed in `Library/Preferences/Autodesk/maya/scripts`.)

Then, in Maya open the Preferences, and go to the *Applications* section (titled “External Applications: Settings”). In the entry marked *Application Path for Viewing Sequences* enter the Following:

```
    playblastWithRV
```

Then, in the entry marked *Optional Flags*, type this:

```
    %f %r
```

Done!

## OSX (Maya 2014)

On OSX, using Maya 2014, after turning on the Maya integration as described above, and quitting RV, in Maya open the Preferences, go to the *Applications* section (titled “External Applications: Settings”). In the section marked *Sequence Viewing Applications* there are three applications, each with two entries, one for the application, and one for *Optional Flags*. In each application entry (assuming you’ve installed RV in the usual location), enter the following:

```
    unset QT_MAC_NO_NATIVE_MENUBAR; /Applications/RV64.app/Contents/MacOS/rvpush
```

Then, in each entry marked *Optional Flags*, type this:

```
    -tag playblast merge [ %f -fps %r ]
```

Done!
