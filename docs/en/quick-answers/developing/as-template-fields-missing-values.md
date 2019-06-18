---
layout: default
title: as_template_fields() Is Missing Values That Exist in My Context
pagename: as-template-fields-missing-values
lang: en
---

# as_template_fields() is missing values that exist in my context

The [as_template_fields()](https://developer.shotgunsoftware.com/tk-core/core.html?#sgtk.Context.as_template_fields) method uses the path cache so if the folders corresponding to the keys in your template haven't been created yet, then you won't get the fields returned. This can happen for a couple of reasons:

- Your template definition and schema need to be in sync. If you've modified either this template definition or your schema in your pipeline configuration, but not both, the expected fields will not be returned.
- The folders have not been created for this particular context. If they haven't been created yet, there will be no matching records in the path cache and the expected fields will not be returned.
