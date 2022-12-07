---
layout: default
title: Why are my Houdini ShotGrid integrations not starting?
pagename: houdini-integrations-not-starting
lang: en
---

# Why are my Houdini {% include product %} integrations not starting?


This covers the most common reason we’ve seen for the {% include product %} integrations not starting in Houdini. In this case,
Houdini launches without error from {% include product %} Desktop, your {% include product %} website, or the tank command. However, once Houdini
is launched, the {% include product %} menu or shelf does not appear.

Often the reason for this is that the `HOUDINI_PATH` environment variable has been overridden, and {% include product %} relies on that
 for passing the startup script path.

When Houdini is launched from {% include product %}, the launch app logic adds the {% include product %} bootstrap script path to the `HOUDINI_PATH`
environment variable. However, the problem can arise when Houdini has a
[houdini.env file](https://www.sidefx.com/docs/houdini/basics/config_env.html#setting-environment-variables).
This file allows the user to set environment variables that will be present when Houdini is loaded, but any values
defined in the file will overwrite pre-existing environment variables in the current session.

The fix for this is to make sure you include the pre-existing `HOUDINI_PATH` environment variable in the new definition
for that variable.

For example, if you have something like this already in your `houdini.env` file:

    HOUDINI_PATH = /example/of/an/existing/path;&

Then you should add `$HOUDINI_PATH;` to the end of the path defined in the file and save it:

    HOUDINI_PATH = /example/of/an/existing/path;$HOUDINI_PATH;&

This will allow the {% include product %} set value to persist when Houdini launches.

{% include warning title="Caution" content="On Windows we've seen `$HOUDINI_PATH` causing issues. It sometimes tries to bootstrap the Shotgun integration multiple times generating an error like this: 

    Toolkit bootstrap is missing a required variable : TANK_CONTEXT

If you get this you should try using `%HOUDINI_PATH%` instead." %}

If this does not fix your problem please reach out to our [support team](https://knowledge.autodesk.com/contact-support) and they will help you diagnose the issue.