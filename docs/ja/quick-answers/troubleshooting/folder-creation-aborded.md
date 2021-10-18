---
layout: default
title: Folder creation aborded
pagename: folder-creation-aborded
lang: ja
---

# Failed to create folders: Folder creation aborded

## 使用例

現在は、Web インタフェースで新しいプロジェクトを作成してから、{% include product %} Desktop を使用して一元管理セットアップとして Toolkit を設定します。ただし、アセット名を編集しようとしても、機能は停止している(アーティストはファイルを開いて、Maya などの CCD で編集することができない)ため、「Failed to create folders」というエラーが返されます。{% include product %} から、Tank コマンドを再実行してアセットを登録解除し、再登録して修正するよう求められますが、どこで実行する必要があるかは不明です。

## 修正方法

プロジェクトに対して高度なセットアップ ウィザードを実行した場合、この操作を実行するオプションは意図的に削除されています。ただし、必要に応じて[プロジェクトを再セットアップ](https://developer.shotgunsoftware.com/ja/fb5544b1/)することができます。

エラー メッセージに記載された Tank コマンドを実行する必要があります。

```
tank.bat Asset ch03_rockat_drummer unregister_folders
```

`tank.bat` はユーザがセットアップした設定のルートにあります。場所が不明な場合は、[こちらのトピック](https://community.shotgridsoftware.com/t/how-do-i-find-my-pipeline-configuration/191)が検索する際に役立ちます。

## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/error-in-toolkit-after-renaming-asset/4108)を参照してください。