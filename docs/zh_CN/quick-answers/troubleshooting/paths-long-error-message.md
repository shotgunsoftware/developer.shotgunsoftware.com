---
layout: default
title: 由于 Windows 路径太长而导致的错误
pagename: paths-long-error-message
lang: zh_CN
---

# 由于 Windows 路径太长（> 256 个字符）而导致的错误

## 确凿的事实

Windows 对路径名的默认限制非常低，即 255/260 个字符。[有关此限制的 Microsoft 信息位于此处](https://docs.microsoft.com/zh-cn/windows/win32/fileio/naming-a-file?redirectedfrom=MSDN#maximum-path-length-limitation)，您可以在[此处查看更多技术信息](https://docs.microsoft.com/zh-cn/windows/win32/fileio/maximum-file-path-limitation)。

## 错误

该错误会以各种方式表现出来，但通常在 SG Desktop 首次加载配置时发生，会在将项目下载到缓存时遇到此错误。尽管 Windows 10 的最新版本似乎对该错误有所改善，但该错误可能有些隐秘。下面是您可能会看到的一些示例：

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

## 为什么会发生这种情况

在 Windows 上，{% include product %} Desktop 将数据存储在 `%APPDATA%` 文件夹（通常为 `C:\Users\jane\AppData\Roaming\Shotgun`）。当使用标准 default2 Toolkit 配置时，只要您的用户名不是超长，就应该没问题。但是，如果要创建自己的应用、插件或框架，则可能会有更大的风险遇到这种情况，尤其是当您将依存项与代码捆绑在一起（像我们一样），并且您的包中有很深的目录树时。

## 解决该问题

解决该问题的方法通常是，将 `$SHOTGUN_HOME` 环境变量设置为非常短的值，如 `C:\SG`。这会告知 SG Desktop 将其数据存储在 `C:\SG` 而不是 `C:\Users\jane\AppData\Roaming\Shotgun` 中，这样可以节省一些字符，通常足以使您保持在限制之内。您可以[在此处阅读有关环境变量的信息](https://developer.shotgridsoftware.com/tk-core/initializing.html?#environment-variables)。

### 未来的可能性？

在 Windows 10 的最新版本中，还有另一种方法*可以*缓解此问题，即[如此处所述](https://docs.microsoft.com/zh-cn/windows/win32/fileio/maximum-file-path-limitation#enable-long-paths-in-windows-10-version-1607-and-later)更新注册表，但我认为还需要 SG Desktop 更新其清单文件，以表明它要利用 `longPathAware` 设置。我是 Mac 用户，因此我不确定我说的是否有用。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/errors-due-to-windows-paths-too-long-256-characters/10101)。

