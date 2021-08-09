---
layout: default
title: WARNING Storage Root Primary Could Not Be Mapped to a SG Local Storage
pagename: review-error-message-root
lang: en
---

# WARNING: Storage Root Primary Could Not Be Mapped to a SG Local Storage

## Use case

When attempting to set up a project and use Google Drive as primary storage using Drive File stream, the Project Wizard issues a warning in the console when accessing the storage configuration:

`[WARNING] Storage root primary could not be mapped to a SG local storage`

Pressing **continue** does not work.

## How to fix

This issue can be caused when there is a typo in the storage name.  Ensure it matches exactly the name of the Google Drive.

In addition, when using Google Drive, ensure it is set to always keep files locally, to avoid duplicate projects appearing.

## Related Links

[See the full thread in the community](https://community.shotgridsoftware.com/t/11185)