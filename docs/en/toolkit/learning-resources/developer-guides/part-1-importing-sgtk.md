---
layout: default
title: Importing sgtk
pagename: part-1-importing-sgtk-guide
lang: en
---

# Importing sgtk

The sgtk API is contained in a python package called `sgtk`. Each Toolkit configuration has it's own copy of the API.
In order to use the API on a project's configuration, you must import the sgtk package from the configuration 
you wish to work with, importing it from a different configruation will lead to errors.

{% include info title="Note" content="You may sometimes come across references to a `tank` package, this is the legacy name for the same thing,
 whilst both work `sgtk` is the correct name to use going forward." %}

To import the API you need to make sure that the path to the [core's python folder](https://github.com/shotgunsoftware/tk-core/tree/v0.18.167/python)
exists in the `sys.path`. 
However for this example we recommend that you run this code in the Shotgun Python console via Shotgun Desktop.
This will mean tht the correct sgtk API path is already added to your sys path. Equally you don't need to add the path
if you are running this code within Software where the Shotgun integration is already running.

When running your code in an environment where Shotgun is already started you can import the API by simply writing:

```python
import sgtk
``` 

If you are wanting to use the API outside of a Shotgun integration, for example you might wish to test it in 
your favourite IDE, then you will need to set the path to the API first:

```python
import sys
sys.path.append("/shotgun/configs/my_project_config/install/core/python")

import sgtk
```

If your using distributed configs and your wanting to import `sgtk` in an environment where Toolkit hasn't already been bootstrapped, 
you will need to take a different approach, please see the bootstrapping guide for more details.

Now you've imported the sgtk API your ready to start using it. Next up is getting a `Sgtk` instance. 