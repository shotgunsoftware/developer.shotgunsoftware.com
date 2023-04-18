---
layout: default
title: ログ ファイルはどこにありますか?
pagename: where-are-my-log-files
lang: ja
---

# ログ ファイルはどこにありますか?

既定では、{% include product %} Desktop と統合は、ログ ファイルを次のディレクトリに保存します。

**Mac**

`~/Library/Logs/Shotgun/`

**Windows**

`%APPDATA%\Shotgun\logs\`

**Linux**

`~/.shotgun/logs/`

ログ ファイル名の形式は `tk-<ENGINE>.log` です。例として `tk-desktop.log` や `tk-maya.log` があります。

ユーザのキャッシュの場所をオーバーライドするように[`{% include product %}_HOME` 環境変数](https://developer.shotgridsoftware.com/tk-core/utils.html#localfilestoragemanager)を設定した場合、ログ ファイルは次の場所に配置されます。`$SHOTGUN_HOME/logs`

{% include info title="注" content="ShotGrid Desktop からこのディレクトリにアクセスすることもできます。プロジェクトを選択し、プロジェクト名の右側にある下矢印ボタンをクリックして、**[ログフォルダを開く](Open Log Folder)**を選択します。" %}
