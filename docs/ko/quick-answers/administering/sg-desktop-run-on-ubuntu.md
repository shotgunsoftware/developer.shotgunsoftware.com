---
layout: default
title: ShotGrid 데스크톱이 Ubuntu 같은 Debian 시스템에서도 작동합니까?
pagename: sg-desktop-run-on-ubuntu
lang: ko
---

# {% include product %} 데스크톱이 Ubuntu 같은 Debian 시스템에서도 작동합니까?

현재는 {% include product %} 데스크톱용 Debian 기반 배포판을 지원하지 않습니다.
과거에 몇몇 고객이 이를 구현하려고 했던 적이 있었는데, cpio를 사용하여 RPM에서 {% include product %} 데스크톱을 추출한 다음 라이브러리 종속성을 충족하려고 했지만 그리 좋은 결과를 내진 못했습니다. 추가 내용은 [dev 그룹에서 이 스레드를 확인할 수 있습니다](https://groups.google.com/a/shotgunsoftware.com/d/msg/shotgun-dev/nNBg4CKNBLc/naiGlJowBAAJ).

Python 자체가 많은 시스템 레벨 라이브러리 위에 위치하기 때문에 명시적인 라이브러리 종속성 목록은 없습니다.

지금으로서는 Debian 지원에 대한 공식적인 계획이 없습니다. Ubuntu를 위한 빌드에는 문제가 있지만 한편으로는 결코 사소하다고 할 수 없는 변화를 구현하다 보면 추가 운영 체제를 QA 및 지원해야 할 필요도 있습니다.

{% include product %} 데스크톱 없이 툴킷을 수동으로 실행 및 활성화하려는 경우([여기 문서에서 설명](https://support.shotgunsoftware.com/hc/ko/articles/219033208#Step%208.%20Run%20the%20activation%20script)) - 설명서 페이지에서 `activate_shotgun_pipeline_toolkit.py` 스크립트를 다운로드하십시오. 이 안내서의 8단계에 있으며, "다운로드하려면 클릭..."(click to download...) 헤더를 클릭하면 됩니다.
