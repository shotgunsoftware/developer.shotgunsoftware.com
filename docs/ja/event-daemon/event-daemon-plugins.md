---
layout: default
title: プラグイン
pagename: event-daemon-plugins
lang: ja
---

# プラグインの概要

プラグイン ファイルは、環境設定ファイルで指定されたプラグイン パス内の *.py* ファイルです。

コードのダウンロード先の `src/examplePlugins` フォルダには、サンプル プラグインがいくつか用意されています。これらは、生成された特定のイベントを検索して処理し、{% include product %} インスタンスの他の値を変更するための独自のプラグインを構築する方法の簡単な例を示します。

プラグインを更新するたびにデーモンを再起動する必要はありません。デーモンは、プラグインが更新されたことを検出して自動的に再ロードします。

プラグインがエラーを生成しても、デーモンがクラッシュすることはありません。プラグインは、再度更新されるまで無効になります(修正した場合も同様に動作するようリクエスト中)。その他のプラグインは引き続き実行され、イベントが処理されます。デーモンは、中断されたプラグインが正常に処理された最後のイベント ID を追跡します。プラグインが更新(および修正)されると、デーモンはプラグインを再ロードし、プラグインが終了した時点からイベントを処理しようとします。すべて正常に実行されると、デーモンは現在のイベントまでのプラグインを捕捉し、すべてのプラグインを通常のものとして使用してイベントを処理し続けます。

{% include product %} イベント処理プラグインは、コールバック登録関数と任意の数のコールバックという 2 つの主要な部分で構成されます。

<a id="registerCallbacks_function"></a>
## registerCallbacks 関数

フレームワークによってロードするには、プラグインは少なくとも次の関数を実装する必要があります。

```python
def registerCallbacks(reg):
    pass
```

この関数は、イベントを処理するために呼び出す関数をイベント処理システムに通知するために使用されます。

この関数は、1 つの引数を取る必要があり、それは [`Registrar`](./event-daemon-api.md#Registrar) オブジェクトです。

[`Registrar`](./event-daemon-api.md#Registrar) には非常に重要なメソッドが 1 つあります: [`Registrar.registerCallback`](./event-daemon-api.md#registercallback)

{% include product %} イベントを処理する必要がある関数ごとに、[`Registrar.registerCallback`](./event-daemon-api.md#registerCallback) を、適切な引数で 1 回ずつ呼び出します。

関数は必要な数だけ登録できます。また、ファイル内のすべての関数をイベント処理コールバックとして登録する必要はありません。

<a id="Callbacks"></a>
## コールバック

システムに登録されるコールバックは、次の 4 つの引数を取る必要があります。

- 追加情報について {% include product %} にクエリーする必要がある場合の {% include product %} 接続インスタンス。
- レポートに使用する必要がある Python Logger オブジェクト。エラー メッセージと極めて重要なメッセージは、設定された任意のユーザに電子メールで送信されます。
- 処理する {% include product %} イベント。
- コールバックの登録時に渡される `args` 値。([`Registrar.registerCallback`](./event-daemon-api.md#wiki-registerCallback) を参照)

{% include info title="警告" content="プラグインでは必要なすべての処理を実行できますが、例外がフレームワークに戻った場合、問題のあるコールバック(および含まれているすべてのコールバック)が存在するプラグインは、ディスク上のファイルが変更されるまで非アクティブ化されます(読み取り: 修正)。" %}

<a id="Logging"></a>
## ログ記録

イベント プラグインで print 文を使用することはお勧めしません。Python 標準ライブラリの標準ロギング モジュールを使用することをお勧めします。ロガー オブジェクトは、さまざまな関数に提供されます。

```python
def registerCallbacks(reg):
    reg.setEmails('root@domain.com', 'tech@domain.com') # Optional
    reg.logger.info('Info')
    reg.logger.error('Error') # ERROR and above will be sent via email in default config
```

および

```python
def exampleCallback(sg, logger, event, args):
    logger.info('Info message')
```

イベント フレームワークがデーモンとして実行されている場合、これはファイルに記録されます。それ以外の場合は stdout に記録されます。

<a id="Robust"></a>
## 堅牢なプラグインの構築

デーモンは {% include product %} に対してクエリーを実行しますが、find() コマンドが失敗した場合に再試行する機能が組み込まれているため、デーモン自体には一定の堅牢性があります。

[https://github.com/shotgunsoftware/shotgunEvents/blob/master/src/shotgunEventDaemon.py#L456](https://github.com/shotgunsoftware/shotgunEvents/blob/master/src/shotgunEventDaemon.py#L456)

プラグインにネットワーク リソース({% include product %} または他のリソース)が必要な場合は、独自の再試行メカニズムや堅牢性を提供する必要があります。{% include product %} アクセスの場合、デーモンの内容を確認して、プラグインにその機能を提供できるヘルパー関数またはクラスを作成することができます。

{% include product %} Python API は既にネットワークの問題に対してあるレベルの再試行を実行できますが、数分間実行される {% include product %} のメンテナンス ウィンドウのタイミングにぶつかったり、ネットワーク障害が発生した場合、これでは十分ではない場合があります。

[https://github.com/shotgunsoftware/python-api/blob/master/shotgun_api3/shotgun.py#L1554](https://github.com/shotgunsoftware/python-api/blob/master/shotgun_api3/shotgun.py#L1554)

プラグインの機能に応じて、イベントの処理中に問題が発生した場合に追跡を続けるために登録することもできます。registerCallback 関数の stopOnError 引数を参照してください。

[https://github.com/shotgunsoftware/shotgunEvents/wiki/API#wiki-registerCallback](https://github.com/shotgunsoftware/shotgunEvents/wiki/API#wiki-registerCallback)

{% include info title="注" content="プラグインは停止しませんが、失敗した試行は再試行されません。" %}
