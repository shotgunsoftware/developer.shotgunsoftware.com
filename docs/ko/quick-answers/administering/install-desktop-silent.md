---
layout: default
title: Windows에서 Shotgun 데스크톱을 자동으로 설치하려면 어떻게 해야 합니까?
pagename: install-desktop-silent
lang: ko
---

# Windows에서 Shotgun 데스크톱을 자동으로 설치하려면 어떻게 해야 합니까?

Shotgun 데스크톱 설치 프로그램을 자동으로 실행하려면 다음 방법으로 Shotgun 데스크톱 설치 프로그램을 실행하십시오.

`ShotgunInstaller_Current.exe /S`

설치 폴더를 지정하고 싶다면 `/D` 인자를 사용하여 실행하면 됩니다.

`ShotgunInstaller_Current.exe /S /D=X:\path\to\install\folder.`

{% include info title="참고" content="`/D` 인자는 마지막 인자여야 하며, 경로에 공백이 있다고 하더라도 `\"`를 사용해서는 안 됩니다." %}