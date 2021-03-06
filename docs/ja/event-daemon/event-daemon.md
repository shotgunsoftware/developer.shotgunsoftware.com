---
layout: default
title: イベント駆動型トリガを記述する
pagename: event-daemon
lang: ja
---


# {% include product %} イベント フレームワーク
このソフトウェアは、[Rodeo Fx](http://rodeofx.com) と Oblique のサポートを受けて [Patrick Boucher](http://www.patrickboucher.com) により開発されました。これは現在、[{% include product %}ソフトウェア](http://www.shotgunsoftware.com)の[オープン ソース イニシアチブ](https://github.com/shotgunsoftware)の一部になっています。

このソフトウェアは、LICENSE ファイルまたは[オープン ソース イニシアチブ](http://www.opensource.org/licenses/mit-license.php)の Web サイトにある MIT ライセンスの下で提供されます。


## 概要

{% include product %} イベント ストリームにアクセスする場合の望ましい方法として、イベント テーブルを監視し、新しいイベントを取得し、イベントを処理して、また同じ手順を繰り返します。

このプロセスを成功させるためには多くの要素が必要ですが、それらの中には、適用すべきビジネス ルールに直接関係しないものがあります。

フレームワークの役割は、退屈な監視タスクをビジネス ロジックの実装作業から分離することです。

フレームワークはサーバ上で動作し、{% include product %} のイベント ストリームを監視するデーモン プロセスです。イベントが見つかったら、デーモンはイベントを一連の登録済みのプラグインに渡します。各プラグインは、意図したとおりにイベントを処理できます。

デーモンは次を処理します:

- 1 つまたは複数の指定したパスからプラグインを登録する。
- クラッシュするプラグインを非アクティブ化する。
- プラグインがディスク上で変更された場合に再ロードする。
- {% include product %} のイベント ストリームを監視する。
- 最後に処理されたイベント ID とバックログを記憶する。
- デーモンの起動時に、最後に処理されたイベント ID から開始する。
- 接続エラーを検出する。
- 必要に応じて、stdout、ファイル、または電子メールに情報を記録する。
- コールバックによって使用される {% include product %} への接続を作成する。
- 登録されたコールバックにイベントを渡す。

プラグイン ハンドル:

- 任意の数のコールバックをフレームワークに登録する。
- フレームワークによって提供された 1 つのイベントを処理する。


## フレームワークの利点

- スクリプトごとに 1 つではなく、すべてのスクリプトに対して単一の監視メカニズムのみを扱います。
- ネットワークおよびデータベースのロードを最小限に抑えます(多くのイベント処理プラグインにイベントを提供するただ 1 つのモニタ)。

