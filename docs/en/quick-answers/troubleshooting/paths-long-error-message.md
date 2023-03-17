---
layout: default
title: Errors due to Windows paths too long
pagename: paths-long-error-message
lang: en
---

# Errors due to Windows paths too long (>256 characters)

## The hard facts

Windows has a really low default limit of 255/260 characters for path names. [Microsoft's information about this limit is here](https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file?redirectedfrom=MSDN#maximum-path-length-limitation) and you can see [more technical info here](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation).

## The error(s)

This manifests itself in various ways but typically happens when SG Desktop is loading a config for the first time, it hits this error while downloading items into the bundle cache. The error can be somewhat cryptic though it looks like recent versions of Windows 10 have improved the error slightly. These are some examples of what you might see:

```
[ WARNING] Attempt 1: Attachment download of id 3265791 from https://xxxxx.shotgunstudio.com failed: [Error 206] The filename or extension is too long: 'C:\\Users\\xxxxx\\AppData\\Roaming\\Shotgun\\bundle_cache\\tmp\\0933a8b9a91440a2baf3dd7df44b40ce\\bundle_cache\\git\\tk-framework-imageutils.git\\v0.0.2\\python\\vendors\\osx\\lib\\python2.7\\site-packages\\pip\\_vendor\\requests\\packages\\urllib3\\packages\\ssl_match_hostname'
[ WARNING] File 'c:\users\xxxxx\appdata\local\temp\ab35bd0eb2b14c3b9458c67bceeed935_tank.zip' could not be deleted, skipping: [Error 32] The process cannot access the file because it is being used by another process: 'c:\\users\\xxxxx\\appdata\\local\\temp\\ab35bd0eb2b14c3b9458c67bceeed935_tank.zip'
```

```
ERROR sgtk.core.descriptor.io_descriptor.downloadable] Failed to download into path C:\Users\xxxxx\AppData\Roaming\Shotgun\bundle_cache\tmp\123456789012a34b567c890d1e23456: Failed to download sgtk:descriptor:shotgun?entity_type=PipelineConfiguration&field=uploaded_config&id=38&version=123456 from https://xxxxx.shotgunstudio.com. Error: Failed to download from 'https://xxxxx.shotgunstudio.com' after 5 retries. See error log for details.. Attempting to remove it.
```

```
WARNING sgtk.core.util.shotgun.download Attempt 4: Attachment download of id 1182 from https://xxxxx.shotgunstudio.com failed: [Errno 2] No such file or directory: 'C:\\Users\\xxxxx\\AppData\\Roaming\\Shotgun\\bundle_cache\\tmp\\dd2cc0804122403a87ac71efccd383ea\\bundle_cache\\app_store\\tk-framework-desktopserver\\v1.3.1\\resources\\python\\build\\pip\\_vendor\\requests\\packages\\urllib3\\packages\\ssl_match_hostname\\_implementation.py'
WARNING sgtk.core.util.filesystem File 'c:\users\xxxxx\appdata\local\temp\08f94bfe9b6d43e7a7beba30c192a43c_tank.zip' could not be deleted, skipping: [Error 32] The process cannot access the file because it is being used by another process: 'c:\\users\\xxxxx\\appdata\\local\\temp\\08f94bfe9b6d43e7a7beba30c192a43c_tank.zip'
ERROR sgtk.core.descriptor.io_descriptor.downloadable] Failed to download into path C:\Users\xxxxx\AppData\Roaming\Shotgun\bundle_cache\tmp\dd2cc0804122403a87ac71efccd383ea: Failed to download sgtk:descriptor:shotgun?entity_type=PipelineConfiguration&field=sg_uploaded_config&id=1&version=1182 from https://xxxxx.shotgunstudio.com. Error: Failed to download from 'https://xxxxx.shotgunstudio.com' after 5 retries. See error log for details.. Attempting to remove it.
ERROR sgtk.core.bootstrap.cached_configuration Failed to install configuration sgtk:descriptor:shotgun?entity_type=PipelineConfiguration&field=sg_uploaded_config&id=1&version=1182. Error: Failed to download into path C:\Users\xxxxx\AppData\Roaming\Shotgun\bundle_cache\tmp\dd2cc0804122403a87ac71efccd383ea: Failed to download sgtk:descriptor:shotgun?entity_type=PipelineConfiguration&field=sg_uploaded_config&id=1&version=1182 from https://xxxxx.shotgunstudio.com. Error: Failed to download from 'https://xxxxx.shotgunstudio.com' after 5 retries. See error log for details.. Cannot continue.
```

## Why this happens

On Windows, {% include product %} Desktop stores data in your `%APPDATA%` folder (typically `C:\Users\jane\AppData\Roaming\Shotgun`. When using the standard default2 Toolkit config things should be mostly fine as long as your username isn't super long. However, if you are creating your own apps, engines, or frameworks, you may have more risk of running into this, especially if you bundle dependencies with your code (as we do), and you have deep trees of directories in your bundles. 

## Working around the issue

The way to resolve this issue is typically to set a `$SHOTGUN_HOME` environment variable to something very short like `C:\SG`. This tells SG Desktop to store it's data in `C:\SG` instead of `C:\Users\jane\AppData\Roaming\Shotgun` which saves you some characters and is usually enough to keep you under the limit. You can [read about the environment variables here](https://developer.shotgridsoftware.com/tk-core/initializing.html?#environment-variables).

### Future possibilities?

There *may* be another way to mitigate this issue with more recent versions of Windows 10 by updating the registry [as described here](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation#enable-long-paths-in-windows-10-version-1607-and-later) but I think it also requires SG Desktop to update it's manifest file to indicate it wants to take advantage of the `longPathAware` setting. I'm a Mac guy so I'm not sure if I'm just talking crap here ;)

[See the full thread in the community](https://community.shotgridsoftware.com/t/errors-due-to-windows-paths-too-long-256-characters/10101).

