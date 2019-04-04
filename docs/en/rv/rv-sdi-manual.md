---
layout: default
title: SDI MANUAL
permalink: /rv/rv-sdi-manual/
lang: en
---

# RV 7: SDI MANUAL

## Overview

This manual describes RV’s implementation of the BlackMagic and AJA SDI hardware as a presentation mode device. For more information on presentation mode and how it relates to RV in general see the RV User’s Manual.

RVSDI is a 64 bit only application which runs on Mac OS X, Linux, and Windows 7. It can be used to output to either BlackMagic or AJA SDI hardware. Note support for NVIDIA-SDI has been removed from RVSDI v7.2.0 onwards.

### Getting Started

Prior to RVSDI version 7.2.0, you should have received a license file containing both an RVSDI license and an RV license. Both licenses can be floating if desired. However, from RVSDI version 7.2.0 onwards RV or RVSOLO licenses can be used for RVSDI too. The rvsdi executable (or rvsdi.exe on windows) differs from the regular rv binary in that it can interact with the SDI hardware.

On Windows: navigate to the RV installation’s bin folder and launch the rvsdi.exe binary.

On Linux: go the bin directory of the RV installation tree and start the rvsdi program.

Once the RVSDI executable has started, the first thing you should do is open the video preferences tab under RV → Preferences → Video. This is the primary interface to configure the SDI device for presentation mode.

### Quick Start

1. Start RVSDI go to the Video prefs
2. For SDI select the Blackmagic or AJA video module
3. Select the SDI device (e.g. the DecLink Extreme 4k for Blackmagic or Kona4 or IO 4K in the AJA case)
4. Select the video and data formats and sync method
5. Click the “Use as Presentation Device” check box
6. If you want audio output to SDI check “Output audio to this device”
7. Exit preferences
8. Select View → Presentation Mode to start SDI output

Next time you’re in RV you only need to do step &#35;8. You can always start the prefs to change the SDI parameters as described below.
