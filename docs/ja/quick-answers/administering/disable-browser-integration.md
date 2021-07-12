---
layout: default
title: ShotGrid Desktop のブラウザ統合を無効にするにはどうすればいいですか?
pagename: disable-browser-integration
lang: ja
---

# {% include product %} Desktop のブラウザ統合を無効にするにはどうすればいいですか?

ブラウザの統合を無効にするには、次の簡単な 2 つの手順を実行します。

1.  次のテキスト ファイルを作成または開く

        Windows: %APPDATA%\{% include product %}\preferences\toolkit.ini
        Macosx: ~/Library/Preferences/{% include product %}/toolkit.ini
        Linux: ~/.{% include product %}/preferences/toolkit.ini

2.  次のセクションを追加する

        [BrowserIntegration]
        enabled=0

ブラウザ統合の設定方法に関する詳細については、『[管理者ガイド](https://support.shotgunsoftware.com/hc/ja-jp/articles/115000067493-Integrations-Admin-Guide#Toolkit%20Configuration%20File)』を参照してください。

**別の方法**

Toolkit のパイプライン設定を引き継いだ場合は、代わりに [`tk-{% include product %}` エンジンを環境から削除](https://github.com/shotgunsoftware/tk-config-default2/blob/master/env/project.yml#L48)し、アクションがロードされないようにすることができます。
