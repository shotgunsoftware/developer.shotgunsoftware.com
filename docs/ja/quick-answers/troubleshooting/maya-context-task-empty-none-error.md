---
layout: default
title: Maya で context.task を出力すると、空の「None」になる
pagename: maya-context-task-empty-none-error
lang: ja
---

# Maya で context.task を出力すると、空の「None」になる

## 使用例

Maya で `context.task` を出力すると `empty “None”` になりますが、別のステップ/タスクで別のレイアウト ファイルを試すと、`context.task` の詳細が表示されます。`Open > Layout > new file` をナビゲートするときに `context.task` の詳細を出力することもできますが、[File Save]を使用してファイルを保存すると、`context.task` は「None」になります。

## 修正方法

動作しないショットの 1 つに対して[フォルダの登録解除](https://community.shotgridsoftware.com/t/how-can-i-unregister-folders-when-using-a-distributed-config/189)を試して、フォルダの作成を再実行します。


## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/context-task-none/3705)を参照してください。