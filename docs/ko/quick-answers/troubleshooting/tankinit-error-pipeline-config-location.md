---
layout: default
title: 툴킷이 있는 파이프라인 구성에서 툴킷 플랫폼을 로드하는 중입니다.
pagename: tankinit-error-pipeline-config-location
lang: ko
---

# TankInitError: 파이프라인 구성에서 툴킷 플랫폼을 로드하는 중입니다.

## 활용 사례

앱에서 파일을 게시하기 위해 일부 코드를 실행할 때 파일이 다른 프로젝트에 속한 경우가 있습니다.

`TankInitError: You are loading the Toolkit platform from the pipeline configuration located in` 오류를 해결할 수 있습니까?

이상적으로, 이러한 파일이 다른 프로젝트에 속해 있더라도 경로에서 컨텍스트를 찾아 적절히 등록할 수 있습니다.

## 해결 방법

다음 함수를 사용합니다.

```
def get_sgtk(proj_name, script_name):
    """ Load sgtk path and import module
    If sgtk was previously loaded, replace include paths and reimport
    """
    project_path = get_proj_tank_dir(proj_name)

    sys.path.insert(1, project_path)
    sys.path.insert(1, os.path.join(
        project_path,
        "install", "core", "python"
    ))

    # unload old core
    for mod in filter(lambda m: m.startswith("sgtk") or m.startswith("tank"), sys.modules):
        sys.modules.pop(mod)
        del mod

    if "TANK_CURRENT_PC" in os.environ:
        del os.environ["TANK_CURRENT_PC"]

    import sgtk
    setup_sgtk_auth(sgtk, script_name)
    return sgtk
```
핵심은 `sys.modules`에서 모든 sgtk 관련 모듈을 삭제하고 환경에서 `TANK_CURRENT_PC`를 제거하는 것입니다. 자세한 내용은 다음 문서를 참조하십시오. [어떻게 하면 shotgunEvents 데몬을 사용하여 다른 Toolkit Core 모듈을 로드할 수 있습니까?](https://developer.shotgridsoftware.com/ko/3520ad2e/)

## 관련 링크

[커뮤니티에서 전체 스레드 참조](https://community.shotgridsoftware.com/t/tankiniterror-loading-toolkit-platform-from-a-different-project/9342)