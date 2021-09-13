---
layout: default
title: App Store에 my-app이라는 항목이 포함되어 있지 않음
pagename: myapp-appstore-error-message
lang: ko
---

# 오류: App Store에 my-app이라는 항목이 포함되어 있지 않음

## 해결 방법:

이 오류는 커스텀 앱의 위치 설명자와 관련이 있습니다. [이 문서를 확인](https://developer.shotgunsoftware.com/2e5ed7bb/#part-6-preparing-your-first-release)하십시오.

위치에 대해서는 경로 설명자를 사용하여 my-app을 설정합니다. [자세한 내용은 여기](https://developer.shotgridsoftware.com/tk-core/descriptor.html#pointing-to-a-path-on-disk)를 참조하십시오.

## 이 오류가 발생하는 원인의 예:

tk-multi-snapshot이 Maya에 표시되지 않아 tank 유효성 검사를 사용하려는 동안 커스텀 앱의 유효성을 검사하려고 하면 해당 앱이 App Store에 없다는 오류가 표시됩니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/tank-validate-errors-on-custom-apps/10674)하십시오.

