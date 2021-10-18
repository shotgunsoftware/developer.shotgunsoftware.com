---
layout: default
title: TankError: Tried to Resolve a Path From The Template
pagename: tank-error-tried-to-resolve-a-path
lang: ja
---

# TankError: Tried to resolve a path from the template

## 使用例 1

SGTK の新しい設定をセットアップするときに、[File Open]ダイアログボックス(tk-multi-workfiles2)で新しいファイルを作成しようとすると、次のエラーが発生します。

```
TankError: Tried to resolve a path from the template <Sgtk TemplatePath asset_work_area_maya:
```

## 使用例 2

特定のタスクで保存しようとすると、次のエラーが表示されます。

```
TankError: Tried to resolve a path from the template <Sgtk TemplatePath nuke_shot_work:
```


## 修正方法

ケース 1: `asset.yml` ファイルを確認します。フィルタが見つからない可能性があります。

` - { "path": "sg_asset_type", "relation": "is", "values": [ "$asset_type"] }`

ケース 2: この原因は、シーケンスの名前が変更されていて、FilesystemLocations がいくつか残り、Toolkit に混乱をもたらしたことです。

修正:

- Shotgun の古い FilesystemLocations を削除する
- 古い FilesystemLocations に関連するフォルダを Toolkit から登録解除する
- Toolkit からフォルダを再登録する


## 関連リンク

このコミュニティの全スレッドについては、[こちら](https://community.shotgridsoftware.com/t/6468/10)、このコミュニティ スレッド内の全スレッドについては、[こちら](https://community.shotgridsoftware.com/t/9686)を参照してください。