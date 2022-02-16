---
layout: default
title: urlopen 오류 SSL CERTIFICATE_VERIFY_FAILED 인증서 확인 실패(_ssl.c:726)
pagename: publish-certificate-fail-error-message
lang: ko
---

# `[ERROR publish_creation] <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:726)>`

## 활용 사례

Houdini 17.5에서 디지털 에셋을 위한 도구를 개발하는 동시에 빌드 툴킷 앱을 사용하여 게시된 파일을 등록하는 후크를 실행합니다.

스크립트는 다음 코드를 실행합니다.

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

게시된 파일은 {% include product %}에 올바르게 등록되지만 다음과 같은 오류가 표시됩니다.

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

## 오류의 원인은 무엇입니까?

`cacert.pem` 및 해당 위치를 가리키는 필수 환경 변수 `SHOTGUN_API_CACERTS`가 누락되었습니다.

## 해결 방법

`cacert.pem` 및 위치를 가리키는 환경 변수 `SHOTGUN_API_CACERTS`를 추가합니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/ssl-certificate-error-on-sgtk-util-regiter-publish/3291)하십시오.

