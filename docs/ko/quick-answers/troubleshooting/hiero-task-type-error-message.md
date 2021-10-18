---
layout: default
title: 오류 18:13:28.365:Hiero(34236) 오류! 태스크 유형
pagename: hiero-task-type-error-message
lang: ko
---

# 오류 18:13:28.365:Hiero(34236): 오류! 태스크 유형

## 활용 사례:
`config_default2`로 업데이트한 후 nuke_studio가 초기화되지 않습니다. Nuke 12.0 Studio에서는 스크립트 편집기에 오류가 표시되지 않지만 Nuke 11.1v3에서는 다음과 같은 메시지가 표시됩니다.

```
ERROR 18:13:28.365:Hiero(34236): Error! Task type tk_hiero_export.sg_shot_processor.ShotgunShotProcessor Not recognised
```

롤백 후 오류가 발생하지 않아도 tk-nuke 엔진이 초기화되지 않고 {% include product %}에서 아무것도 로드하지 못합니다...

[커뮤니티 게시물](https://community.shotgridsoftware.com/t/cant-get-shotgun-toolkit-to-work-with-nuke-studio-config-default2/4586)에 자세한 내용을 볼 수 있는 전체 로그가 포함되어 있습니다.

## 오류의 원인은 무엇입니까?
NukeStudio 시작으로 처리하지 않고 대신 표준 Nuke 시작으로 처리하는 것일 수 있습니다.

경로가 있는 Nuke Studio 소프트웨어 엔티티를 정의하고 인자를 `-studio`로 설정했습니다. 인자는 `--studio`여야 합니다.

## 해결 방법
소프트웨어 엔티티의 인자를 `-studio`로 설정해야 합니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/cant-get-shotgun-toolkit-to-work-with-nuke-studio-config-default2/4586)하십시오.

