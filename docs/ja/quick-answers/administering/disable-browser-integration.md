---
layout: default
title: Shotgun Desktop のブラウザ統合を無効にするにはどうすればいいですか?
pagename: disable-browser-integration
lang: ja
---

# Shotgun Desktop のブラウザ統合を無効にするにはどうすればいいですか?

ブラウザの統合を無効にするには、次の簡単な 2 つの手順を実行します。

1. 次のテキスト ファイルを作成または開く

        Windows: %APPDATA%\Shotgun\preferences\toolkit.ini
        Macosx: ~/Library/Preferences/Shotgun/toolkit.ini
        Linux: ~/.shotgun/preferences/toolkit.ini

2. 次のセクションを追加する

        [BrowserIntegration]
        enabled=0

ブラウザ統合の設定方法に関する詳細については、『[管理者ガイド](https://support.shotgunsoftware.com/hc/ja-jp/articles/115000067493-Integrations-Admin-Guide#Toolkit%20Configuration%20File)』を参照してください。

**別の方法**

Toolkit のパイプライン設定を引き継いだ場合は、代わりに [`tk-shotgun` エンジンを環境から削除](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/project.yml#L48)し、アクションがロードされないようにすることができます。