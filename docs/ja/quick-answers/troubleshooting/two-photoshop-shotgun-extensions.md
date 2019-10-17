---
layout: default
title: 2 つの機能拡張がインストールされている場合の Photoshop 統合のトラブルシューティング
pagename: two-photoshop-shotgun-extensions
lang: ja
---

# 2 つの機能拡張がインストールされている場合の Photoshop 統合のトラブルシューティング

## どんな問題がありますか?

After Effects 統合のリリースに伴い、Shotgun と統合されるすべての Adobe アプリで使用できる共通プラグインが用意されました。この変更の一環として、以前の Photoshop 統合との後方互換性を保ち、スタジオが更新プログラムに正しく移行できるようにするため、機能拡張の名前を変更する必要がありました。

これは残念ながら、アップグレード時に 2 つの Shotgun 機能拡張がインストールされる可能性があることも意味します。

![Photoshop メニューに複数の Shotgun 機能拡張が表示される](./images/photoshop-extension-panel.png)

**Shotgun Adobe Panel** が新しい機能拡張であり、`v1.7.0` 以降の Photoshop 統合を使用している場合にはこちらを使用する必要があります。

## エラーの修正方法

古い機能拡張を削除するには、ホーム ディレクトリの Adobe 製品のインストール場所から削除します。フォルダは、Photoshop 起動時に以下のデバッグ出力に表示されます。

- `~/Library/Application Support/Adobe/CEP/extensions/com.sg.basic.ps`OSX:
- Windows: `%AppData%\Adobe\CEP\extensions\com.sg.basic.ps`

![Photoshop メニューに複数の Shotgun 機能拡張が表示される](./images/shotgun-desktop-console-photoshop-extension.png)

Photoshop を終了してそのディレクトリを削除すると、再起動時の拡張拡張は 1 つだけになります。

{% include info title="注" content="複数の環境または複数の設定に Photoshop 統合があり、古いプラグインと新しいプラグインが混在している場合、あるユーザがその古い統合で Photoshop を起動すると、古いプラグインが返されます。このクリーンアップが一度で済むよう、Photoshop を組織全体で更新することを推奨します。" %}