---
layout: default
title: Python API best practices
pagename: python-api-best-practices
lang: en
---

# Python API best practices


Below is a list of best practices when using the {% include product %} Python API.

## Performance

1.  Don’t request any fields you don’t need for your script. Including additional fields can add unnecessary overhead to your request.
2.  Make your filters as specific as possible. Wherever possible, filtering in the API query rather than parsing it after you have the results back is better.
3.  Exact match filters will perform better than partial match filters. For example, using “is” will perform better than “contains”.

## Control and debugging

1.  Use separate keys for scripts, so you have a unique key for every tool. This is invaluable for debugging.
2.  Make sure that every script has an owner or maintainer and the information is up to date in your Scripts page, under the Admin menu.
3.  Consider creating a [read-only permission group for API users](https://developer.shotgridsoftware.com/bbae2ca7/) . Many scripts only need read access and this can limit your exposure to accidental changes.
4.  Track which keys are in use so that old scripts can be removed. Some studios script auditing information in their API wrapper, to make this easier.
5.  Check entity names and fields. {% include product %} has two names for each field: a display name that’s used in the UI (and isn’t necessarily unique) and an internal field name that’s used by the API. Because the display name can be changed at any point, you can’t reliably predict the field name from the display name. You can see field names by going to the fields option in the Admin menu, or you can use the `schema_read(), schema_field_read(), schema_entity_read() methods` , as described in [http://developer.shotgridsoftware.com/python-api/reference.html?%20read#working-with-the-shotgun-schema](http://developer.shotgridsoftware.com/python-api/reference.html?%20read#working-with-the-shotgun-schema).

## Design

1.  For larger studios especially, consider having an API isolation layer—a wrapper. This isolates your tools from changes in the {% include product %} API. It also means that you can control API access, manage debugging, track auditing, etc. without needing to modify the API itself.
2.  Use the latest version of the API. It will contain bug fixes and performance improvements.
3.  Be aware of where the script will be run from. A script running on a render farm, where it will be calling to {% include product %} for the same information 1000’s of times per minute, can impact site performance. In cases like these, consider implementing a read-only caching layer to alleviate unnecessarily repetitive calls.
4.  You can turn off event generation for scripts. This is most useful for scripts that are running very often whose events you won’t need to track later. For scripts that run extremely often, this is highly recommended as the event log can otherwise become very large.