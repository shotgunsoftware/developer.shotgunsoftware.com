---
layout: default
title: ShotGrid 데스크톱의 브라우저 통합을 어떻게 비활성화할 수 있습니까?
pagename: disable-browser-integration
lang: ko
---

# {% include product %} 데스크톱의 브라우저 통합을 어떻게 비활성화할 수 있습니까?

브라우저 통합을 비활성화하려면 다음의 간단한 두 단계를 수행하십시오.

1. 다음 위치에서 텍스트 파일을 생성하거나 엽니다.

        Windows: %APPDATA%\{% include product %}\preferences\toolkit.ini
        Macosx: ~/Library/Preferences/{% include product %}/toolkit.ini
        Linux: ~/.{% include product %}/preferences/toolkit.ini

2. 다음 섹션을 추가합니다.

        [BrowserIntegration]
        enabled=0

브라우저 통합 구성 방법에 대한 자세한 내용은 [관리자 안내서](https://support.shotgunsoftware.com/hc/ko/articles/115000067493-Integrations-Admin-Guide#Toolkit%20Configuration%20File)를 참조하십시오.

**대체 방법**

툴킷 파이프라인 구성을 인계받은 경우 대체 방법은 [환경에서 `tk-{% include product %}` 엔진](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/project.yml#L48)을 제거하여 어떤 액션도 로드할 수 없도록 하는 것입니다.