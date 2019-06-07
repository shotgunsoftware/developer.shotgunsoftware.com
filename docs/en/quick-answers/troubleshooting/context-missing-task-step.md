---
layout: default
title: Why is my context is missing the Task/Step when it exists as part of the filename?
pagename: context-missing-task-step
lang: en
---

# Why is my context is missing the Task/Step when it exists as part of the filename?

Toolkit uses the [path cache](../administering/what-is-path-cache.md) to help associate paths on disk with entities in Shotgun and build your context. Since the path cache only stores **folder** information and not filenames, any context-related information contained in the filename (including Task or Step name) will not be detected when building the context.

The best way to solve this currently, is to consider modifying your schema slightly so that the Task or Step is part of the folder structure rather than the filename. 