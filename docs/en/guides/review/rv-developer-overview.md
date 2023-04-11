---
layout: default
title: RV Developer Overview
pagename: rv-developer-overview
lang: en
---

# RV Developer Overview

RV Core Reference
-----------------

### User Manual

The User Manual includes introductory material to get you started with RV and RVIO as well as complete command-line and GUI usage. In addition, you’ll find installation notes and tips on maximizing performance as well as in-depth information on LUTs, the RV pixel pipeline, stereoscopic 3D, expanding RV with Packages, networking with RV and the RVLS media listing utility.

*   [RV User Manual](https://help.autodesk.com/view/SGSUB/ENU/?guid=SG_RV_rv_manuals_rv_user_manual_html)
*   [Questions & Troubleshooting Forum](https://community.shotgridsoftware.com/c/rv/14)

### Technical Reference Manual

The Reference Manual is the starting place for learning how to customize RV. It contains an overview of RV’s package system and Mu scripting capabilities. It is the place to start if you want to change hot keys, add menus, customize color management, create new widgets or integrate RV with your pipeline.

*   [Technical Reference Manual](https://help.autodesk.com/view/SGSUB/ENU/?guid=SG_RV_rv_manuals_rv_reference_manual_html)
*   [Extending RV Forum](https://community.shotgridsoftware.com/c/rv/14)

### RV-SDI Manual

This manual describes Tweak’s implementation of the NVIDIA SDI video device as a presentation mode device. For more information on presentation mode and how it relates to RV in general see the RV User Manual. To use RV-SDI, you must run the "rv" (or "rv.exe") executable, and have an "rvsdi" license.

*   [RV-SDI Manual](https://help.autodesk.com/view/SGSUB/ENU/?guid=SG_RV_rv_manuals_rv_rv_sdi_manual_html)



RV Integration
--------------

### RV / Nuke Integration

RV now comes with Nuke integration tools. This document describes installation for an individual or system wide setup and describes the workflow, tools, concepts and usage for RV/Nuke.

*   [RV-Nuke Integration Documentation](https://help.autodesk.com/view/SGSUB/ENU/?guid=SG_RV_rv_knowledge_base_rv_nuke_integration_html)

### RV / Maya Integration

RV now comes with Maya integration. This document explains how to install the RV/Maya Package and describes the RV/Maya workflow and how to compare and organize playblasts and how to render into edits, A/B comparisons, and layouts.

*   [RV-Maya Integration Documentation](https://help.autodesk.com/view/SGSUB/ENU/?guid=SG_RV_rv_manuals_rv_maya_integration_html)

## Configuring software launches

Newer versions of RV need an additional configuration within the [`software_paths.yml`](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/software_paths.yml) file. The `software_paths.yml` file is available when you have taken over your configuration. Ensure that your reflects the following paths for RV to launch, with your specific path, version, and application information added:

```yml
# RV
path.linux.rv: "rv"
path.mac.rv: "/Applications/RV.app"
path.windows.rv: C:\Program Files\Shotgun\RV-7.9.0\bin\rv.exe
```

[See this `software_paths.yml`](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/includes/software_paths.yml) file for reference.
