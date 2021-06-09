---
layout: default
title: 環境変数 NUKE_PATH を設定すると Nuke 統合の起動に失敗するのはなぜですか?
pagename: nuke-path-environment-variable
lang: ja
---

# 環境変数 NUKE_PATH を設定すると Nuke 統合の起動に失敗するのはなぜですか?

当社の統合では Nuke の起動時に `NUKE_PATH` 環境変数が設定され、Nuke の起動プロセス中にブートストラップ スクリプトが実行されます。[`before_launch_app.py`](https://github.com/shotgunsoftware/tk-multi-launchapp/blob/6a884aa144851148e8369e9f35a2471087f98d16/hooks/before_app_launch.py) フックを実行する前に `NUKE_PATH` を明示的に定義するのは [`tk-multi-launchapp`](https://support.shotgunsoftware.com/hc/ja/articles/219032968-Application-Launcher#Set%20Environment%20Variables%20and%20Automate%20Behavior%20at%20Launch) です。

起動プロセス中に `os.environ['NUKE_PATH'] = "/my/custom/path"` などを使用してこの環境変数を設定している場合、Shotgun の統合は開始されません。これは、起動スクリプトのパスを環境変数から削除したためです。

この機能を `tank.util` で使用すると、Toolkit ブートストラップへのパスを維持しながら、パスが環境変数 `NUKE_PATH` またはその先頭に追加されます。

```python
tank.util.append_path_to_env_var("NUKE_PATH", "/my/custom/path")
```

または、`prepend_path_to_env_var()` を使用してパスを先頭に追加できます。