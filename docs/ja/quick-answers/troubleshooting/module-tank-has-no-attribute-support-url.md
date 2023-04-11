---
layout: default
title: "{% include product %} Desktop の起動時に、モジュール「tank」にアトリビュート「support_url」がないというエラーが発生する"
pagename: module-tank-has-no-attribute-support-url
lang: ja
---

# {% include product %} Desktop の起動時に、モジュール「tank」にアトリビュート「support_url」がないというエラーが発生する

## 問題

バージョンのアップグレード後に {% include product %} Desktop を起動すると、次のメッセージが表示されます。

```
{% include product %} Desktop Error:
Error: module 'tank' has no attribute 'support_url'
```

## 原因

記述子のバージョンが、新しい {% include product %} Desktop バージョン 1.7.3 と互換性がありません。「support_url」は tk-core v0.19.18 で導入されました。

## 解決方法

この問題を解決するには次の手順を実行します。

1. {% include product %} Web サイトの[パイプライン設定リスト]ページにアクセスします。
2. 記述子フィールドに、新しい {% include product %} デスクトップ バージョンと互換性のない古いバージョンが含まれているかどうかを確認します。

## 関連リンク

- [ナレッジベースのサポート記事](https://www.autodesk.co.jp/support/technical/article/caas/sfdcarticles/sfdcarticles/JPN/Error-module-tank-has-no-attribute-support-url-when-launching-ShotGrid-Desktop.html)

