---
layout: default
title: 잘못된 LUT가 선택됨
pagename: invalid-lut-error-message
lang: ko
---

# 오류 잘못된 LUT 선택: Gamma2.2

## 활용 사례:
ACES 색상 관리 프로젝트에서 작업할 때 기본 툴킷 게시를 사용하면 `Invalid LUT selected : Gamma2.2` 오류가 발생하여 작업이 실패합니다.

## 오류의 원인은 무엇입니까?
Nuke에서 툴킷 게시의 일부인 QuickTime을 만드는 `tk-multi-reviewsubmission`이라는 앱이 있으며, 기본적으로 Nuke 표준 색상 모델에서 작동하는 QT를 만듭니다.

## 해결 방법
ACES(ICIO 모델이라고 가정함)를 사용 중이므로 `tk-multi-reviewsubmission` 앱에서 색상 공간 설정을 인계받아 `codec_settings.py` 후크에 추가하여 변경해야 합니다.

코덱은 기본 설정에 따라 다르지만 이 예에서는 `Output - sRGB Codec`을 사용하므로 `codec_settings.py` 후크에서 설정에 적합한 위치에 `settings["colorspace"] = "Output - sRGB"` 설정을 추가합니다. (도처에 추가함)

```python
        settings = {}
        if sys.platform in ["darwin", "win32"]:
            settings["file_type"] = "mov"
            if nuke.NUKE_VERSION_MAJOR >= 9:
                # Nuke 9.0v1 changed the codec knob name to meta_codec and added an encoder knob
                # (which defaults to the new mov64 encoder/decoder).                  
                settings["meta_codec"] = "jpeg"
                settings["mov64_quality_max"] = "3"
                settings["colorspace"] = "Output - sRGB"
            else:
                settings["codec"] = "jpeg"
                settings["colorspace"] = "Output - sRGB"

        elif sys.platform == "linux2":
            if nuke.NUKE_VERSION_MAJOR >= 9:
                # Nuke 9.0v1 removed ffmpeg and replaced it with the mov64 writer
                # https://help.thefoundry.co.uk/nuke/9.0/#appendices/appendixc/supported_file_formats.html
                settings["file_type"] = "mov64"
                settings["mov64_codec"] = "jpeg"
                settings["mov64_quality_max"] = "3"
                settings["colorspace"] = "Output - sRGB"
            else:
                # the 'codec' knob name was changed to 'format' in Nuke 7.0
                settings["file_type"] = "ffmpeg"
                settings["format"] = "MOV format (mov)"
                settings["colorspace"] = "Output - sRGB"

        return settings
```

이제 이 모든 사항이 완료되면 Nuke에서 게시할 때 ACES 호환 색상 공간에서 QT가 생성됩니다.

[커뮤니티에서 전체 스레드를 참조](https://community.shotgridsoftware.com/t/what-to-do-when-publish-from-aces-nuke-script-fails-with-error-invalid-lut-selected-gamma2-2/197)하십시오.

