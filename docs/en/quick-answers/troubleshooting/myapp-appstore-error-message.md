---
layout: default
title: App store does not contain an item named my-app
pagename: myapp-appstore-error-message
lang: en
---

# ERROR: App store does not contain an item named my-app

## How to fix:

This has to do with the location descriptor on your custom app—[check out this doc](https://developer.shotgridsoftware.com/2e5ed7bb/#part-6-preparing-your-first-release).

For locations, set up your my-app with a path descriptor—[see details here](https://developer.shotgridsoftware.com/tk-core/descriptor.html#pointing-to-a-path-on-disk).

## Example of what's causing this error: 

While trying to use tank validate since tk-multi-snapshot isn’t showing up in maya, the error is presented when it tries to validate a custom app, stating it isn’t in the app store.

[See the full thread in the community](https://community.shotgridsoftware.com/t/tank-validate-errors-on-custom-apps/10674).

