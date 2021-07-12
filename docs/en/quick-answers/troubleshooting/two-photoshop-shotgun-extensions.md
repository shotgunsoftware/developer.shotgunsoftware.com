---
layout: default
title: Troubleshooting Photoshop integration when two extensions are installed
pagename: two-photoshop-shotgun-extensions
lang: en
---

# Troubleshooting Photoshop integration when two extensions are installed

## What is the problem?

With the release of our After Effects integration, there is a common plugin that can be used by all Adobe apps that integrate with {% include product %}. As part of this change, we needed to rename the extension so that we could preserve backward compatibility with our older Photoshop integration and make it possible for studios to cleanly transition to the update.

Unfortunately, this also means that it is possible to have two {% include product %} extensions installed as you upgrade:

![Multiple {% include product %} extensions showing in the Photoshop menu](./images/photoshop-extension-panel.png)

The **{% include product %} Adobe Panel** is the new one, and should be used when you are using `v1.7.0` of the Photoshop integration or newer.

## How do I fix it?

To get rid of the older extension, you can remove it from the Adobe install location in your home directory. The folder for this can be seen in the debug output upon Photoshop launch, and is

- OSX: `~/Library/Application Support/Adobe/CEP/extensions/com.sg.basic.ps`
- Windows: `%AppData%\Adobe\CEP\extensions\com.sg.basic.ps`

![Multiple {% include product %} extensions showing in the Photoshop menu](./images/shotgun-desktop-console-photoshop-extension.png)

If you quit Photoshop and remove that directory, then you should have just the one extension on relaunch.

{% include info title="Note" content="If you have the Photoshop integration in multiple environments or multiple configurations and there is a mixture of old and new plugins, then the old plugin will return when somebody launches Photoshop with that older integration. It is good to update Photoshop across the board so that you only need to do this cleanup once." %}
