---
layout: default
title: How can I disable ShotGrid Desktop's browser integration?
pagename: disable-browser-integration
lang: en
---

# How can I disable {% include product %} Desktop's browser integration?

To disable browser integration, follow these two simple steps.

1. Create or open the text file at:

        Windows: %APPDATA%\{% include product %}\preferences\toolkit.ini
        Macosx: ~/Library/Preferences/{% include product %}/toolkit.ini
        Linux: ~/.{% include product %}/preferences/toolkit.ini

2. Add the following section:

        [BrowserIntegration]
        enabled=0

See complete instructions on how to configure the browser integration in our [Admin guide](https://developer.shotgridsoftware.com/8085533c/?title=ShotGrid+Integrations+Admin+Guide#toolkit-configuration-file).

**Alternate method**

If you've taken over your Toolkit pipeline configuration, an alternative would be to remove the [`tk-{% include product %}` engine from your environments](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/project.yml#L48) so that it can't load any actions.