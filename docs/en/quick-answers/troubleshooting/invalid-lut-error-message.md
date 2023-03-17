---
layout: default
title: Invalid LUT selected
pagename: invalid-lut-error-message
lang: en
---

# error Invalid LUT selected : Gamma2.2

## Use case:
While working in an ACES color management project, when you use the default toolkit publishing, it fails with an error  `Invalid LUT selected : Gamma2.2`.

## What’s causing the error?
There is an app that creates the quicktime that is a part of the toolkit publishing from Nuke called  `tk-multi-reviewsubmission`,  and by default it will create a QT that works with Nukes standard color model.

## How to fix
Since you are using ACES (I'm assuming the ICIO model), we just need to change the colorspace setting in the  `tk-multi-reviewsubmission`  app by taking over and adding it into the  `codec_settings.py`  hook.

Codecs vary per preference, but in this example, we're using the  `Output - sRGB Codec`: So in the  `codec_settings.py` hook add the setting  `settings["colorspace"] = "Output - sRGB"`  to where it makes sense for your setup. (I've just added it everywhere)

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

Now if you got all that right then when you publish in Nuke the QT will be made in an ACES compatible colorspace!

[See the full thread in the community](https://community.shotgridsoftware.com/t/what-to-do-when-publish-from-aces-nuke-script-fails-with-error-invalid-lut-selected-gamma2-2/197).

