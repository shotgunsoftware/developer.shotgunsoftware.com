---
layout: default
title: App store does not contain an item named my-app
pagename: myapp-appstore-error-message
lang: ja
---

# ERROR: App store does not contain an item named my-app

## 修正方法:

これは、カスタム アプリの場所の記述子に関係します。[このドキュメント](https://developer.shotgridsoftware.com/ja/2e5ed7bb/#part-6-preparing-your-first-release)を参照してください

場所については、パス ディスクリプタを使用して my-app を設定します。詳細については[こちら](https://developer.shotgridsoftware.com/tk-core/descriptor.html#pointing-to-a-path-on-disk)を参照してください。

## このエラーの原因の例:

tk-multi-snapshot が Maya に表示されないため、tank validate を使用しようとすると、カスタム アプリを検証するときに、このアプリがアプリ ストアにないことを示すエラーが表示されます。

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/tank-validate-errors-on-custom-apps/10674)を参照してください。

