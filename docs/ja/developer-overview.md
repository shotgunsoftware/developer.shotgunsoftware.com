---
layout: default
title: 開発の概要
pagename: developer-overview
lang: ja
---

# 開発の概要

### Python API

{% include product %} ソフトウェアは、Python ベースの API を使用して {% include product %} にアクセスし、他のツールと連携します。API は CRUD パターンに従い、{% include product %} サーバで作成、読み取り、更新、および削除のアクションを実行できます。各リクエストは単一のエンティティ タイプに従って動作し、アクションに応じて、フィルタ、返される列、ソート情報、およびいくつかの追加オプションを定義できます。

* [コード リポジトリ](https://github.com/shotgunsoftware/python-api)
* [ドキュメント](http://developer.shotgridsoftware.com/python-api/)
* [フォーラム](https://community.shotgridsoftware.com/c/pipeline/6)

### イベント トリガ フレームワーク

{% include product %} イベント ストリームにアクセスする場合の望ましい方法として、イベント テーブルを監視し、新しいイベントを取得し、イベントを処理して、また同じ手順を繰り返します。

このプロセスを成功させるためには多くの要素が必要ですが、それらの中には、適用すべきビジネス ルールに直接関係しないものがあります。

フレームワークの役割は、退屈な監視タスクをビジネス ロジックの実装作業から分離することです。

フレームワークはサーバ上で動作し、{% include product %} のイベント ストリームを監視するデーモン プロセスです。イベントが見つかったら、デーモンはイベントを一連の登録済みのプラグインに渡します。各プラグインは、意図したとおりにイベントを処理できます。

* [コード リポジトリ](https://github.com/shotgunsoftware/shotgunevents)
* [説明](https://github.com/shotgunsoftware/shotgunevents/wiki)

### アクション メニュー アイテム フレームワーク

API 開発者は、エンティティ単位でコンテキスト メニュー項目をカスタマイズできます。たとえば、Versions ページから複数のバージョンを選択して右クリックし、(たとえば) PDF レポートを作成します。これらを ActionMenuItems (AMIs)と呼びます。

* [ドキュメント]()
* [サンプル コード リポジトリ](http://developer.shotgridsoftware.com/python-api/cookbook/examples/ami_handler.html)
