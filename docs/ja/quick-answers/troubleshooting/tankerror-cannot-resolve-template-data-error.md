---
layout: default
title: Cannot resolve template data for context
pagename: tankerror-cannot-resolve-template-data-error
lang: ja
---

# TankError: Cannot resolve template data for context

## 使用例

新しいプロジェクトで高度なプロジェクト設定を行っているときに、{% include product %} Desktop のスタンドアロンの Publisher アプリを使用して、作成した新しいアセット タスク用のイメージをいくつかパブリッシュするとします。この場合に、パブリッシュを検証するコンテキストを選択すると、次のエラーが表示されます。


```
creation for %s and try again!" % (self, self.shotgun_url))
TankError: Cannot resolve template data for context ‘concept, Asset door-01’ - this context does not have any associated folders created on disk yet and therefore no template data can be extracted. Please run the folder creation for and try again!
```

ターミナルで `tank.bat Asset door-01 folders` を実行すると、この問題が解決されました。ただし、以前のプロジェクトではこの問題が発生しませんでした。

## 修正方法

この原因として考えられるのは、最初に DCC を対象にしないで、新しいエンティティまたはタスクにスタンドアロン パブリッシュを初めて試みたことです。

以前にこの問題が発生しなかったのは、スタンドアロン パブリッシャーを使用する前にソフトウェアでアセットの作業を開始していたため、フォルダの作成/同期が既に完了していたためです。ソフトウェアを(Toolkit を介して)起動すると、起動したときのコンテキストのフォルダが作成され、アプリを開くと、新しいファイルを開始したときのコンテキストのフォルダが作成されます。したがって、通常はフォルダを特に作成する必要はありません。

スタジオでは通常、{% include product %} でショットやアセットが追加された後に、手動でフォルダを作成することが一般的に行われています。

この方法は「フォルダのスキーマ」の影響を受けるため、フォルダのスキーマがテンプレートと完全に一致しない場合は問題になることもあります。

## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/tank-folder-creation/8674/5)を参照してください。