---
layout: default
title: SG Desktop から Nuke や Maya などを起動したが Shotgun のメニューにエントリが表示されない
pagename: menu-entries-missing-in-launched-dcc
lang: ja
---

# SG Desktop から Nuke や Maya などを起動したが Shotgun のメニューにエントリが表示されない

Shotgun メニューに表示されるアクションはコンテキストに応じて設定されます。つまり、利用可能なアクションのリストは、現在のコンテキストによって異なる可能性があります。コンテキストが間違っているためにアプリが表示されない可能性があります。

## 例

[Shotgun Desktop](https://support.shotgunsoftware.com/hc/ja/articles/219039818) からアプリケーションを起動すると、既定ではプロジェクト環境が表示されます。この環境は、`config/env/project.yml` に格納されたパイプライン設定内の設定ファイルによって管理されます。ユーザーの作業のほとんどはこの環境では行わないため、多くのアプリでは操作用に設定されていません。

**既定の Maya プロジェクト アクション:**

![Shotgun メニューのプロジェクト アクション](images/shotgun-menu-project-actions.png)

[Shotgun Workfiles アプリ](https://support.shotgunsoftware.com/hc/ja/articles/219033088)を使用すると、作業するアセット、ショット、またはタスクを選択できます。これにより、新しい適切な環境をロードし、多くのアプリで Shotgun メニューのメニュー項目を有効にできます。

**既定の Maya アセット タスク アクション:**

![Shotgun メニューのプロジェクト アクション](images/shotgun-menu-asset-step-actions.png)

環境が正しいにもかかわらずアクションが表示されない場合は、関連する[ログ](where-are-my-log-files.md)を調べ、エラーがないかどうかを確認します。完全な出力を取得するには、[デバッグ ログを有効に](turn-debug-logging-on.md)しなければならない可能性があります。