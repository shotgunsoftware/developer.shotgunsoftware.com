---
layout: default
title: ローカルな {% include product %} サイトで {% include product %} Desktop を使用しているときに CERTIFICATE_VERIFY_FAILED が表示される
pagename: certificate-fail-local-error-message
lang: ja
---

# ローカルな {% include product %} サイトで {% include product %} Desktop を使用しているときに CERTIFICATE_VERIFY_FAILED が表示される

## 使用例:

{% include product %} のローカル インストールを使用する場合、このエラーは次の 2 つのシナリオで発生する可能性があります。

- {% include product %} Desktop にログインする場合
- Toolkit AppStore からメディアをダウンロードする場合

## 修正方法:

この問題を解決するには、すべての有効な CA のリスト(ユーザ独自のリストを含む)が格納されているファイルを {% include product %} API に提供する必要があります。通常は、最初に Python の `certifi` パッケージから[このファイル](https://github.com/certifi/python-certifi/blob/master/certifi/cacert.pem)の新しいコピーをダウンロードして、ファイルの末尾に独自の CA を追加することをお勧めします。次に、すべてのユーザがアクセスできる場所に、このファイルを保存します。最後に、各コンピュータで、環境変数 `SHOTGUN_API_CACERTS` をこのファイルのフル パスに設定します(例: `/path/to/my/ca/file.pem`)。

この操作を行うと、ローカル サイトで発生する `CERTIFICATE_VERIFY_FAILED` エラーが解決されます。{% include product %} サイトに接続できる場合でも、Toolkit AppStore から更新をダウンロードできないときは、`.pem` ファイルに Amazon CA が含まれていないことが原因である可能性があります。この状況は通常、空のファイルから開始して、カスタム CA のみを追加した場合に発生します。上記のリンク先ファイルなどから開始した場合は、問題が発生しません。

この情報は、ローカル インストールに*のみ*適用されることにご注意ください。ホスト サイトを使用しているときに、Windows 環境でこのエラーが発生する場合は、[このフォーラムの投稿](https://community.shotgridsoftware.com/t/certificate-verify-failed-error-on-windows/8860)を参照してください。エラーが別の OS で発生している場合は、[このドキュメント](https://developer.shotgridsoftware.com/ja/c593f0aa/)を参照してください。

## このエラーの原因の例:

この問題は通常、HTTPS を使用するようにローカルサイトが設定されているにもかかわらず、ローカル サイトの証明書への署名に使用した認証局(これ以降、CA と表記)が認識されるように Toolkit が設定されていない場合に発生します。

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/getting-certificate-verify-failed-when-using-shotgun-desktop-on-a-local-shotgun-site/10466)を参照してください。

