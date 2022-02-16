---
layout: default
title: Critical! Could not update ShotGrid with folder data.
pagename: could-not-update-with-folder-data
lang: ja
---

# TankError: Could not create folders on disk. Error reported: Critical! Could not update {% include product %} with folder data.

## 使用例

オートデスクでは一元管理設定を使用して、既存のプロジェクトに Linux のサポートを追加していますが、ファイルシステムの設定に問題があります。

以下の作業は完了しています。

- 対応するルートを roots.yml に追加する
- パイプライン設定(install_location.yml など)に Linux パスを追加する
- ソフトウェア エンティティの Linux パスを追加する

{% include product %} Desktop は正常に起動しますが、プログラムを起動しようとすると、次のように表示されます。

```
TankError: Could not create folders on disk. Error reported: Critical! Could not update Shotgun with folder data. Please contact support. Error details: API batch() request with index 0 failed.  All requests rolled back.
API create() CRUD ERROR #6: Create failed for [Attachment]: Path /mnt/cache/btltest3 doesn't match any defined Local Storage.
```

同様に、Tank フォルダやその他のコマンドを実行しようとすると、同じエラーが出力されます。

必要なすべての場所に Linux パスが追加されているはずです。データベースの同期に問題があるか確認してください。

`tank synchronize_folders` を実行すると、特に次のように出力されます。

- The path is not associated with any {% include product %} object.

## 修正方法

[サイト基本設定](Site Preferences) > [ファイル管理](File Management)で、{% include product %} のローカル ストレージに Linux のパスを追加します。


## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/first-time-setting-up-shotgun-and-i-have-this-error/9384)を参照してください。