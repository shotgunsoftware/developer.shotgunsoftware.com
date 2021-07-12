---
layout: default
title: API
pagename: event-daemon-api
lang: ja
---

# API

<a id="registerCallbacks"></a>

## registerCallbacks

プラグインのイベント処理エントリ ポイントをフレームワークに伝えるために使用する、すべてのプラグインのグローバル レベル関数。

**registerCallbacks(reg)**

- reg: 呼び出す関数をフレームワークに伝えるために使用する [`Registrar`](#Registrar)。

<a id="Registrar"></a>

## Registrar

Registrar はプラグインの操作方法をフレームワークに伝えるために使用するオブジェクトです。これは、[`registerCallbacks`](#registerCallbacks) 関数に渡されます。

### アトリビュート

<a id="logger"></a>
**logger**

「[`getLogger`](#getLogger)」を参照してください。

### メソッド

<a id="getLogger"></a>
**getLogger**

プラグイン内からメッセージをログに記録するために使用する python Logger オブジェクトを取得します。

**setEmails(\*emails)**

このプラグインまたはそのコールバックのいずれかで問題が発生した場合に、エラーや重要な通知を受け取る電子メールを設定します。

設定ファイルで指定されている既定のアドレスに電子メールを送信する場合(既定)

```python
reg.setEmails(True)
```

電子メールを無効にする場合(エラー メッセージが表示されないため、この設定は推奨しません)

```python
reg.setEmails(False)
```

特定のアドレスに電子メールを送信する場合

```python
reg.setEmails('user1@domain.com')
```

または

```python
reg.setEmails('user1@domain.com', 'user2@domain.com')
```

<a id="registerCallback"></a>
**registerCallback(sgScriptName, sgScriptKey, callback, matchEvents=None, args=None, stopOnError=True)**

このプラグインのエンジンにコールバックを登録します。

- `sgScriptName`: {% include product %} スクリプト ページから取得したスクリプトの名前。
- `sgScriptKey`: {% include product %} スクリプト ページから取得したスクリプトのアプリケーション キー。
- `callback`: `__call__` メソッドを使用する関数またはオブジェクト。「[`exampleCallback`](#exampleCallback)」を参照してください。
- `matchEvents`: コールバックに渡すイベントのフィルタ。
- `args`: フレームワークをコールバックに戻す任意のオブジェクト。
- `stopOnError`: ブール型。このコールバックの例外は、このプラグイン内のすべてのコールバックによるイベントの処理を停止します。既定値は `True` です。

`sgScriptName` は、{% include product %} のプラグインを特定するために使用します。任意の名前を任意の数のコールバックで共有することも、1 つののコールバックに 1 つのみにすることもできます。

`sgScriptKey` は、{% include product %} のプラグインを特定するために使用し、指定した `sgScriptName` の適切なキーである必要があります。

指定したコールバック オブジェクトは、フィルタに一致するイベントの処理が必要な場合に呼び出されます。呼び出し可能なオブジェクトを実行することはできますが、ここでクラスを使用することは推奨しません。`__call__` メソッドを操作する関数やインスタンスを使用するほうが妥当です。

`matchEvent` 引数は、登録されているコールバックが関係するイベントを指定するフィルタです。`matchEvents` が指定されていない場合、または None が指定されている場合、すべてのイベントがコールバックに渡されます。それ以外の場合、`matchEvents` フィルタの各キーはイベント タイプです。各値は使用可能なアトリビュート名のリストです。

```python
matchEvents = {
    'Shotgun_Task_Change': ['sg_status_list'],
}
```

複数のイベント タイプやアトリビュート名を指定できます。

```python
matchEvents = {
    'Shotgun_Task_Change': ['sg_status_list'],
    'Shotgun_Version_Change': ['description', 'sg_status_list']
}
```

指定したアトリビュート名のイベント タイプをフィルタすることができます。

```python
matchEvents = {
    '*': ['sg_status_list'],
}
```

また、特定のイベント タイプの任意のアトリビュート名をフィルタすることもできます。

```python
matchEvents = {
    'Shotgun_Version_Change': ['*']
}
```

以下のように指定することもできますが、何も指定しない場合と同じようにしか機能しないため、実際には指定しても無意味です。

```python
matchEvents = {
    '*': ['*']
}
```

「\_New」や「\_Retirement」などのフィールド固有でないイベント タイプと照合する場合には、リストを指定するのではなく、`None` という値を渡します。

```python
matchEvents = {
    'Shotgun_Version_New': None
}
```

`args` 引数は、イベント フレームワーク自体では使用されません。変更せずにコールバックに戻されるだけです。

{% include info title="注" content="`args` 引数のポイントは、[`registerCallbacks`](#registerCallbacks) 関数で時間のかかる処理を行い、イベント処理時に戻り値を渡せるようにすることです。"%}

`args` 引数の別の使用方法として、`dict` などの一般的な可変値を複数のコールバックに渡してデータを共有するように指定できます。

`stopOnError` 引数は、このコールバックの例外によってプラグインのすべてのコールバックのイベント処理を停止するかどうかを伝えます。既定では `True` ですが、`False` に切り替えることもできます。イベントの処理を停止しない場合でも、エラーの通知メールが送信されます。コールバックごとに設定するため、重要なコールバックをユーザによって `True` または `False` にすることができます。

<a id="Callback"></a>

## コールバック

[`Registrar.registerCallback`](#registerCallback) によって登録するプラグイン エントリ ポイントは通常、次のようなグローバル レベル関数です。

<a id="exampleCallback"></a>
**exampleCallback(sg, logger, event, args)**

- `sg`: {% include product %} の接続インスタンス。
- `logger`: Python logging.Logger オブジェクトがあらかじめ設定されています。
- `event`: 処理する {% include product %} イベント。
- `args`: コールバックの登録時に指定する args 引数。

{% include info title="注" content="オブジェクト インスタンスで `__call__` メソッドとしてコールバックを使用できますが、ユーザの演習のみに使用するものとしておきます。"%}
