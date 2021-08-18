---
layout: default
title: Loader
pagename: tk-multi-loader2
lang: en
---

# Loader

This document describes functionality only available if you have taken control over a Toolkit configuration. Please refer to the [{% include product %} Integrations User Guide](https://developer.shotgridsoftware.com/d587be80/) for details.

## Configuration

The loader is highly configurable and you can set it up in many different ways. There are two main configuration areas:

- Setting up what tabs and what content to display in the left hand side tree view.
- Controlling which actions to display for different publishes and controlling what the actions actually do.

The following sections will give a high level overview how you can configure the loader.
For technical minutiae relating to the configuration, please see the separate section further down in the documentation.

### The tree view

The tree view is highly configurable and you can control the content of the various tabs using standard {% include product %} filter syntax. Each tab consists of a single {% include product %} API query which is grouped into a hierarchy. You can add arbitrary filters to control which items are being shown, and you can use the special keywords `{context.entity}`, `{context.project}`, `{context.project.id}`, `{context.step}`, `{context.task}` and `{context.user}` to scope a query based on the current context. Each of these keywords will be replaced with the relevant context information, either `None`, if that part of the context is not populated or a standard {% include product %} link dictionary containing the keys id, type and name.

By default, the loader will show assets and shots belonging to the current project. By reconfiguring, this could easily be extended to for example show items from other projects (or a specific asset library project for example). You could also for example use filters to only show items with certain approval status or group items by status or by other {% include product %} fields. Below are some sample configuration settings illustrating how you could set up your tree view tabs:

```yaml
# An asset library tab which shows assets from a specific
# {% include product %} project
caption: Asset Library
entity_type: Asset
hierarchy: [sg_asset_type, code]
filters:
- [project, is, {type: Project, id: 123}]

# Approved shots from the current project
caption: Shots
hierarchy: [project, sg_sequence, code]
entity_type: Shot
filters:
- [project, is, '{context.project}']
- [sg_status_list, is, fin]

# All assets for which the current user has tasks assigned
caption: Assets
entity_type: Task
hierarchy: [entity.Asset.sg_asset_type, entity, content]
filters:
- [entity, is_not, null]
- [entity, type_is, Asset]
- [task_assignees, is, '{context.user}']
- [project, is, '{context.project}']
```

### Filtering publishes

It is possible to apply a {% include product %} filter to the publish query that the loader carries out when it loads publish data from {% include product %}. This is controlled via the `publish_filters` parameter and can be used for example to hide publishes that have not been approved or where their associated review version has not been approved.  

### Help, no actions are showing up!

The loader comes with a number of different *actions* for each engine. For example, in the case of Nuke, there are two actions: "import script" and "create read node". Actions are defined in hooks, meaning that you can modify their behaviour or add additional actions if you wanted to. Then, in the configuration for the loader, you can bind these actions to certain *publish types* you have. Binding an action to a publish type basically means that the action will appear on the actions menu for all items of that type inside the loader.

As an example, by default, the mappings for Nuke are set up like this:

```
action_mappings:
  Nuke Script: [script_import]
  Rendered Image: [read_node]
```

If you are finding that no action menus are showing up, it may be because you have chosen different names for the publish types that you are using. In that case, go into the config and add those types in order to have them show up inside the loader.

### Managing actions

For each application that the loader supports, there is an actions hook which implements the actions that are supported for that application. For example, with something like Maya, the default hook will implement the `reference`, `import` and `texture_node` actions, each carrying out specific Maya commands to bring content into the current Maya scene. As with all hooks, it is perfectly possible to override and change these, and it is also possible to create a hook that derives from the built in hook, making it easy to add additional actions to a built-in hook without having to duplicate lots of code.

Once you have defined a list of actions in your actions hook, you can then bind these actions to Publish File types. For example, if you have a Publish File type in your pipeline named "Maya Scene" you can bind this in the configuration to the `reference` and `import` actions that are defined in the hook. By doing this, Toolkit will add a reference and an import action to each Maya Scene publish that is being shown. Separating the Publish Types from the actual hook like this makes it easier to reconfigure the loader for use with a different publish type setup than the one that comes with the default configuration.  

The loader uses Toolkit's second generation hooks interface, allowing for greater flexibility. This hook format uses an improved syntax. You can see this in the default configuration settings that are installed for the loader, looking something like this:

```
actions_hook: '{self}/tk-maya_actions.py'
```

The `{self}` keyword tells Toolkit to look in the app `hooks` folder for the hook. If you are overriding this hook with your implementation, change the value to `{config}/loader/my_hook.py`. This will tell Toolkit to use a hook called `hooks/loader/my_hook.py` in your configuration folder.

Another second generation hooks feature that the loader is using is that hooks no longer need to have an `execute()` method. Instead, a hook is more like a normal class and can contain a collection of methods that all makes sense to group together. In the case of the loader, your actions hook will need to implement the following two methods:

```
def generate_actions(self, sg_publish_data, actions, ui_area)
def execute_multiple_actions(self, actions)
```

For more information, please see the hook files that come with the app. The hooks also take advantage of inheritance, meaning that you don't need to override everything in the hook, but can more easily extend or augment the default hook in various ways, making hooks easier to manage.

Note that in versions previous to `v1.12.0`, the application invoked the `execute_action` hook to execute an action. Newer versions invoke the `execute_multiple_actions` hook. In order to provide backward compatibility with existing hooks, the `execute_multiple_actions` hook actually invokes `execute_action` for each actions provided. If the application is reporting that the `execute_multiple_actions` hook is not defined after upgrading to `v1.12.0` or later, make sure that the `actions_hook` setting in your environment correctly inherits from the builtin hook `{self}/{engine_name}_actions.py`. To learn more about how you can derive custom hooks from the builtin ones, see our [Toolkit reference documentation](http://developer.shotgridsoftware.com/tk-core/core.html#hook).

LINKBOX_DOC:5#The%20hook%20data%20type:Learn more about the second gen hook format here.

By using inheritance in your hook, it would be possible to add additional actions to the default hooks like
this:

```python
import sgtk
import os

# toolkit will automatically resolve the base class for you
# this means that you will derive from the default hook that comes with the app
HookBaseClass = sgtk.get_hook_baseclass()

class MyActions(HookBaseClass):

    def generate_actions(self, sg_publish_data, actions, ui_area):
        """
        Returns a list of action instances for a particular publish.
        This method is called each time a user clicks a publish somewhere in the UI.
        The data returned from this hook will be used to populate the actions menu for a publish.

        The mapping between Publish types and actions are kept in a different place
        (in the configuration) so at the point when this hook is called, the loader app
        has already established *which* actions are appropriate for this object.

        The hook should return at least one action for each item passed in via the
        actions parameter.

        This method needs to return detailed data for those actions, in the form of a list
        of dictionaries, each with name, params, caption and description keys.

        Because you are operating on a particular publish, you may tailor the output
        (caption, tooltip etc) to contain custom information suitable for this publish.

        The ui_area parameter is a string and indicates where the publish is to be shown.
        - If it will be shown in the main browsing area, "main" is passed.
        - If it will be shown in the details area, "details" is passed.
        - If it will be shown in the history area, "history" is passed.

        Please note that it is perfectly possible to create more than one action "instance" for
        an action! You can for example do scene introspection - if the action passed in
        is "character_attachment" you may for example scan the scene, figure out all the nodes
        where this object can be attached and return a list of action instances:
        "attach to left hand", "attach to right hand" etc. In this case, when more than
        one object is returned for an action, use the params key to pass additional
        data into the run_action hook.

        :param sg_publish_data: {% include product %} data dictionary with all the standard publish fields.
        :param actions: List of action strings which have been defined in the app configuration.
        :param ui_area: String denoting the UI Area (see above).
        :returns List of dictionaries, each with keys name, params, caption and description
        """

        # get the actions from the base class first
        action_instances = super(MyActions, self).generate_actions(sg_publish_data, actions, ui_area)

        if "my_new_action" in actions:
            action_instances.append( {"name": "my_new_action",
                                      "params": None,
                                      "caption": "My New Action",
                                      "description": "My New Action."} )

        return action_instances


    def execute_action(self, name, params, sg_publish_data):
        """
        Execute a given action. The data sent to this be method will
        represent one of the actions enumerated by the generate_actions method.

        :param name: Action name string representing one of the items returned by generate_actions.
        :param params: Params data, as specified by generate_actions.
        :param sg_publish_data: {% include product %} data dictionary with all the standard publish fields.
        :returns: No return value expected.
        """

        # resolve local path to publish via central method
        path = self.get_publish_path(sg_publish_data)

        if name == "my_new_action":
            # do some stuff here!

        else:
            # call base class implementation
            super(MyActions, self).execute_action(name, params, sg_publish_data)
```

We could then bind this new action to a set of publish types in the configuration:

```yaml
action_mappings:
  Maya Scene: [import, reference, my_new_action]
  Maya Rig: [reference, my_new_action]
  Rendered Image: [texture_node]
```

By deriving from the hook as shown above, the custom hook code only need to contain the actual added business logic which makes it easier to maintain and update.

## Reference

The following methods are available on the app instance.

### open_publish()
Presents an 'Open File' style version of the Loader that allows the user to select a publish.  The selected publish is then returned.  The normal actions configured for the app are not permitted when run in this mode.

app.open_publish( `str` **title**, `str` **action**, `list` **publish_types** )

**Parameters and Return Value**
* `str` **title** - The title to be displayed in the open publish dialog.
* `str` **action** - The name of the action to be used for the 'open' button.
* `list` **publish_types** - A list of publish types to use to filter the available list of publishes.  If this is empty/None then all publishes will be shown.
* **Returns:** A list of {% include product %} entity dictionaries that were selected by the user.

**Example**

```python
>>> engine = sgtk.platform.current_engine()
>>> loader_app = engine.apps.get["tk-multi-loader2"]
>>> selected = loader_app.open_publish("Select Geometry Cache", "Select", ["Alembic Cache"])
>>> print selected
```
