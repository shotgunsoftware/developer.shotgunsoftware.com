---
layout: default
title: 选择的 LUT 无效
pagename: invalid-lut-error-message
lang: zh_CN
---

# 错误“选择的 LUT 无效: Gamma2.2”

## 用例：
在 ACES 颜色管理项目中工作时，如果使用默认的 Toolkit 发布，发布将失败并显示错误 `Invalid LUT selected : Gamma2.2`。

## 导致错误的原因是什么？
有一个应用创建 QuickTime，这是 Nuke Toolkit 发布的一部分，名为 `tk-multi-reviewsubmission`，默认情况下，它将创建一个 QT，该 QT 可与 Nuke 标准颜色模型配合使用。

## 如何修复
由于您使用的是 ACES（我假设使用 ICIO 模型），我们只需通过接管该应用并将其添加到 `codec_settings.py` 挂钩中来更改 `tk-multi-reviewsubmission` 应用中的颜色空间设置。

编解码器因首选项而异，但在此示例中，我们使用 `Output - sRGB Codec`：因此，在 `codec_settings.py` 挂钩中，将 `settings["colorspace"] = "Output - sRGB"` 设置添加到适合您的设置的位置。（我刚刚在所有位置添加了它）

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
                # http://help.thefoundry.co.uk/nuke/9.0/#appendices/appendixc/supported_file_formats.html
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

现在，如果您已经全部设置好，那么在 Nuke 中发布时，QT 将在 ACES 兼容的颜色空间中生成！

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/what-to-do-when-publish-from-aces-nuke-script-fails-with-error-invalid-lut-selected-gamma2-2/197)。

