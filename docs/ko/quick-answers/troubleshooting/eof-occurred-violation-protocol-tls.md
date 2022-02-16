---
layout: default
title: 프로토콜을 위반하여 EOF 발생
pagename: eof-occurred-violation-protocol-tls
lang: ko
---

# SSLError: [Errno 8] _ssl.c:504: 프로토콜을 위반하여 EOF 발생

## 활용 사례

데스크톱에서 Nuke 10.5를 열면 다음과 같은 SSL 오류가 표시됩니다.

```
[13:57.14] ERROR: Shotgun Error: [ERROR tk-nuke] App /media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2 failed to initialize. It will not be loaded.
Traceback (most recent call last):
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank/platform/engine.py”, line 2792, in __load_apps
app.init_app()
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/app.py”, line 26, in init_app
self._tk_multi_workfiles = self.import_module(“tk_multi_workfiles”)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank/platform/bundle.py”, line 462, in import_module
self.__module_uid, None, python_folder, ("", “”, imp.PKG_DIRECTORY)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/init.py”, line 11, in
from . import tk_multi_workfiles
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/tk_multi_workfiles/init.py”, line 14, in
from .file_open_form import FileOpenForm
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/tk_multi_workfiles/file_open_form.py”, line 19, in
from .actions.file_action_factory import FileActionFactory
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/tk_multi_workfiles/actions/file_action_factory.py”, line 19, in
from .interactive_open_action import InteractiveOpenAction
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/tk_multi_workfiles/actions/interactive_open_action.py”, line 17, in
from .open_file_action import OpenFileAction
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/tk_multi_workfiles/actions/open_file_action.py”, line 22, in
from …work_area import WorkArea
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/tk_multi_workfiles/work_area.py”, line 19, in
from .user_cache import g_user_cache
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/tk_multi_workfiles/user_cache.py”, line 203, in
g_user_cache = UserCache()
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/app_store/tk-multi-workfiles2/v0.12.2/python/tk_multi_workfiles/user_cache.py”, line 32, in init
self._current_user = sgtk.util.get_current_user(self._app.sgtk)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank/util/login.py”, line 125, in get_current_user
“HumanUser”, filters=[[“login”, “is”, current_login]], fields=fields
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 882, in find_one
additional_filter_presets=additional_filter_presets)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 1003, in find
additional_filter_presets)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 1072, in _construct_read_parameters
params[“paging”] = {“entities_per_page”: self.config.records_per_page,
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 471, in records_per_page
self._records_per_page = self._sg.server_info.get(“api_max_entities_per_page”) or 500
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 763, in server_info
return self.server_caps.server_info
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 778, in server_caps
self._server_caps = ServerCapabilities(self.config.server, self.info())
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 833, in info
return self._call_rpc(“info”, None, include_auth_params=False)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank/authentication/shotgun_wrapper.py”, line 63, in _call_rpc
return super(ShotgunWrapper, self)._call_rpc(*args, **kwargs)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 3302, in _call_rpc
encoded_payload, req_headers)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 3442, in _make_call
return self._http_request(verb, path, body, req_headers)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/shotgun.py”, line 3496, in _http_request
resp, content = conn.request(url, method=verb, body=body, headers=headers)
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/lib/httplib2/python2/init.py”, line 2192, in request
cachekey,
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/lib/httplib2/python2/init.py”, line 1845, in _request
conn, request_uri, method, body, headers
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/lib/httplib2/python2/init.py”, line 1750, in _conn_request
conn.connect()
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/lib/httplib2/python2/init.py”, line 1399, in connect
self.key_password,
File “/media/vfxbox/SHOTGUN/configsDeluxe/animationcopy/install/core/python/tank_vendor/shotgun_api3/lib/httplib2/python2/init.py”, line 109, in _ssl_wrap_socket
ssl_version=ssl_version,
File “/usr/local/Nuke10.5v7/lib/python2.7/ssl.py”, line 381, in wrap_socket
ciphers=ciphers)
File “/usr/local/Nuke10.5v7/lib/python2.7/ssl.py”, line 143, in init
self.do_handshake()
File “/usr/local/Nuke10.5v7/lib/python2.7/ssl.py”, line 305, in do_handshake
self._sslobj.do_handshake()
SSLError: [Errno 8] _ssl.c:504: EOF occurred in violation of protocol
```

Nuke 버전 11 또는 12에서는 이러한 문제가 발생하지 않습니다.

## 해결 방법

Nuke 10.x는 TLS 1.2와 호환되지 않기 때문에 발생하는 문제입니다. 소프트웨어는 TLS를 준수해야 합니다.

## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/sslerror-in-nuke-10-5/9299)