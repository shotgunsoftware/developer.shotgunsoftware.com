---
layout: default
title: Invalid LUT selected
pagename: invalid-lut-error-message
lang: ja
---

# error Invalid LUT selected : Gamma2.2

## 使用例:
ACES カラー管理プロジェクトで作業しているときに、既定の Toolkit パブリッシュを使用すると、エラー `Invalid LUT selected : Gamma2.2` が発生して失敗します。

## エラーの原因
Nuke の Toolkit パブリッシュに QuickTime を作成するアプリ `tk-multi-reviewsubmission` が含まれていて、このアプリで既定で作成される QT は Nuke 標準カラー モデルで機能します。

## 修正方法
ACES (ICIO モデルを想定)を使用しているため、`tk-multi-reviewsubmission` アプリでカラー スペース設定を変更するには、設定を引き継いで `codec_settings.py` フックに追加するだけで済みます。

コーデックは基本設定によって異なりますが、この例では `Output - sRGB Codec`を使用しています。そのため、`codec_settings.py` フック内のセットアップに適した場所に設定 `settings["colorspace"] = "Output - sRGB"` を追加します。(ここではすべての場所に追加しました)

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

これで問題がなければ、Nuke でパブリッシュするときに、QT は ACES と互換性のあるカラースペースで作成されるようになります。

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/what-to-do-when-publish-from-aces-nuke-script-fails-with-error-invalid-lut-selected-gamma2-2/197)を参照してください。

