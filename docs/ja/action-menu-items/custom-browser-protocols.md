---
layout: default
title: カスタム ブラウザ プロトコルを使用してアプリケーションを起動する
pagename: custom-browser-protocols
lang: ja
---

# カスタム ブラウザ プロトコルを使用してアプリケーションを起動する

## コンテンツ

- [プロトコルを登録する](#registering-a-protocol)
   - [Windows 上でプロトコルを登録する](#registering-a-protocol-on-windows)
   - [Mac OSX 上でプロトコルを登録する](#registering-a-protocol-on-osx)
   - [Linux 上でプロトコルを登録する](#registering-a-protocol-on-linux)

[アクション メニュー アイテム]()(AMI)の極めて実用的な使用方法は、ローカル コンピュータ上でアプリケーションまたはスクリプトを 1 つのバリアントで実行することです。これを機能させるには、ブラウザと実行するスクリプトまたはアプリケーションとの間に接続をセットアップする必要があります。このリンクはカスタム ブラウザ プロトコルと呼ばれます。

たとえば、ユーザがクリックすると、[foo] アプリケーションが起動するようなリンクをセットアップするとします。プリフィックスに「http」ではなく、「foo」などのカスタム プロトコルを指定する必要があります。理想的には、次のようなリンクが必要です。
```
foo://some/info/here
```

オペレーティング システムにはプロトコルの処理方法を通知する必要があります。既定では、「http」は既定の Web ブラウザで処理され、「mailto」は既定のメール クライアントで処理されると、現在のすべてのオペレーティング システムは認識しています。アプリケーションがインストールされると、OS に登録され、特定のプロトコルでそのアプリケーションを起動するよう OS に指示する場合があります。

たとえば、RV をインストールした場合、アプリケーションは `rvlink://` を OS に登録し、RV がすべての `rvlink://` プロトコル要求を処理して RV にイメージまたはシーケンスを表示するように指示します。そのため、ユーザが {% include product %} と同じように `rvlink://` で始まるリンクをクリックすると、オペレーティング システムはこのリンクで RV を起動することを認識し、アプリケーションはこのリンクを解析して処理方法を認識できます。

RV が URL と「rvlink」プロトコルのプロトコル ハンドラとしてどのように機能するかについては、[RV のユーザ マニュアル](https://help.autodesk.com/view/SGSUB/JPN/?guid=SG_RV_rv_manuals_rv_user_manual_rv_user_manual_chapter_c_html#c-2-installing-the-protocol-handler)を参照してください。

# プロトコルを登録する

## Windows 上でプロトコルを登録する

Windows でプロトコル ハンドラを登録するには、Windows レジストリを変更します。レジストリ キーは一般的に次のようになります。

```
HKEY_CLASSES_ROOT
foo
(Default) = "URL:foo Protocol"
URL Protocol = ""
shell
open
command (Default) = "foo_path" "%1"
```
ターゲット URL は次のようになります。

```
foo://host/path...
```

> **注:** 詳細については、[https://msdn.microsoft.com/ja-jp/library/aa767914(VS.85).aspx](https://docs.microsoft.com/ja-jp/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa767914(v=vs.85)?redirectedfrom=MSDN) を参照してください。
> **Windows QT/QSetting の例**

開発しているアプリケーションが QT (または PyQT/PySide)フレームワークを使用して記述されている場合は、QSetting オブジェクトを利用してレジストリ キーの作成を管理できます。

アプリケーションがレジストリ キーを自動的にセットアップする場合のコードは次のようになります。

```
// cmdLine points to the foo path.
//Add foo to the Os protocols and set foobar to handle the protocol
QSettings fooKey("HKEY_CLASSES_ROOT\\foo", QSettings::NativeFormat);
mxKey.setValue(".", "URL:foo Protocol");
mxKey.setValue("URL Protocol", "");
QSettings fooOpenKey("HKEY_CLASSES_ROOT\\foo\\shell\\open\\command", QSettings::NativeFormat);
mxOpenKey.setValue(".", cmdLine);
```

**{% include product %} AMI を介して Python スクリプトを開始する Windows の例**

ローカルで動作する AMI の多くは、Python インタプリタを介して単純な Python スクリプトを開始することができます。これにより、単純なスクリプトに加えて、GUI (PyQT、PySide、または選択した GUI フレームワーク)を使用したアプリも実行することができます。この目標のために役立つ実例を見てみましょう。

**手順 1: カスタム「{% include product %}」プロトコルをセットアップする**

Windows レジストリ エディターを使用します。

```
[HKEY_CLASSES_ROOT\{% include product %}]
@="URL:{% include product %} Protocol"
"URL Protocol"=""
[HKEY_CLASSES_ROOT\{% include product %}\shell]
[HKEY_CLASSES_ROOT\{% include product %}\shell\open]
[HKEY_CLASSES_ROOT\{% include product %}\shell\open\command]
@="python""sgTriggerScript.py""%1"
```

このセットアップでは、最初の引数がスクリプト `sgTriggerScript.py` で、2 番目の引数が `%1` である `python` インタプリタを起動するための `{% include product %}://` プロトコルが登録されます。 `%1` が、ブラウザでクリックされた URL または呼び出された AMI の URL に置き換えられることを理解することが重要です。これが Python スクリプトの最初の引数になります。

> **注:** Python インタプリタと Python スクリプトへのフル パスが必要となる場合があります。適宜調整してください。

**手順 2: Python スクリプトで受信 URL を解析する**

スクリプト内で、指定された最初の引数である URL を取得し、AMI が呼び出されたコンテキストを把握するためにそのコンポーネントまで解析します。次のコードに、これを行う方法を示す簡単なスクリプトの例を示しています。

**Python スクリプト**

```
import sys
import urlparse
import pprint
def main(args):
    # Make sure we have only one arg, the URL
    if len(args) != 1:
        return 1
    # Parse the URL:
    protocol, fullPath = args[0].split(":", 1)
    path, fullArgs = fullPath.split("?", 1)
    action = path.strip("/")
    args = fullArgs.split("&")
    params = urlparse.parse_qs(fullArgs)
    # This is where you can do something productive based on the params and the
    # action value in the URL. For now we'll just print out the contents of the
    # parsed URL.
    fh = open('output.txt', 'w')
    fh.write(pprint.pformat((action, params)))
    fh.close()
if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
```

**手順 3: {% include product %} インタフェースをカスタム プロトコルと接続し、最終的にスクリプトと接続する**

最後に、URL 値が {% include product %} になる `shotgrid://processVersion` の AMI を作成します。この AMI は任意のエンティティ タイプに割り当てることができますが、この例ではバージョン エンティティを使用します。

バージョン ページに移動し、バージョンを右クリックして、メニューから AMI を選択します。これにより、ブラウザで `shotgrid://` URL が開かれ、登録されたカスタム プロトコルを介してスクリプトにリダイレクトされます。

スクリプトと同じフォルダにある `output.txt` ファイルの内容が、次のようになります。
```
('processVersion',
 {'cols': ['code',
           'image',
           'entity',
           'sg_status_list',
           'user',
           'description',
           'created_at'],
  'column_display_names': ['Version Name',
                           'Thumbnail',
                           'Link',
                           'Status',
                           'Artist',
                           'Description',
                           'Date Created'],
  'entity_type': ['Version'],
  'ids': ['6933,6934,6935'],
  'page_id': ['4606'],
  'project_id': ['86'],
  'project_name': ['Test'],
  'referrer_path': ['/detail/HumanUser/24'],
  'selected_ids': ['6934'],
  'server_hostname': ['patrick.shotgunstudio.com'],
  'session_uuid': ['9676a296-7e16-11e7-8758-0242ac110004'],
  'sort_column': ['created_at'],
  'sort_direction': ['asc'],
  'user_id': ['24'],
  'user_login': ['shotgun_admin'],
  'view': ['Default']})
```

**考えられるバリエーション**

AMI で URL の `//` の後にあるキーワードを変更することで、同じ `shotgrid://` プロトコルを維持したままスクリプト内の `action` 変数の内容を変更し、単一のカスタム プロトコルのみを登録することができます。これにより、`action` 変数の内容とパラメータの内容に基づいて、スクリプトが意図された動作を把握できます。

この方法を使用することで、アプリケーションの起動、FTP などのサービスを介したコンテンツのアップロード、データのアーカイブ、電子メールの送信、または PDF レポートの生成を行うことができます。

## Mac OSX 上でプロトコルを登録する

Mac OSX でプロトコルを登録するには、アプリケーションまたはスクリプトを実行するように設定された .app バンドルを作成する必要があります。

まず、AppleScript スクリプト エディタで次のスクリプトを記述します。

```
on open location this_URL
    do shell script "sgTriggerScript.py '" & this_URL & "'"
end open location
```

> **ヒント:** tcsh などの特定のシェルから Python を確実に実行するには、do シェル スクリプトを次のように変更します。
>
>     do shell script "tcsh -c \"sgTriggerScript.py '" & this_URL & "'\""
In the Script Editor, save your short script as an “Application Bundle”.

保存したアプリケーション バンドルを見つけて、Open Contents を選択します。次に、info.plist ファイルを開き、次のコードを plist dict に追加します。
```
    <key>CFBundleIdentifier</key>
    <string>com.mycompany.AppleScript.Shotgun</string>
    <key>CFBundleURLTypes</key>
    <array>
      <dict>
        <key>CFBundleURLName</key>
        <string>Shotgun</string>
        <key>CFBundleURLSchemes</key>
        <array>
          <string>shotgun</string>
        </array>
      </dict>
    </array>
```

次の 3 つの文字列を変更することもできます。
```
com.mycompany.AppleScript.{% include product %}
{% include product %}
{% include product %}
```

3 番目の文字列はプロトコル ハンドラです。そのため、URL は次のようになります。

```
shotgrid://something
```


最後に、`.app` バンドルを Mac のアプリケーション フォルダに移動します。このバンドルをダブルクリックすると、プロトコルがオペレーティング システムに登録されます。

{% include product %} で AMI をクリックするか、`shotgrid://` で始まる URL をクリックすると、`.app` バンドルがそれに応答して URL を Python スクリプトに渡す、というようなデータ フローになります。この時点で、Windows の例で使用したものと同じスクリプトを使用でき、同じことができるようになります。

## Linux 上でプロトコルを登録する

次のコードを使用します。
```
gconftool-2 -t string -s /desktop/gnome/url-handlers/foo/command 'foo "%s"'
gconftool-2 -s /desktop/gnome/url-handlers/foo/needs_terminal false -t bool
gconftool-2 -s /desktop/gnome/url-handlers/foo/enabled true -t bool
```
次に、次の場所にあるグローバル既定値にローカル GConf ファイルの設定を使用します。
```
/etc/gconf/gconf.xml.defaults/%gconf-tree.xml
```

この変更は GNOME 設定でのみ行われますが、KDE でも機能します。Firefox と GNU IceCat は、不明なプレフィックス(`foo://` など)を検出したときに、実行しているウィンドウ マネージャに関係なく gnome-open に従います。 そのため、KDE の Konqueror のような他のブラウザは、このシナリオでは機能しません。

Ubuntu でアクション メニュー アイテムのプロトコル ハンドラをセットアップする方法については、[https://askubuntu.com/questions/527166/how-to-set-subl-protocol-handler-with-unity](https://askubuntu.com/questions/527166/how-to-set-subl-protocol-handler-with-unity) を参照してください。