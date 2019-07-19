---
layout: default
title: 내 캐시는 어디에 있습니까?
pagename: where-is-my-cache
lang: ko
---

# 내 캐시는 어디에 있습니까?


## 루트 캐시 위치

툴킷은 일부 데이터를 로컬 캐시에 저장하여 Shotgun 서버에 대한 불필요한 호출을 방지합니다. 여기에는 [경로 캐시](./what-is-path-cache.md), 번들 캐시 및 썸네일이 포함됩니다. 대부분의 사용자는 기본 위치로도 문제 없지만 이를 변경해야 한다면 [cache_location 코어 후크](https://github.com/shotgunsoftware/tk-core/blob/master/hooks/cache_location.py)를 사용하여 구성할 수 있습니다.

기본 캐시 루트 위치는 다음과 같습니다.

**Mac OS X**

`~/Library/Caches/Shotgun`

**Windows**

`%APPDATA%\Shotgun`

**Linux**

`~/.shotgun`

## 경로 캐시

경로 캐시 위치는 다음과 같습니다.

`<site_name>/p<project_id>c<pipeline_configuration_id>/path_cache.db`

## 번들 캐시

**분산 구성**

번들 캐시는 Shotgun 사이트의 프로젝트 전반에 사용되는 전체 응용프로그램, 엔진, 프레임워크의 캐시 모음입니다. 분산 구성의 번들 캐시는 다음 위치에 저장됩니다.

`~/Library/Caches/Shotgun/bundle_cache`Mac:

Windows:
`%APPDATA%\Shotgun\bundle_cache`

Linux:
`~/.shotgun/bundle_cache`

{% include info title="참고" content="`SHOTGUN_BUNDLE_CACHE_PATH` 환경 변수를 사용하여 이러한 위치를 재정의할 수 있으므로 실제 구현은 다를 수 있습니다." %}

**중앙 집중식 구성**

중앙 집중식 구성의 번들 캐시는 중앙 집중식 구성 내부에 저장됩니다.

`...{project configuration}/install/`

구성에서 공유 코어를 사용하는 경우 번들 캐시는 공유 코어의 설치 폴더 내부에 저장됩니다.

## 썸네일

툴킷 앱(예: [Loader](https://support.shotgunsoftware.com/entries/95442527))에서 사용하는 썸네일은 로컬 툴킷 캐시에 저장됩니다. 썸네일은 프로젝트, 파이프라인 구성, 앱(필요 시)별로 저장됩니다. 루트 캐시 디렉토리 아래의 구조는 다음과 같습니다.

`<site_name>/p<project_id>c<pipeline_configuration_id>/<app_or_framework_name>/thumbs/`
