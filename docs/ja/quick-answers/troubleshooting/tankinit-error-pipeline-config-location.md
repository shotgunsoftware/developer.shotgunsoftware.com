---
layout: default
title: You are loading the Toolkit platform from the pipeline configuration located in
pagename: tankinit-error-pipeline-config-location
lang: ja
---

# TankInitError: You are loading the Toolkit platform from the pipeline configuration located in

## 使用例

アプリからファイルをパブリッシュするコードを実行するときに、ファイルが別のプロジェクトに属している場合があります。

`TankInitError: You are loading the Toolkit platform from the pipeline configuration located in` エラーを回避することは可能でしょうか?

理想的なのは、パスからコンテキストを見つけて、これらのファイルを適切に登録できることです(これらのファイルが別のプロジェクトに属している場合も同様です)。

## 修正方法

次の関数を使用します。

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
重要なのは、`sys.modules` からすべての sgtk 関連モジュールを削除して、環境から `TANK_CURRENT_PC` を削除することです。これは、「[Shotgun のイベント デーモンを使用してさまざまな Toolkit コア モジュールをロードするにはどうすればいいですか?](https://developer.shotgridsoftware.com/ja/3520ad2e/)」に記載されています。

## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/tankiniterror-loading-toolkit-platform-from-a-different-project/9342)を参照してください。