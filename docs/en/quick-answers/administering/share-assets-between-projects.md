---
layout: default
title: How do I share assets between projects?
pagename: share-assets-between-projects
lang: en
---

# How do I share assets between projects?

It's not uncommon to have a project that's used as an Asset Library, containing assets that can be loaded into shots in other projects.

To achieve this, you can add a tab to the [Loader app](https://developer.shotgridsoftware.com/a4c0a4f1/?title=Loader) that lists assets from this Asset Library project. In order to do so, you'll have to define this in the Loader settings for the engine and environment you're working in. You'll potentially have to update this in multiple places.

For example, to add this to the [Maya engine in the shot step environment](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-multi-loader2.yml#L122), you'd add this snippet:

```yaml
caption: Asset Library
hierarchy: [project, sg_asset_type, code]
entity_type: Asset
filters:
- [project, is, {'type': 'Project', 'id': 207}]
```

replacing `207` with your library project's ID.

When you're working in the shot step environment in Maya now, this will add a new tab that will display all the available publishes in that project. If you want to add this tab to the Loader in other engines (e.g., Nuke, 3dsmax, etc.) you'll have to modify the `tk-multi-loader2` settings for each of those engines as well. If you want to enable this in other environments, you'll have to go through the same steps in the asset step environment, and any other environments you want it to be in. A bit tedious, but it allows some fine-grain control.

With these settings, you should get the Loader app to show a tab that lists publishes from your generic project.