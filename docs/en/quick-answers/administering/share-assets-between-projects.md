---
layout: default
title: How do I share assets between projects?
pagename: share-assets-between-projects
lang: en
---

# How do I share assets between projects?

It is common to have a project that is used as an Asset Library, containing assets that can be loaded into shots in other projects.

With the introduction of the Linked Projects field on the Asset entity, you can now add a single tab to the [Loader app](https://help.autodesk.com/view/SGSUB/ENU/?guid=SG_Supervisor_Artist_sa_integrations_sa_integrations_user_guide_html#the-loader) that includes all Linked Projects. In order to do so, you'll have to define this in the Loader settings for the engine and environment you're working in. You'll potentially have to update this in multiple places. 

```yaml
- caption: Assets - Linked
    entity_type: Asset
    filters:
      - [linked_projects, is, "{context.project}"]
    hierarchy: [project.Project.name, sg_asset_type, code]
```

You can refer to the Alias Engine settings [in the tk-multi-loader2.yml configuration file](https://github.com/shotgunsoftware/tk-config-default2/blob/a5af14aefbafaec6cf0933db83343f600eb75870/env/includes/settings/tk-multi-loader2.yml#L343-L347) included with [tk-config-default2](https://github.com/shotgunsoftware/tk-config-default2) as it is the default behavior there.

---

Before introducing the Linked Projects field on Assets, the initial way to achieve cross-Project sharing was to add a tab to the [Loader app](https://help.autodesk.com/view/SGSUB/ENU/?guid=SG_Supervisor_Artist_sa_integrations_sa_integrations_user_guide_html#the-loader) that lists assets from a specific Asset Library project.

For example, to add this to the [Maya engine in the shot step environment](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-multi-loader2.yml#L122), you'd add this snippet:

```yaml
- caption: Asset Library
    hierarchy: [project, sg_asset_type, code]
    entity_type: Asset
    filters:
      - [project, is, {'type': 'Project', 'id': 207}]
```

replacing `207` with your library project's ID.

When you're working in the shot step environment in Maya now, this will add a new tab that will display all the available publishes in that project. If you want to add this tab to the Loader in other engines (e.g., Nuke, 3dsmax, etc.) you'll have to modify the `tk-multi-loader2` settings for each of those engines as well. If you want to enable this in other environments, you'll have to go through the same steps in the asset step environment, and any other environments you want it to be in. A bit tedious, but it allows some fine-grain control.

With these settings, you should get the Loader app to show a tab that lists publishes from your identified project.

---

{% include info title="Note" content="This initial technique is still included here as it does offer a way to have a different tab per Project identified within the Loader." %}

To learn more about web-based cross-Project Asset linking, visit our [Cross-Project Asset Linking documentation here](https://help.autodesk.com/view/SGSUB/ENU/?guid=SG_Administrator_ar_site_configuration_ar_cross_project_asset_linking_html).
