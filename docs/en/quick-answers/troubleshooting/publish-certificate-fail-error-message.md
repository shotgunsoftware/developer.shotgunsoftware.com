---
layout: default
title: urlopen error SSL CERTIFICATE_VERIFY_FAILED certificate verify failed (_ssl.c:726)
pagename: publish-certificate-fail-error-message
lang: en
---

# `[ERROR publish_creation] <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:726)>`

## Use case

Developing tools for digital assets in Houdini 17.5, while using a build toolkit app, I execute a hook which try to register the published file.

The script executes the code:

        args = {
            "tk": self.parent.tank,
            "context": self.parent.engine.context,
            "path": esto['operator'],
            "name": os.path.basename(esto['operator']),
            "version_number": 6,
            "published_file_type": "Library item",
        }
        print 'sgtk: ', sgtk.__file__
        sg_publish = sgtk.util.register_publish(**args)

The published files is registered correctly in {% include product %}, but it presents the following error:

```
---------------------------------------------------------------------------
[ERROR publish_creation] <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:726)>
Traceback (most recent call last):
  File "/home/cvizcarra/ollinDev/PIGS_kDev/install/core/python/tank/util/shotgun/publish_creation.py", line 308, in register_publish
    tk.shotgun.upload_thumbnail(published_file_entity_type, entity.get("id"), no_thumb)
  File "/home/cvizcarra/ollinDev/PIGS_kDev/install/core/python/tank_vendor/shotgun_api3/shotgun.py", line 2173, in upload_thumbnail
    field_name="thumb_image", **kwargs)
  File "/home/cvizcarra/ollinDev/PIGS_kDev/install/core/python/tank_vendor/shotgun_api3/shotgun.py", line 2263, in upload
    tag_list, is_thumbnail)
  File "/home/cvizcarra/ollinDev/PIGS_kDev/install/core/python/tank_vendor/shotgun_api3/shotgun.py", line 2383, in _upload_to_sg
    result = self._send_form(url, params)
  File "/home/cvizcarra/ollinDev/PIGS_kDev/install/core/python/tank_vendor/shotgun_api3/shotgun.py", line 3806, in _send_form
    resp = opener.open(url, params)
  File "/opt/hfs17.5.173/python/lib/python2.7/urllib2.py", line 429, in open
    response = self._open(req, data)
  File "/opt/hfs17.5.173/python/lib/python2.7/urllib2.py", line 447, in _open
    '_open', req)
  File "/opt/hfs17.5.173/python/lib/python2.7/urllib2.py", line 407, in _call_chain
    result = func(*args)
  File "/opt/hfs17.5.173/python/lib/python2.7/urllib2.py", line 1241, in https_open
    context=self._context)
  File "/opt/hfs17.5.173/python/lib/python2.7/urllib2.py", line 1198, in do_open
    raise URLError(err)
URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:726)>
Traceback (most recent call last):
  File "/home/cvizcarra/ollinDev/PIGS_kDev/config/hooks/publish_digital_asset.py", line 66, in register_publishedfile
    description='Alembic nodes.')
  File "/home/cvizcarra/ollinDev/PIGS_kDev/install/core/python/tank/log.py", line 503, in wrapper
    response = func(*args, **kwargs)
  File "/home/cvizcarra/ollinDev/PIGS_kDev/install/core/python/tank/util/shotgun/publish_creation.py", line 323, in register_publish
    entity=entity
ShotgunPublishError: Unable to complete publishing because of the following error: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:726)>, although PublishedFile PIGS_libary_tool_hda_asasas_v017.hda (id: 114715
) was created.
---------------------------------------------------------------------------
```

## What’s causing the error?
Missing `cacert.pem` and the required environment variable `SHOTGUN_API_CACERTS` pointing to that location.

## How to fix
Add tje `cacert.pem` and environment variable `SHOTGUN_API_CACERTS` pointing to the location.

[See the full thread in the community](https://community.shotgridsoftware.com/t/ssl-certificate-error-on-sgtk-util-regiter-publish/3291).

