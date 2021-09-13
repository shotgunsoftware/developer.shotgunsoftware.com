---
layout: default
title: Cannot find procedure “MTsetToggleMenuItem”
pagename: mtsettogglemenuitem-error-message
lang: ja
---

# Cannot find procedure “MTsetToggleMenuItem”

## 関連するエラーメッセージ:

通常のスプラッシュ画面が表示されてから、ウィンドウ全体がロードされる直前までの間に Maya がクラッシュする。
- Cannot find procedure "MTsetToggleMenuItem"

## 修正方法:

Maya を起動する前に before_app_launch フックでパスの一部が誤って削除されたために、Maya の起動時にエラーになる可能性があります。この場合、Python インストールを `PTHONPATH` に追加すると、Maya 2019 によるプラグイン パスの検索を防止することができます。

## このエラーの原因の例:
ユーザにはいくつかの問題がありました。このフックにより、`C:\Python27` が `PYTHONPATH` として設定され、この `PYTHONPATH` を使用してワークステーションが実際にインストールされたためです。

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/tk-maya-cannot-find-procedure-mtsettogglemenuitem/4629)を参照してください。

