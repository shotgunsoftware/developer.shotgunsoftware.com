---
layout: default
title: SSLHandshakeError CERTIFICATE_VERIFY_FAILED certificate verify failed
pagename: sslhandshakeerror-ssl-certificate-verify-failed
lang: ja
---

# SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed

## 使用例

ローカル パケット検査を行うファイアウォールを使用して設定されたローカル ネットワークで、次のエラー メッセージが表示されます。

```
SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:727)
```

これらのファイアウォールは、通常、ネットワーク管理者が自身で作成した、Python からアクセスできない自己署名証明書を使用して設定されています。他のアプリケーションとは異なり、Python は常に OS のキーチェーン内で証明書を検索するとは限らないため、ユーザ自身が指定する必要があります。

## 修正方法

Python API および Shotgun Desktop が信頼できる認証局についての完全なリストが含まれているディスク上のファイルを指すように、環境変数 `SHOTGUN_API_CACERTS` を設定する必要があります。

このような[コピー](https://raw.githubusercontent.com/certifi/python-certifi/master/certifi/cacert.pem)は、Github の `certifi` パッケージの最新コピーからダウンロードできます。この操作が完了したら、このファイルの最後にある企業ファイアウォールの公開鍵を追加して、保存する必要があります。

この操作が完了したら、環境変数 `/opt/certs/cacert.pem` をパスの場所(`SHOTGUN_API_CACERTS` など)に設定して、Shotgun Desktop を起動します。


## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/using-shotgun-desktop-behind-an-firewall-with-ssl-introspection/11434)を参照してください。