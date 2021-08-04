---
layout: default
title: Configurations does not point to a valid bundle on disk!
pagename: configurations-does-not-point-to-valid-bundle-on-disk
lang: en
---

# Configurations does not point to a valid bundle on disk!

## Use Case

When installing {% include product %} Desktop for the first time, this error can be presented after a file path after opening a project. 

## How to fix

The Pipeline Configuration entity for the project is pointing to `...\{% include product %}\Configurations` path to the config on Windows. This is likely not the correct path, so as a first step, ensure that path exists or correct it.

It's also possible that you may be trying to access from a centralized set-up where you do not have access to that path location. In this case, switching to a distributed set-up will help.


## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/first-time-setting-up-shotgun-and-i-have-this-error/9384)