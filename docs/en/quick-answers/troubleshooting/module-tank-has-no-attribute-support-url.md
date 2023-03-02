---
layout: default
title: Error module 'tank' has no attribute 'support_url' when launching {% include product %} Desktop
pagename: module-tank-has-no-attribute-support-url
lang: en
---

# Error module 'tank' has no attribute 'support_url' when launching {% include product %} Desktop

## Issue

The following message appears when launching {% include product %} Desktop after upgrading the version:

```
{% include product %} Desktop Error:
Error: module 'tank' has no attribute 'support_url'
```

## Causes

The Descriptor version is incompatible with the newer {% include product %} Desktop version 1.7.3.
'support_url' was introduced in tk-core v0.19.18.

## Solution

To overcome this issue, do the following:

1. Access the Pipeline Configuration List page on the {% include product %} website.
2. Check if the Descriptor field has an old version incompatible with the newer {% include product %} Desktop version.

## Related links

- [Knowledge base support article](https://knowledge.autodesk.com/support/shotgrid/troubleshooting/caas/sfdcarticles/sfdcarticles/Error-module-tank-has-no-attribute-support-url-when-launching-ShotGrid-Desktop.html)

