---
layout: default
title: How do I re-setup a Toolkit Project using SG Desktop?
pagename: resetup-project-with-sg-desktop
lang: en
---

# How do I re-setup a Toolkit Project using SG Desktop?

{% include info title="Note" content="We are aware this is a tedious process and have plans to allow you to do this directly from SG Desktop by selecting a checkbox to \"force\" the process again." %}

The steps you need to do to re-setup the Project are as follows.

## Option 1: Manually remove leftover settings and re-run setup in SG Desktop

- Delete the PipelineConfiguration entity(s) linked to your Project in Shotgun
- Remove the corresponding pipeline configuration directory(s) on disk
- Set the Tank Name field on your Project in Shotgun to a blank value
- In SG Desktop
    - Navigate out to the Project list
    - Select the Project you wish to setup
    - Now you can run the project setup process again

## Option 2: Run project setup from the command line with --force

- Open a terminal
- `cd` to the site config directory. By default these are located:
    - If you are using the Shotgun Integrations
        - Mac: `~/Library/Caches/Shotgun/<your_site_name>/site.basic.desktop/cfg`
        - Windows: `%APPDATA%\Shotgun\<your_site_name>\site.basic.desktop/cfg`
        - Linux: `~/.shotgun/<your_site_name>/site.basic.desktop/cfg`
    - If you are using the Toolkit platform
        - Mac: `~/Library/Application Support/Shotgun/<your_site_url>/site`
        - Windows: `%APPDATA%\Shotgun\<your_site_url>\site`
        - Linux: `~/.shotgun/<your_site_url>/site`
- Run the command `./tank setup_project --force`
- Follow the on-screen instructions