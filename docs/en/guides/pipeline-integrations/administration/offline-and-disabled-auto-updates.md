---
layout: default
title: Disabling auto updates and offline usage
pagename: disabling-auto-updates-and-offline
lang: en
---

# Disabling auto updates and offline usage

## Auto updates
### What parts auto update?

By default Shotgun Desktop will automatically check for updates, and install them to the local machine if it finds any.

It checks for updates on two components:

- `tk-framework-desktopstartup` - A frame work which aids the launch of Shotgun Desktop.
- `tk-config-basic` - The default site config.

The configuration acts as a manifest for the versions of the apps, engines, frameworks, and core version that should be used by Shotgun Desktop.
By updating the config, you are potentially updating any of these components as well.
Any updates that are found are downloaded and stored in the user's local cache, rather than modifying the original Shotgun Desktop installed files.

Shotgun Create as an application has it's own update mechanism separate from Shotgun Desktop which is not covered here.
However the integration features provided in Shotgun Create work in a similar way, and will also auto update `tk-config-basic` into the same user cache.

### What doesn't auto update?

If you have taken over a site configuration, then it won't check for newer `tk-config-basic` updates but more on that further down.
Also any projects that aren't using the default site configuration (I.e. a project where the Toolkit advanced setup wizard has been run on it.), will not have their configuration auto updated.

### What if I can't or don't want to auto update?

There are scenarios where you might want to run integrations in an environment where there is no connection to the internet or just have control when updates roll out.
{% include info title="Note" content="If possible we recommend that you continue to allow auto updates to avoid missing out on new features and bug fixes." %}

The following sections describes how to address each of these scenarios.

- Offline Usage Scenarios
- Disabling auto updates

## Running the integrations offline.

### Initial Setup

If your studio has restricted internet access or no internet access then you will need to ensure that you have all the required parts cached locally.
You will still need one machine that can connect to the internet in order to download Shotgun Create or Shotgun Desktop.

Shotgun Create and Shotgun Desktop come prepackaged with all the dependencies required to run the basic integrations.
When you start either of them up, it will automatically try to look for updates, but if it cannot connect to the Shotgun App Store, it will simply run the most recent version that exists locally.

It is recommended that you follow the "Managing updates" steps bellow after installing Shotgun Desktop, as the components bundled with the installer may not be the latest.

{% include info title="Note" content="Depending on your network setup, it can sometimes get stuck looking for updates online even though it won't be able to access them. 
In this situation you can set the environment variable `SHOTGUN_DISABLE_APPSTORE_ACCESS` to `\"1\"` to stop it from trying." %}

{% include info title="Note" content="You will still need to be able to connect to your Shotgun site. When we say offline we are talking about not being able to connect to our app store to download updates." %}

### Managing updates

To update the `tk-framework-desktopstartup` component, you will need to [download the latest version](https://github.com/shotgunsoftware/tk-framework-desktopstartup/releases), and set the environment variable
`SGTK_DESKTOP_STARTUP_LOCATION` to point to its location on disk.

For the `tk-config-basic` component it's a bit more tricky, due to all its dependencies.

1. Run Shotgun Desktop on a workstation connected to the internet. When it starts up, the latest upgrades will be automatically downloaded.
(Ensure `SHOTGUN_DISABLE_APPSTORE_ACCESS` is not set on this machine.)
2. Copy the bundle cache to a shared location where all machines can access it.
3. Set the `SHOTGUN_BUNDLE_CACHE_FALLBACK_PATHS` environment variable on offline machines to point to this location.
4. When Desktop starts up on offline machines, they will pick up the latest upgrades that are available in the bundle cache.

{% include info title="Warning" content="Depending on your network setup, it can sometimes get stuck looking for updates online even though it won't be able to access them. 
In this situation you can set the environment variable `SHOTGUN_DISABLE_APPSTORE_ACCESS` to `\"1\"` to stop it from trying." %}

**CREATE does come with it's own bundled config, however it doesn't seem to have the engines, or atleast doesn't share them when launching Maya for example.**

## Disabling auto updates

### Disabling updates for a single project

1. Determine the version you want to lock your project to. You can find the integration releases [here](https://support.shotgunsoftware.com/hc/en-us/sections/115000020494-Integrations).
2. In Shotgun, create a Pipeline Configuration entity for the project you want to lock down, with the following fields populated (In this example, we are locking down the config to use v1.0.36 of the integrations):
    - Name: `Primary`
    - Project: The project you want to lock down
    - Plugin ids: `basic.*`
    - Descriptor: `sgtk:descriptor:app_store?name=tk-config-basic&version=v1.0.36`
  ![Pipeline Configuration entity with a setup for a project with disabled updates.](../../../toolkit/learning-resources/images/freeze_single_project.png)
 
3. Anyone starting Shotgun Desktop on the project will now always use `v1.0.36`. Any new users starting to work on the project will also get `v1.0.36`.

#### Good to know

- The next time a user launches Desktop while connected to the Internet, `v1.0.36` of the basic config, and all of its related code, will be downloaded to their machine.
- `basic.*` means that all plugins in the basic configuration will pick up this override. If, for example, you wanted to freeze the Nuke and Maya integrations only, you could specify `basic.maya`, `basic.nuke`.
- To test, you can create a duplicate of this Pipeline Configuration entity, and add your username to the `User Restrictions` field. This will restrict the entity such that it's only available to you and won't impact other users. You can then launch Maya or some other software from this duplicate configuration and confirm that it’s running the expected integrations versions. 

#### Known issues

- The Flame integration is namespaced `basic.flame`, and so is implied to be part of `basic.*`. 
However, the Flame integration isn't actually included in the basic config. So, if you are using Flame for a project and implement this override, the Flame integration will stop working.
The solution would be to create an additional Pipeline Configuration override specifically for flame:
    - Name: `Primary`
    - Project: The project you want to lock down (or None for all projects)
    - Plugin ids: `basic.flame`
    - Descriptor: `sgtk:descriptor:app_store?name=tk-config-flameplugin`

### Disabling updates for all projects

To disable updates for all your projects, you can follow the steps in the above example, but leave the `Project` field blank.

With no override in the `Project` field, this Pipeline Configuration entity will apply to all projects, including the “site” project, i.e., the site configuration that is used by Desktop outside of any project.

![Pipeline Configuration entity with a setup for disabled updates on all projects.](../../../toolkit/learning-resources/images/freeze_all_projects.jpg)

#### Good to know

If you lock down your entire site to use, for example, `v1.2.3`, you can still lock down an individual project to use another config (see "Disabling updates for all but one project" bellow).

#### Known issues

Flame would be affected by this. See the ‘Known Issues’ section of the above scenario for a solution.

### Disabling updates for all but one project

If you have disabled updates on all projects as mentioned in the example above, but would like to enable updates on a specific project
You can

- Disabling updates for your site as described in the above section.
- Configure the exception project’s Pipeline Configuration entity to have the following field values:
    - Name: `Primary`
    - Project: The project you want not to lock down
    - Plugin ids: `basic.*`
    - Descriptor: `sgtk:descriptor:app_store?name=tk-config-basic`
    ![Two Pipeline Configurations, one disabling updates to the whole site, and the other enabling updates on a single project](../../../toolkit/learning-resources/images/freeze_all_but_one_project.jpg)

#### Good to know

Note that you’ve omitted the version number from the Descriptor field for the project. This will mean that the project is tracking the latest release of the basic config.

### Upgrading
Scenario: We’re locked down to v1.0.0, and we’d like to upgrade to v2.0.0, but first I want to test out the new version before deploying it to the studio.*
Solution

Duplicate the Pipeline Configuration entity in Shotgun by right-clicking on it and selecting "Duplicate Selected".
Name the cloned config “update test”, and assign yourself to the User Restrictions field.
You will now begin to use this Pipeline Configuration.
Change the descriptor to point to the version you wish to test.
You can invite any users you want to partake in testing by adding them to the User Restrictions field.
Once you are happy with testing, simply update the main Pipeline Configuration to use that version.
Once users restart Desktop or DCCs, the update will be picked up.