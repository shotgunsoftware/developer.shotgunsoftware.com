---
layout: default
title: デスクトップ サーバ フレームワーク
pagename: tk-framework-desktopserver
lang: ja
---

# Toolkit デスクトップ サーバ フレームワーク

デスクトップ サーバ フレームワークは、{% include product %} のローカル ファイル リンクと Toolkit による統合で使用します。デスクトップ アクセスを必要とするアクションに、{% include product %} Web サイトからの要求を安全にリッスンするローカル Websocket サーバを提供します。

ローカル ファイル リンクの場合、この要求により、{% include product %} は Web インタフェースからローカル ファイル パスにアクセスし、要求時に {% include product %} ページからこのファイルを直接開くことができます。Toolkit の場合、この要求により、{% include product %} は任意のエンティティに登録されたパイプライン アクションを特定し、そのアクションを実行できます。

## デスクトップ統合を実行する方法

この {% include product %} 機能を使用するには、サポートされたデスクトップ統合が実行されている必要があります。{% include product %} とデスクトップを統合する場合のさまざまなオプションについては、[こちらのページ](https://developer.shotgridsoftware.com/ja/c79f1656/)を参照してください。Websocket サーバのセクションでは、このフレームワークが提供する機能について説明します。

### {% include product %} Desktop

このフレームワークは、{% include product %} Desktop にバンドルされています。Desktop は、[こちらに記載されている手順](https://developer.shotgridsoftware.com/ja/d587be80/#installation-of-desktop)でダウンロードできます。{% include product %} Desktop を実行すると、Websocket サーバが自動的に起動されます。{% include product %} Desktop を既に実行している場合、セットアップ プロセスは完了しています。

### サーバを設定する

設定ファイルにブラウザ統合設定を保存できます。この環境設定ファイルを指定するには、環境変数 `SGTK_BROWSER_INTEGRATION_CONFIG_LOCATION` を設定します。ローカル サーバの設定方法については、[サンプル ファイル](https://github.com/shotgunsoftware/tk-framework-desktopstartup/blob/master/config.ini.example)を参照してください。

### 証明書を削除する

作成した証明書を削除する場合は、`python certificates.py --remove` コマンドを実行することができます。

## ラッパーを使用して起動する

既定では、サーバはオペレーティング システムの既定値を使用してコマンド(Linux では「xdg-open」、OS X では「open」、Windows では「run」に相当)を起動します。ファイルを起動するために独自のラッパーを指定する場合は、カスタム ラッパーを指定するように環境変数 **SHOTGUN_PLUGIN_LAUNCHER** を設定します。設定されている場合は、ラッパーはその唯一の引数としてパスで呼び出されます。

## 証明書

サーバを初めて実行すると、安全な接続の確立に必要な証明書が生成されます。この証明書はマシンのローカルに保存され、公開されることはありません。証明書により、Web ソケットで必要とされる暗号化された接続が可能になります。これはすべてのトラフィックがローカル(ブラウザからサーバ)のままでも必要です。{% include product %} の Websocke トラフィックはインターネットで利用可能になることはありません。

証明書がシステムに登録されると、次のようなダイアログが表示されます。登録を続行するには、[OK]をクリックしてください。

![](images/osx_warning_1.jpg) ![](images/windows_warning_1.jpg) ![](images/windows_warning_2.jpg)


{% include product %} Desktop を使用する場合、生成された証明書は次の場所に保存されます。

**OS X**: ~/Library/Caches/Shotgun/desktop/config/certificates<br/>
**Windows**: %AppData%\\Shotgun\\desktop\\config\\certificates<br/>
**Linux**: ~/.shotgun/desktop/config/certificates<br/>

## セキュリティ セットアップ: ローカルの {% include product %} にインストール

既定では、Websocket サーバはポート 9000 でホストされる {% include product %} サイトをリッスンするようにセットアップされます。ローカルで {% include product %} サーバを実行する場合、Websocket サーバからの接続を許可するように、{% include product %} サーバの設定を更新する必要があります。

{% include product %} Desktop を実行する場合は、{% include product %} のバイナリ ファイルを含む ```config.ini``` ファイルを設定する必要があります。 

このファイル内に Websocket サーバの機能を制御するセクションがあります。一般的な設定は次のようになります。

```ini
[BrowserIntegration]
low_level_debug=0
port=9000
enabled=1
whitelist=*.shotgunstudio.com
```

## トラブルシューティング

Linux 上でサーバは libffi に依存しています。Desktop が起動時にクラッシュし、libffi が見つからないというメッセージがログに記録された場合は、このパッケージをインストールする必要があります。

セットアップ時に問題が発生したり、不明な点がある場合は、[サポート サイト](https://knowledge.autodesk.com/ja/contact-support)をご覧ください。サーバの実行に関して問題が発生する場合は、**config.ini** ファイルの **debug** を **1** に設定して、Desktop のログ ファイルを追加します。

ログ ファイルは次の場所にあります。

**OS X**: ~/Library/Logs/Shotgun/tk-desktop.log<br/>
**Windows**: ~%APPDATA%\\Shotgun\\tk-desktop.log<br/>
**Linux**: ~/.shotgun/tk-desktop.log<br/>
