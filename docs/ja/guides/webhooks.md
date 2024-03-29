---
layout: default
title: Webhook
pagename: shotgun-webhooks
lang: ja
---

# Webhook

Webhook を使用すると、ユーザがコントロールしているサービスに {% include product %} で発生したイベントを通知することができます。Webhook を作成する場合は、対象となるイベントのタイプを指定し、このイベントがトリガされたときにデータを送信する URL を {% include product %} に指示します。{% include product %} で関連イベントが発生すると、そのイベントを示すデータのペイロードが Webhook の URL に送信されます。これにより、{% include product %} との統合が緊密化され、ワークフローの一部を自動化することができます。

## Webhook を使用する例

Webhook には多くの使用事例があります。このドキュメントでは役立つ事例をいくつか紹介しますが、Webhook の使用はこれらの例に限定されません。

### エンティティを作成するときにディスク上にディレクトリ構造を作成する

{% include product %} で新しいエンティティを作成するときに何度も繰り返されてきたワークフローの 1 つとして、ディスク上にディレクトリ構造を作成することが挙げられます。{% include product %} で新しいショットを作成したら、作業を進めて、アーティストの作業準備が整っていることを自動的に確認できると便利です。

### ステータス管理の自動化

アニメーション チームが作業を終えたら、作業を進めて、同じショットに関する下流工程のタスクのステータスを変更し、開始できる作業が増えたことを知らせるようにしましょう。こうすることで、別の作業に割り当てられているアーティストに、準備ができていることを自動的に通知できます。

ステータス管理の自動化が役立つもう 1 つの例は、新しい `Note` を作成するときに、`Task` エンティティのステータス変更をトリガすることです。この方法は、アーティスト チームとプロダクション チームに、レビュー セッション後にスーパーバイザーから現在の作品を変更または修正するよう要求されたことを知らせる場合に便利です。

## {% include product %} のイベント デーモンではなく、Webhook を使用する場合

Webhook と [{% include product %} のイベント デーモン](https://github.com/shotgunsoftware/shotgunEvents/wiki)の機能は似ていますが、重要な違いがいくつかあります。イベント デーモンは、ユーザ独自のサービスを実行、監視、メンテナンスする必要があります。すべてのコードを Python で記述する必要があり、これによって {% include product %} との独自の接続を開始することが可能となります。対照的に、Webhook は複数の接続に対応し、任意のプログラム言語で記述することができます。これらは、[AWS Lambda](https://aws.amazon.com/lambda/) などのサーバレス環境でホストしたり、[Zapier](https://zapier.com) や [IFTTT](https://ifttt.com) などのオンラインで使用可能な任意の自動化プラットフォームをトリガしたりできます。Webhook を使用できるのであれば、Webhook がお勧めのソリューションです。

## Webhook を作成する

Webhook の作成を開始するには、**[Webhooks] (Webhooks)**ページに移動します。

![Webhook を作成ボタン](./images/webhooks/webhooks_page.png)

次に、**[Webhook を作成] (Create Webhook)**を選択します。 

![Webhook を作成ボタン](./images/webhooks/create_webhook_button_v3.png)

{% include info title="注" content="Webhook へのアクセスは、[高度な権限] (Advanced Permissions)の**[Webhook を表示] (Show Webhooks)**でコントロールします。管理者およびマネージャ権限ロールでは、このオプションは既定で有効になっています。![Webhook を作成ダイアログ](./images/webhooks/show_webhooks_permission.png)" %}

次に、新しい Webhook を作成するために必要な情報を入力します。

![Webhook を作成ダイアログ](./images/webhooks/create_webhook_dialog_v2.png)

### シークレット トークン

Webhook にシークレット トークンを割り当てる作業は省略できます。シークレット トークンを指定した場合、Webhook の URL に送信されるすべての要求はこのトークンを使用して署名されます。この要求と一緒にトークン値が送信されます(ヘッダ名は `X-SG-SIGNATURE`)。署名は HMAC および SHA1 を使用して計算され、署名されたメッセージが要求の本文(JSON 形式)になります。

![シークレット トークン](./images/webhooks/webhook_secret_token_v2.png)

#### ヘッダ形式

`<algorithm>=<signature>`

#### シークレット トークンを使用する理由

厳密に必要なわけではありませんが、シークレット トークンを指定すると、Webhook の URL に送信されるペイロードに署名が付けられます。これにより、カスタマー サービスは、データが予測された送信元から送信されていること、および送信中にペイロードがいかなる方法でも変更されなかったことを確認できます。

#### 署名の検証

Python を使用してペイロードの署名を確認する例の 1 つを、次に示します。

```python
>>> import hmac
>>> import hashlib
>>> body | `<json body>'
>>> token | `mytoken'
>>> 'sha1=' + hmac.new(token, body, hashlib.sha1).hexdigest()  == 'sha1=32824e0ea4b3f1ae37ba8d67ec40042f3ff02f6c'
True
```

### SSL 証明書を検証する

SSL 証明書の検証機能はオプションです。Webhook の使用者 URL に対する接続のセキュリティを確保する際に役立ちます。この機能を有効にすると、Webhook の URL に配信された場合、{% include product %} は OpenSSL の証明書検証ルーチンを使用して証明書を検証します。

![SSL 証明書を検証する](./images/webhooks/webhooks_validate_ssl_certificate_v2.png)

### バッチ形式で配信

![バッチ形式で配信](./images/webhooks/webhooks_batched_format.png)

[バッチ形式での配布の詳細については、こちらを参照してください](https://developer.shotgridsoftware.com/ja/e7890fc8/)。

### 不安定な場合に通知

**不安定な場合に通知**: Webhook が失敗したときに通知するユーザまたはグループを選択できます。この設定はオプションです。

![不安定な場合に通知](./images/webhooks/webhook_notifications_v2.png)

### プロジェクトとエンティティでフィルタする

特定のプロジェクト、エンティティ、フィールドを選択すると、Webhook へのトラフィックが最小限になるため、以下のことが可能になります。

- パフォーマンスを改善する
- リソースのコストを削減する
- 不要なバックログを防止する

![Webhook のフィルタ](./images/webhooks/webhook_project_entity_field_filter_v2.png)

{% include info title="注" content="プロジェクトを選択すると、「バージョン」のように常に 1 つのプロジェクトに属するエンティティを選択するように制限されます。ユーザなどのプロジェクト以外(またはマルチプロジェクト)のエンティティを選択する場合は、プロジェクトを**選択しないでください**。こうすることで、Webhook イベントをフィルタするときに、エンティティ更新のパフォーマンスにオーバーヘッドが生じることはなくなります。" %}

## Webhook のステータス

Webhook はさまざまなステータスを取ることができます(健全性や、配信を引き続き受信できるかどうか)。

![Webhook を作成ダイアログ](./images/webhooks/webhook_selected_status_v2.png)

| ステータス | 例 | 説明 |
|--------|:-------:|:-----------:|
| アクティブ | ![アクティブ](./images/webhooks/webhook_status_active.png) | Webhook の動作は安定しています。過去 24 時間以内に、この Webhook の使用者 URL に対する配信が宛先に到達しなかったことはありません。 |
| 不安定 | ![不安定](./images/webhooks/webhook_status_unstable.png) | Webhook の動作は不安定です。過去 24 時間以内に、一部の配信が宛先に到達しませんでしたが、Webhook が停止していると {% include product %} が判断するには不十分です。 |
| 失敗 | ![失敗](./images/webhooks/webhook_status_failed.png) | Webhook は停止していると判断されていて、配信はこれ以上試行されません。この原因は、短期間に発生した配信失敗の数が多すぎたことです。システムは、Webhook が使用できなくなったと判断しました。**過去 24 時間以内に配信が 100 回失敗すると、Webhook に障害があると見なされます**。 |
| 無効 | ![無効](./images/webhooks/webhook_status_disabled.png) | Webhook は無効な状態です。再度有効になるまで、配信はこれ以上試行されません。 |

## 配信

Webhook リスト内の Webhook を選択すると、この Webhook に行われたすべての配信が 7 日前まで遡って表示されます。

{% include info title="注" content="7 日前より古い配信のログは削除され、復元できません。" %}

### 配信ステータス

配信ステータスは、Webhook の URL に正常に配信されたかどうかを示します。

![配信ステータス](./images/webhooks/delivery_status_v2.png)

### 配信の詳細

配信を展開して、Webhook の URL に送信された要求およびこの要求に対する応答の詳細を表示することができます。

![配信の詳細](./images/webhooks/delivery_details_v2.png)

#### ペイロードの要求

Webhook の URL に送信されるペイロードには、{% include product %} で発生したイベントと、それをトリガしたユーザを示す情報が格納されています。この情報は、JSON 形式で提供されます。

{% include warning title="ペイロード サイズ" content="配信のペイロードの最大サイズは 1 MB です。ShotGrid でトリガされたイベントのうち、ペイロード サイズが 1 MB を超えるものは、`new_value` および `old_value` キーが削除され、発生したイベントの内容と、ShotGrid からイベント ログ エントリ全体を取得する理由および方法を示すメッセージが含まれている `warning` キーが追加されます。" %}

##### サンプル ペイロード

```json
{
  "data": {
    "id": "11777.3065.0",
    "meta": {
      "type": "attribute_change",
      "entity_id": 1246,
      "new_value": "*Add fog and mist with depth",
      "old_value": "*Add fog and mist.",
      "entity_type": "Shot",
      "attribute_name": "description",
      "field_data_type": "text"
    },
    "user": {
      "id": 88,
      "type": "HumanUser"
    },
    "entity": {
      "id": 1246,
      "type": "Shot"
    },
    "project": {
      "id": 122,
      "type": "Project"
    },
    "operation": "update",
    "created_at": "2022-02-01 20:53:08.523887",
    "event_type": "Shotgun_Shot_Change",
    "delivery_id": "3a5de4ee-8f05-4eac-b537-611e845352fc",
    "session_uuid": "dd6a1d6a-83a0-11ec-8826-0242ac110006",
    "attribute_name": "description",
    "event_log_entry_id": 545175
  },
  "timestamp": "2022-02-01T20:53:09Z"
}
```

##### セッション UUID

{% include product %} でイベントをトリガした `session_uuid` が、イベント ペイロードの一部として提供されます。この値は、[{% include product %} の Python API](https://developer.shotgridsoftware.com/python-api/reference.html?highlight=session_uuid#shotgun_api3.shotgun.Shotgun.set_session_uuid) に指定できます。この値を指定すると、session_uuid を持つ任意の開いているブラウザ セッションに、API によって生成されたイベントの更新が表示されます。

#### Webhook からの応答

![応答タブ](./images/webhooks/webhooks_response_tab.png)

[応答] (Response)タブには、配信に対する Webhook の応答に関する詳細が表示されます。 

Webhook の応答の HTTP ヘッダ、本文、および計測された応答時間を確認できます。

Webhook の応答の本文の最大文字数は 100 文字です。(上記のとおり、配信情報は確認のために 7 日間保持され、その後削除されます)。

{% include warning title="セキュリティ上のベスト プラクティス" content="Webhook の応答にセキュリティに関するデータを含めないでください。また、応答にシステム エラーの詳細を含めて返さないでください。" %}

### 配信に応答する

配信が正常に行われたとシステムが判断するためには、Webhook コンシューマ サービスが配信に応答する必要があります。

{% include warning title="応答のタイムアウト" content="Webhook の URL に配信されてから 6 秒以内に応答を受信する必要があります。6 秒が経過すると、接続は終了します。時間内に応答しなかった場合は、配信が失敗します。" %}

各配信の処理時間が記録され、[応答の詳細] (Response details)タブに表示されます。

#### 調整

使用者の配信への応答時間は、サイトの Webhook のスループットに影響します。

各サイトでは、1 分あたりの応答時間として 1 分が許可されます。そのため、サイトに設定されたコンシューマ エンドポイントが応答するまで丸々 6 秒かかった場合、このサイトの Webhook 配信数は 1 分あたり 10 に調整されます。

全体的なスループット レートを高くする必要がある場合は、次のモデルに従ってコンシューマ エンドポイントを設計する必要があります。
 1. 要求を受け取ります。
 2. 別のプロセス/スレッドをスポーンして、目的の方法で処理します。
 3. 確認応答 200 で即座に応答します。

#### ステータス コード

| ステータス | コード | 説明 |
|--------|:----:|:-----------:|
| 成功 | < 400 | 配信は受信されて、正常に処理されました。 |
| エラー | >= 400 | 配信は受信されましたが、正常に処理されませんでした。 |
| リダイレクト | 3xx | 配信は受信されましたが、別の URL にリダイレクトする必要があります。 |

### 確認応答

配信を更新して確認応答を含めることができます。配信時に、要求の一部としてヘッダが提供されます。これらのヘッダには、`x-sg-delivery-id` キーに格納されている配信レコードの ID が含まれます。この ID を使用して、[{% include product %} REST API](https://developer.shotgridsoftware.com/rest-api) を用いて配信レコードを更新し、確認応答を含めることができます。

{% include warning title="確認応答のサイズ" content="確認応答に割り当てられた最大サイズは 4 KB です。" %}

#### サンプル ヘッダ

```json
{
  "accept": "application/json",
  "content-type": "application/json; charset=utf-8",
  "x-sg-webhook-id": "30f279a0-42a6-4cf2-bb5e-6fc550d187c8",
  "x-sg-delivery-id": "dea7a71d-4896-482f-b238-b61820df8b65",
  "x-sg-event-batch-id": "1",
  "x-sg-event-batch-size": "4",
  "x-sg-webhook-site-url": "https://yoursite.shotgunstudio.com/",
  "x-sg-event-batch-index": "3"
}
```

#### 確認応答の用途

確認応答を使用すると、成功または失敗を示す詳細レポートを帯域外で送信し、Webhook の URL で正常に受信された配信を処理することができます。これにより、{% include product %} からの配信に関する受信ステータスを成功または失敗から切り離し、この配信に関連付けられているイベントを処理できるようになります。その結果、正常に配信されたイベントにデバッグに役立つ追加情報を含めることができます。 

適切な例として、`Asset` エンティティの作成時にトリガされる Webhook があります。新しい `Asset` ごとにディスク上にディレクトリ構造を 1 つ作成する作業を Webhook で行う場合、Webhook の URL は配信を正常に受信できますが、ディスクまたはネットワークが停止しているため、関連ディレクトリを作成することはできません。配信を受信した後、Webhook は、ディレクトリ構造が作成されなかったこと、およびその理由を示す詳細なエラー メッセージを使用して、配信記録を更新することができます。

## Webhook のテスト

無料公開されている任意の Webhook URL ジェネレータをオンラインで使用して、テストすることができます。これらのサービスは特に、Webhook やその他のタイプの HTTP 要求をテストすることを目的としています。この方法は、ネットワーク上にインフラストラクチャを設定しないで、Web について学習する場合に便利です。

### webhook.site を使用する

[webhook.site](https://webhook.site) をお勧めします。このサイトでは、コピーして Webhook に貼り付けることができる一意の URL が提供され、このアドレスへの配信がリアルタイムに表示されます。このページは、特定のステータス コードおよび本文を含む配信に応答するようにカスタマイズできます。つまり、配信の成功と失敗をテストすることができます。 

webhook.site サービスの速度は積極的に制限されます。つまり、一部の配信が拒否されて、Webhook が不安定になる、または停止することが容易に発生します。テストする場合は、プロダクションのライブ データではなく、既知のコントロール可能なプロジェクト環境を使用することをお勧めします。

{% include warning title="プロダクション データ" content="プロダクション イベント データを一般公開されているサードパーティの Web サービスに送信することはお勧めしません。テスト データの使用は、webhook.site のようなサービスを使用して Webhook をテストする場合に限定してください。" %}
