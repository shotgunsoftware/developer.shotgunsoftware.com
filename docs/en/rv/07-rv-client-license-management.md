---
layout: default
title: RV Client License Management
permalink: /rv/07-rv-client-license-management/
lang: en
---

# RV Client License Management

[© Tweak Software](http://tweaksoftware.com/)

## Overview

**PLEASE NOTE:** This page concerns “traditional” RV licensing, either node-locked or floating. As of RV6, you can also license RV via Shotgun. Some answers to common questions:

* The current licensing style is always configurable via the _License Manager_ item on the _File_ menu.
* The RV (and RV-SDI) version 6.0 executables support both licensing systems (standard Tweak licensing and licensing via Shotgun).
* RV-SDI can be licensed via Shotgun only at sites using “Super Awesome” support.
* There’s no requirement that a given site use only one style of licensing.
* RV licensed via Shotgun is functionally identical to RV licensed the usual way.
* A user can switch from Tweak-standard to via-Shotgun licensing and back (the choice is stored as a preference).
* At a facility where standard Tweak RV licensing is set up and working, there will be no change when the user runs RV6 (they will be able to try out via-Shotgun licensing by selecting a menu item if they wish).
* Licensing RV via Shotgun does not produce any requirement to use Shotgun for other purposes. For example, users may license RV via Shotgun, but not use Screening Room.
* A user who authenticates RV via Shotgun username/passwd once, and then runs RV at least once a week, will not have to authenticate again. (The original authentication will be refreshed on each run, assuming that the Shotgun server is accessible, and the username/password is still valid).
* Similarly, an RV user who authenticates via Shotgun will be able to use RV “offline” (when the Shotgun server is unavailable) for 30 days, starting from the most recent “online” use.
* Using RVIO to export from RV is allowed as long as RV is licensed (with any licensing scheme). Usage of RVIO “on the farm” (or otherwise unassociated with any local RV process) still requires a standard Tweak license.
* Intro video and additional Shotgun setup details available [here](https://support.shotgunsoftware.com/entries/92074518).

If not licensing via Shotgun, RV requires an accessible license file (called license.gto) in order to run. The license file either directly provides a license or indicates one or more servers from which to obtain one. Each platform has a different set of places in which RV tries to find a license file. If it is unable to find it, it will complain and exit immediately.
