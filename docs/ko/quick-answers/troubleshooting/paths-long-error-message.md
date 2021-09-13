---
layout: default
title: 너무 긴 Windows 경로로 인한 오류
pagename: paths-long-error-message
lang: ko
---

# 너무 긴 Windows 경로(256자 초과)로 인한 오류

## 사실 정보

Windows는 경로 이름의 기본 제한 문자 수가 255자/260자로 매우 낮습니다. [이 제한에 대한 Microsoft의 정보는 여기](https://docs.microsoft.com/en-us/windows/win32/fileio/naming-a-file?redirectedfrom=MSDN#maximum-path-length-limitation)에 있으며, [자세한 기술 정보는 여기](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation)에서 확인할 수 있습니다.

## 오류

이 문제는 여러 가지 방식으로 자체 발생하지만 대개는 SG 데스크톱이 구성을 처음 로드하는 경우에 발생하며 번들 캐시에 항목을 다운로드하는 동안 이 오류가 발생합니다. 이 오류는 Windows 10의 최신 버전에서 약간 개선된 것처럼 보이긴 하지만 다소 난해할 수 있습니다. 다음은 표시될 수 있는 몇 가지 예입니다.

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

## 이 문제가 발생하는 이유

Windows에서 {% include product %} 데스크톱은 데이터를 `%APPDATA%` 폴더(일반적으로 `C:\Users\jane\AppData\Roaming\Shotgun`)에 저장합니다. 표준 default2 툴킷 구성을 사용할 때는 사용자 이름이 지나치게 길지만 않으면 대부분 괜찮습니다. 그러나 자체 앱, 엔진 또는 프레임워크를 만드는 경우, 특히 코드와 함께 종속성을 번들로 묶고(여기서처럼) 번들에 디렉토리의 깊은 트리가 있는 경우 이 문제가 발생할 위험이 더 클 수 있습니다.

## 문제 해결

이 문제를 해결하는 방법은 일반적으로 `$SHOTGUN_HOME` 환경 변수를 `C:\SG`와 같이 매우 짧게 설정하는 것입니다. 이렇게 하면 SG 데스크톱이 `C:\Users\jane\AppData\Roaming\Shotgun` 대신 `C:\SG`에 해당 데이터를 저장하게 되며 문자 길이가 줄어들어 일반적으로 제한 수준을 유지할 수 있습니다. [환경 변수에 대한 자세한 내용은 여기를 참조](http://developer.shotgunsoftware.com/tk-core/initializing.html?#environment-variables)하십시오.

### 향후 가능성

[여기에 설명된 대로](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation#enable-long-paths-in-windows-10-version-1607-and-later) 레지스트리 업데이트를 통해 Windows 10의 최신 버전에서 이 문제를 완화하는 다른 방법이 *있을 수도 있지만* SG 데스크톱에서 매니페스트 파일을 업데이트하여 `longPathAware` 설정을 활용하도록 하는 것도 필요하다고 생각합니다. 제가 Mac 사용자라 그런지는 모르겠지만 말입니다. ;)

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/errors-due-to-windows-paths-too-long-256-characters/10101)하십시오.

