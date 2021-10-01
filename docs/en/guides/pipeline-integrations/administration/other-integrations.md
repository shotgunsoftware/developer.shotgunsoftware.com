---
layout: default
title: Other Integrations
pagename: other-integrations
lang: en
---

# Other Integrations

With {% include product %}'s API, you can integrate with a number of third party packages. However, there are a few with which {% include product %} integrates right out-of-the-box.

## Cinesync

Cinesync allows you to have simultaneous synced playback between multiple locations. {% include product %}'s integration allows you to create a Playlist of Versions, play it in Cinesync, and send your Notes made during the session right back into {% include product %}.

For more information, please see [http://www.cinesync.com/manual/latest](http://www.cinesync.com/manual/latest/).

## Deadline

The {% include product %}+Deadline integration allows you to automatically submit rendered Versions to {% include product %} complete with thumbnail, links to frames, and other metadata.

For more information, please see [https://docs.thinkboxsoftware.com/products/deadline/5.2/User%20Manual/manual/shotgunevent.html](https://docs.thinkboxsoftware.com/products/deadline/5.2/User%20Manual/manual/shotgunevent.html).

## Rush

Much like the Deadline integration, the {% include product %}+Rush integration allows you to automatically submit rendered Versions to {% include product %} complete with thumbnail, links to frames, and other metadata.

For more information, please see [http://seriss.com/rush-current/index.html](http://seriss.com/rush-current/index.html).

## Subversion (SVN)

{% include product %} a light but flexible integration, which we use internally, that allows us to track revisions and link them to tickets and releases in {% include product %}. We also provide links to Trac to integrate with an external web SVN repository viewer. This is all done by adding a post-commit hook to SVN, a {% include product %} API script that takes some ENV variables from the commit and then creates a Revision entity in {% include product %} with various fields filled in. It can be modified to match your studio's needs and can be used for a local or hosted installation since it's just using the API. For more information, please see [https://subversion.apache.org/docs](https://subversion.apache.org/docs/).
