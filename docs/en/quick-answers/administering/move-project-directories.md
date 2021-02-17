---
layout: default
title: How do I move my project directories to a new Local Storage root?
pagename: move-project-directories
lang: en
---

# How do I move my project directories to a new Local Storage root?

{% include warning title="Caution" content="Moving a project location mid project can have many ramifications even extending beyond shotgun Toolkit. It should not be undertaken lightly." %}

Sometimes it's necessary to move your project files (scene files, renders, etc.) to a new root storage location (e.g., from `/mnt/smalldrive` to `/mnt/bigdrive/foo`). This can be done whether you're using a single or multi-root configuration. For example, let's say we want to move your storage named **"asset_storage"**:

- Copy (or move) your project files from the old location to the new location.
- In {% include product %}, navigate to the **Admin > Site Preferences** page and open the **File Management** section.
    ![{% include product %} storage roots section in the site preferences.](./images/shotgun-storage-roots.png)
- Update the Local File Storage named "primary" with the paths for each platform to the new storage for your project files. If you're not using a specific platform, leave it blank.
- Click on the **"Save Changes"** button on the top or bottom of the page.
- Update your `config/core/roots.yml` file in your project configuration to match the new path values you just saved in {% include product %}.

Toolkit stores publish paths as relative paths from a storage root. So with the old storage root the path was expanded like so:

    [asset_storage]/assets/Character/betty => /mnt/smalldrive/assets/Character/betty

With the new storage root definition, the path is now expanded like this:

    [asset-storage]/assets/Character/betty => /mnt/bigdrive/foo/assets/Character/betty

and we don't need to worry about updating any other publish information in {% include product %} or Toolkit! 

{% include warning title="Warning" content="The above steps assume that you are re-pathing the existing storage root. If instead you trash the existing one or create a new one then you will need to re-register all your folders and re-publish your `PublishedFiles` entities." %}

## References

If any of your scene files have references in them that are pointing to the old path, you'll need to update these on your own, or make symlinks to ensure that they get resolved correctly.

## Versions

If you have Version entities in {% include product %} that store information in the Path to Movie or Path to Frames fields that are affected by this change, these will also have to be updated to point to the new location since these fields are string fields that contain an absolute path to the media.