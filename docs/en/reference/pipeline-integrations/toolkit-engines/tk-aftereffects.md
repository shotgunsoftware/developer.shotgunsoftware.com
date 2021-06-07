---
layout: default
title: After Effects
pagename: tk-aftereffects
lang: en
---

# After Effects

The {% include product %} engine for After Effects provides a platform for integrating {% include product %} into your After Effects workflow. It consists of a standard {% include product %} Toolkit engine and relies on the [tk-framework-adobe](https://github.com/shotgunsoftware/tk-framework-adobe) (CEP).

Once enabled, a **{% include product %} Adobe Panel** panel becomes available in After Effects. It displays information about the current {% include product %} context as well as the commands that are registered for the apps installed in that context.

![Engine](../images/engines/aftereffects_extension.png)

# Interface Overview

The {% include product %} extension panel uses the same color palette and basic layout as native After Effects panels. It is comprised of five components:

![components](../images/engines/extension_components.png)

1. **Context Header** - Thumbnail and fields for the current context.
2. **Favorites Shelf** - Designed to show the most commonly-used apps for the current context.
3. **Command List** - All non-favorited commands for the current context.
4. **Context Menu** - Additional context-related commands and debugging tools.
5. **Logging Console** - A console overlay that displays logging output for debugging.

# Installation

Installation of the {% include product %} Engine for After Effects follows the same protocol as the other {% include product %} integrations. For information on installing engines and apps, see the [Administering Toolkit](https://support.shotgunsoftware.com/hc/en-us/articles/219033178-Administering-Toolkit) article. In addition, you can reference the [default toolkit config](https://github.com/shotgunsoftware/tk-config-default2) as an example of how to configure the integration.

# Enabling the extension

Once the extension is installed, it will need to be launched via the extensions menu in After Effects.

![Menu](../images/engines/extension_menu.png)

This will only need to be done once and the {% include product %} extension panel can remain in the After Effects layout without having to be enabled on subsequent launches.

Once enabled, and on future launches, the extension panel will display a loading screen while the {% include product %} integration is bootstrapping.

This screen typically displays for a few seconds before the current context is determined and the commands are displayed.

# Interface components

The following sections outline the components of the {% include product %} After Effects integration.

## Context header

The context header is a customizable area which can display information about the current {% include product %} context.

![Header](../images/engines/extension_header.png)

The context is determined by the currently-active document. Once the context is determined by the engine, the header will update to display the context's thumbnail field detail. The field information is controlled by a hook. For information on how to customize the field display, see the **Context Fields Display Hook** section below.

It should also be noted that the context switching will only be recognized in if {% include product %} open was used.

## Favorites shelf

The favorites shelf is similar to the menu favorites available in other {% include product %} DCC integrations such as Maya and Houdini. This section of the interface makes the most commonly used Toolkit apps readily available and easy to find just under the context header.

![Shelf](../images/engines/extension_shelf.png)

The shelf displays the favorited commands as buttons that, when moused over, transition from grayscale to color and display their name in the label at the top. Tooltips for the buttons will show by hovering the mouse above them.

Clicking one of the buttons will trigger the callback for the registered command to execute.

For details on how to specify command favorites, see the **Shelf Favorites** section below.

## Command list

The command list shows the other "regular" commands that are registered for the current context.

![Commands](../images/engines/extension_commands.png)

Typically, apps installed within a pipeline configuration will register one or more commands that are displayed here. If the commands are not identified as favorites, and are not identified as context-menu commands, they will display here.

The command list buttons behave in a manner similar to those in the favorites shelf. The only real difference is that they display as a list with the full name to the right of their icon.

## Context menu

Any commands registered as context menu commands will show in the {% include product %} extension panel's context menu.

![Context Menu](../images/engines/extension_context_menu.png)

Like the other command areas, these commands will change along with the context. Commands such as **Jump to {% include product %}** and **Jump to Filesystem** will always be available here.

## Logging console

The logging console shows all of the logging output from both the CEP Javascript interpreter and Toolkit's Python process.

![Console](../images/engines/extension_console.png)

If there are any issues with the extension that require support, the logging console output is extremely useful for helping the {% include product %} support team debug the problem.

# Configuration and technical details

The following sections outline some of the more technical aspects of the integration to help configure the integration to the specific needs of your studio pipeline.

## PySide

The {% include product %} engine for After Effects relies on PySide. Please see the official instructions for [Installing PySide](http://pyside.readthedocs.io/en/latest/installing/index.html).

## CEP extension

The extension itself is bundled with the engine and the engine handles installation automatically on the first launch of After Effects. The extension is installed on the artist's local machine in the standard, OS-specific CEP extension directories:

```shell
# Windows
> C:\Users\[user name]\AppData\Roaming\Adobe\CEP\extensions\

# OS X
> ~/Library/Application Support/Adobe/CEP/extensions/
```

Each time After Effects is launched, the engine bootstrap code will check the version of the extension that is bundled with the engine against the version that is installed on the machine. This means that after an engine update, assuming a new version of the extension came with it, the installed extension will be automatically updated to the newly-bundled version.

## Configuring favorites

The **Favorites Shelf** can be configured to display any of the registered commands for your installed apps. To do this, simply add the `shelf_favorites` setting to the `tk-aftereffects` section of your environment configuration. Here's an example:

```yaml
shelf_favorites:
    - {app_instance: tk-multi-workfiles2, name: File Save...}
    - {app_instance: tk-multi-workfiles2, name: File Open...}
    - {app_instance: tk-multi-publish, name: Publish...}
    - {app_instance: tk-multi-snapshot, name: Snapshot...}
```

The value of the setting is a list of dictionaries identifying a registered command provided by one of the installed apps in the configuration. The `app_instance` key identifies a particular installed app and the `name` key matches the command's display name registered by that app. In the example above, you can see four favorited commands: the file open and save dialogs from the `tk-multi-workfiles2` app as well as the standard Toolkit publish and snapshot dialogs. These four commands will now show in the favorites shelf.

## Environment variables

To aid in debugging, there are a set of environment variables that change some of the engine's default values:

- `SHOTGUN_ADOBE_HEARTBEAT_INTERVAL` - The Python heartbeat interval in seconds (default is 1 second).
- `SHOTGUN_ADOBE_HEARTBEAT_TOLERANCE` - The number of heartbeat errors before quitting (default is 2). The legacy environment variable
- `SGTK_PHOTOSHOP_HEARTBEAT_TOLERANCE` is also respected if set.
- `SHOTGUN_ADOBE_NETWORK_DEBUG` - Include additional networking debug messages when logging output. The legacy environment variable
- `SGTK_PHOTOSHOP_NETWORK_DEBUG` is also respected if set.
- `SHOTGUN_ADOBE_PYTHON` - The path to the Python executable to use when launching the engine. If not set, the system Python is used. If Photoshop is launched from a Python process, like {% include product %} Desktop or via the tk-shell engine, the Python used by that process will be used by the Photoshop integration.

Note: Additional environment variables exist in the Adobe Framework. For details, please see the [developer documentation](https://developer.shotgridsoftware.com/tk-framework-adobe/).


## Context fields display hook

The engine comes with a hook to control the fields displayed in the **Context Header** section of the panel. There are two methods in the hook that can be overridden to customize what is displayed.

The first method is the `get_entity_fields()` method. This method accepts an entity type representing the current {% include product %} context. The expected return value is a list of fields for that entity that should be queried for display. The engine itself handles querying the data asynchronously.

Once the data has been queried from {% include product %}, the second method in the hook is called. This method, `get_context_html()`, receives the context entity dictionary populated with the queried fields specified by the `get_entity_fields()` method. The expected return value is a string containing formatted HTML to display the queried entity fields.

The [default hook implementation](https://github.com/shotgunsoftware/tk-aftereffects/blob/master/hooks/context_fields_display.py) is a good reference as to what is required by these methods.

It should be noted that the engine will always display the entity thumbnail if one is available.

## Import Footage Hook

The engine comes with a hook to control the import behaviour of certain file types. One may want that a psd file will be imported as single layer instead of a composition. In this case the this hook may be used to overwrite this behaviour.

The [default hook implementation](https://github.com/shotgunsoftware/tk-aftereffects/blob/master/hooks/import_footage.py)

## After Effects API

Please see the [developer documentation](https://developer.shotgridsoftware.com/tk-aftereffects) for details on the After Effects API.


