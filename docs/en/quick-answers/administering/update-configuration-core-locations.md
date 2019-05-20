---
layout: default
title: How do I update my pipeline configuration core locations?
pagename: update-configuration-core-locations
lang: en
---

# How do I update my pipeline configuration core locations?

## How do I update my pipeline configuration to use a local core?

If your pipeline configuration has been [setup to use a shared Toolkit core](https://support.shotgunsoftware.com/hc/en-us/articles/219040468#shared), you can essentially undo that process, or "unshare" your core, installing a copy of the Toolkit Core API inside your pipeline configuration using the tank localize command. We refer to this as "localizing" your core. 

1. Open a terminal and navigate to the pipeline configuration you wish to install the Toolkit core into.

        $ cd /sgtk/software/shotgun/scarlet


2. Run the following tank command


        $ ./tank localize

        ...
        ...

        ----------------------------------------------------------------------
        Command: Localize
        ----------------------------------------------------------------------
        
        This will copy the Core API in /sgtk/software/shotgun/studio into the Pipeline
        configuration /sgtk/software/shotgun/scarlet.

        Do you want to proceed [yn]


Toolkit will confirm everything before continuing. A copy of the Toolkit core that your pipeline configuration is currently pointing at, will be copied locally into your pipeline configuration.

3. Toolkit will now copy all of the apps, engines, and frameworks in use by your pipeline configuration locally into the install folder. It will then copy the Toolkit core and update the configuration files in your pipeline configuration to use the newly installed local Toolkit core. {% include info title="Note" content="Your output will vary depending on which apps, engines, and framework versions you have installed." %}


        Copying 59 apps, engines and frameworks...
        1/59: Copying tk-multi-workfiles v0.6.15...
        2/59: Copying tk-maya v0.4.7...
        3/59: Copying tk-nuke-breakdown v0.3.0...
        4/59: Copying tk-framework-widget v0.2.2...
        5/59: Copying tk-shell v0.4.1...
        6/59: Copying tk-multi-launchapp Undefined...
        7/59: Copying tk-motionbuilder v0.3.0...
        8/59: Copying tk-hiero-openinshotgun v0.1.0...
        9/59: Copying tk-multi-workfiles2 v0.7.9...
        ...
        ...
        59/59: Copying tk-framework-qtwidgets v2.0.1...
        Localizing Core: /sgtk/software/shotgun/studio/install/core ->
        /sgtk/software/shotgun/scarlet/install/core
        Copying Core Configuration Files...
        The Core API was successfully localized.

        Localize complete! This pipeline configuration now has an independent API. If
        you upgrade the API for this configuration (using the 'tank core' command), no
        other configurations or projects will be affected.


## How do I update my pipeline configuration to use an existing shared core?
If you have an existing shared Toolkit core, you can update any existing "localized" pipeline configurations to use the shared core using the tank command.

1. Open a terminal and navigate to the pipeline configuration you wish to update.

        $ cd /sgtk/software/shotgun/scarlet


2. Next you'll run the tank attach_to_core command and provide the valid path to the shared core on the current platform. {% include info title="Note" content="The shared studio core must be an equal or later version than the current pipeline configuration's core." %}
    
        $ ./tank attach_to_core /sgtk/software/shotgun/studio 
        ...
        ...
        ----------------------------------------------------------------------
        Command: Attach to core
        ----------------------------------------------------------------------
        After this command has completed, the configuration will not contain an
        embedded copy of the core but instead it will be picked up from the following
        locations:
        
        - Linux: '/mnt/hgfs/sgtk/software/shotgun/studio'
        - Windows: 'z:\sgtk\software\shotgun\studio'
        - Mac: '/sgtk/software/shotgun/studio'

        Note for expert users: Prior to executing this command, please ensure that you
        have no configurations that are using the core embedded in this configuration.

        Do you want to proceed [yn]

 
    Toolkit will confirm everything before continuing. Since this shared core was already setup for multiple platforms, it shows you the location for each.
 
    *If you need to add the location for a new platform, update the config/core/install_location.yml file in the shared core configuration and add the necessary path(s).*

3. Toolkit will now backup the local core API in your pipeline configuration, remove localized core and add the necessary configurations to point your pipeline configuration at the shared core.

        Backing up local core install...
        Removing core system files from configuration...
        Creating core proxy...
        The Core API was successfully processed. 

    If you decide later you would like to localize the Toolkit core inside your pipeline configuration (ie. detaching your pipeline configuration from the shared core and using a locally installed version), you can do so using the tank localize command.

## How do I share the Toolkit core between Projects?

Currently when you setup a project with SG Desktop, the Toolkit core API is "localized", which means it's installed inside the pipeline configuration. This means every pipeline configuration is a fully self-contained Toolkit installation. You may prefer to have version of the Toolkit Core API that is shared between projects which can minimize maintenance and ensure all of your projects are using the same core code. We sometimes refer to this as a **"shared studio core"**.

Here's how to create a new Toolkit Core API configuration that can be shared between different project pipeline configurations. 

1. Open a terminal and navigate to an existing pipeline configuration that contains the Toolkit Core version you wish to share. Once the process is complete, this this pipeline configuration will no longer be localized, but will use the newly created shared core.

        $ cd /sgtk/software/shotgun/pied_piper
 

2. Run the following tank command to copy the Toolkit core to an external location on disk. You need to provide the location this path can be found on all platforms (linux_path, windows_path, mac_path). We recommend using quotes for each path. If you don't use Toolkit on a particular platform, you can simply specify an empty string "". 

        $ ./tank share_core "/mnt/sgtk/software/shotgun/studio" "Z:\sgtk\software\shotgun\studio" \ "/sgtk/software/shotgun/studio"
 

3. You will be shown a summary of the change that is about to be made before Toolkit will proceed.

        ----------------------------------------------------------------------
        Command: Share core
        ----------------------------------------------------------------------
        This will move the embedded core API in the configuration 
        '/sgtk/software/shotgun/pied_piper'.
        After this command has completed, the configuration will not contain an
        embedded copy of the core but instead it will be picked up from the following
        locations:
        - Linux: '/mnt/sgtk/software/shotgun/studio'
        - Windows: 'Z:\sgtk\software\shotgun\studio'
        - Mac: '/sgtk/software/shotgun/studio'
        Note for expert users: Prior to executing this command, please ensure that you
        have no configurations that are using the core embedded in this configuration.
        Do you want to proceed [yn]

4. Toolkit will copy the core installation to your new shared location and will update your existing pipeline configuration to point to the new shared core.

        Setting up base structure...
        Copying configuration files...
        Copying core installation...
        Backing up local core install...
        Removing core system files from configuration...
        Creating core proxy...
        The Core API was successfully processed.
 
You can now use this new shared core from other pipeline configurations. In order to update a pipeline configuration to use an existing shared core (like the one you just created), you can use the `tank attach_to_core` command.