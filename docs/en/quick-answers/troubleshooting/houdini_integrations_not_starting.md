---
layout: default
title: Why are my Houdini Shotgun integrations not starting?
permalink: /quick-answers/troubleshooting/houdini_integrations_not_starting/
lang: en
---

# Why are my Houdini Shotgun integrations not starting?


This covers the most common reason we’ve seen for the Shotgun integrations not starting in Houdini. In this case,
Houdini launches without error from Shotgun Desktop, your Shotgun website, or the tank command. However, once Houdini
is launched, the Shotgun menu or shelf does not appear.

Often the reason for this is that the HOUDINI_PATH environment variable has been overridden, and Shotgun relies on that
 for passing the startup script path.

When Houdini is launched from Shotgun, the launch app logic adds the Shotgun bootstrap script path to the HOUDINI_PATH
environment variable. However, the problem can arise when Houdini has a
[houdini.env file](http://www.sidefx.com/docs/houdini/basics/config_env.html#setting-environment-variables).
This file allows the user to set environment variables that will be present when Houdini is loaded, but any values
defined in the file will overwrite pre-existing environment variables in the current session.

The fix for this is to make sure you include the pre-existing HOUDINI_PATH environment variable in the new definition
for that variable.

For example, if you have something like this already in your houdini.env file:

    HOUDINI_PATH = /example/of/an/existing/path;&

Then you should add $HOUDINI_PATH; to the end of the path defined in the file and save it:

    HOUDINI_PATH = /example/of/an/existing/path;$HOUDINI_PATH;&

This will allow the Shotgun set value to persist when Houdini launches.

On Windows we've seen `$HOUDINI_PATH` causing issue with it to try and bootstrap multiple times. If you get this
You should try using `%HOUDINI_PATH%` instead.

If this does not fix your problem please reach out to our support team and they will help you diagnose the issue.