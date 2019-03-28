---
layout: default
title: Disabling the License Installer
permalink: /rv/tweak-license-server/disabling-the-license-installer/
lang: en
---

# Disabling the License Installer

By default, when RV cannot get a license, it will start the Tweak License Installer and prompt the user to install one. If you’re using the license server, you probably don’t want just anyone installing licenses, so you can disable this behavior by setting the environment variable `TWEAK_NO_LIC_INSTALLER` to “1” in the global environment.
