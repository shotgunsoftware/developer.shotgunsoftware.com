---
layout: default
title: Demo
pagename: tk-multi-demo
lang: en
---

# Demo

The Demo App provides live demonstrations of {% include product %}'s native developer platform components including the {% include product %} Utilities framework, the Qt Widgets frameworks and Toolkit core.

![Demo App](../images/apps/multi-demo-demo_app.png)

Each demo displayed in the app includes a working, interactive UI that shows how to use one or more components of the native platform. In addition, the code that is running is readily available to copy and paste into your own app.

![Demo Basics](../images/apps/multi-demo-help_demo.png)

The app is simple to use. Just select a demo from the list on the left and then interact with the components on the right. Some demos are as simple as displaying a single widget from the Qt Widgets framework. Other demos provide examples of how {% include product %} platform components are commonly wired up for use in production apps.

![Example Demo](../images/apps/multi-demo-delegate_demo.png)

![Code Tab](../images/apps/multi-demo-code_tab.png)

New demos will be added as new components are added to the platform and as time permits. If there is a common pattern of component usage or a demo that you'd like to see, please let us know by [submitting a ticket](https://support.shotgunsoftware.com/hc/en-us/requests/new).

## Installation

To install the demo app, run the following command:

```
tank install_app project tk-shell tk-multi-demo
```

Once installed, you can run the following command to launch the app:

`./tank demos`
