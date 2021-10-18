---
layout: default
title: アプリを起動
pagename: tk-multi-launchapp
lang: ja
---

# アプリを起動

このアプリを使用すると、{% include product %} からサポート対象のアプリケーションに簡単に移動できます。選択した設定に応じて、{% include product %} のさまざまなエンティティを呼び出す {% include product %} アクション項目を登録します。

## 仕組み

設定するオプションによって異なりますが、エンティティを右クリックしたり、{% include product %} アクション メニューや歯車メニューをクリックすると、メニュー項目が {% include product %} に表示されます。

たとえば、これはサイトの設定でこのアプリを 3 回使用し、Maya、Nuke、Photoshop にメニューを実装した場合のスクリーンショットです。

![タスク アクション メニュー](../images/apps/multi-launchapp-tank_actions_menu.png)

現在サポートされているアプリケーションとエンジンは次のとおりです。

* 3DSMax
* Hiero
* Maya
* MotionBuilder
* Nuke
* Photoshop
* Mari
* Houdini
* Softimage
* Flame

### 起動時にコマンド ライン引数を使用する

多くのアプリケーションにはコマンド ライン オプションがあり、異なるエディションのアプリケーションを選択したり( Nuke と NukeX など)、使用に関する他のさまざまな設定を行う際に呼び出すことができます。ランチャーのアプリには、この目的に合わせて設定できる各 OS 用の「引数」の設定があります。たとえば、ここで「--nukex」と設定すると、これがコマンド ラインの起動に追加され、NukeX が通常の Nuke の代わりに実行されます。

---FOLD---
NukeX の起動の例

```yaml
launch_nuke:
  engine: tk-nuke
  extra: {}
  hook_app_launch: default
  hook_before_app_launch: default
  linux_args: '--nukex'
  linux_path: '@nuke_linux'
  location: {name: tk-multi-launchapp, type: app_store, version: v0.2.15}
  mac_args: '--nukex'
  mac_path: '@nuke_mac'
  menu_name: Launch Nuke
  windows_args: '--nukex'
  windows_path: '@nuke_windows'
```
---FOLD---

### 環境変数を設定して起動時に動作を自動化する

多くの場合、アプリケーションには、パイプラインで適切に機能するように設定された特定の環境変数やプラグイン パスなどが 必要になります。起動アプリケーションは「before_app_launch」フックを介してこのようなケースをカバーしており、アプリケーションの起動のたびに実行されるコードのスニペットを定義できます。既定では、「before_app_launch」フックは何も実行しない単純なパススルーですが、<a href='https://developer.shotgridsoftware.com/425b1da4/#hooks'>このドキュメント</a>の説明に従ってオーバーライドできます。

たとえば、Zync Render を使用する場合は、Zync Maya プラグイン ディレクトリを `$PYTHONPATH` と `$XBMLANGPATH` の両方に含める必要があります。起動アプリでこの環境変数を設定するには、次のように `before_app_launch` フックのコード数行を更新します。

---FOLD---
環境変数の設定例

```python
def execute(self, **kwargs):
    """
    The execute functon of the hook will be called to start the required application        
    """

    # Example to show how to set env vars on Maya launch

    # Append the desired path to the existing $PYTHONPATH to ensure
    # everything upstream still works
    os.environ["PYTHONPATH"] = os.environ["PYTHONPATH"] + os.pathsep + "~/Library/zync/zync-maya"

    # Set $XBMLANGPATH to the desired path, may need to append it as
    # with $PYTHONPATH if already defined in your pipeline
    os.environ["XBMLANGPATH"] = "~/Library/zync/zync-maya"
```
---FOLD---

「before_app_launch」を使用すると、{% include product %} の更新など、他の動作を自動化することもできます。たとえば、起動アプリが実行されるたびに(タスクからの起動のみ)タスク ステータスが更新されるように起動アプリを設定できます。次の例では「in progress」に更新するよう設定しています。

---FOLD---
タスク ステータス更新の自動化の例

```python
def execute(self, **kwargs):
    """
    The execute functon of the hook will be called to start the required application        
    """

    # If there is a Task in the context, set its status to 'ip'

    if self.parent.context.task:
        task_id = self.parent.context.task['id']
        data = {
            'sg_status_list':'ip'
        }
        self.parent.shotgun.update("Task", task_id, data)
```
---FOLD---

ご想像のとおり、多くの選択肢があります。起動アプリの目的は、パイプラインのニーズに合わせた柔軟性を提供することです。

### エンジンをまだ指定していないアプリケーションを起動する

起動アプリケーションを使用して、Toolkit のエンジンをまだ指定していないアプリケーションを起動することもできます。この場合、フォルダは、起動元のショット、タスク、またはアセットのディスク上に作成されます。アプリケーションは起動されますが、アプリケーション起動後にコードは実行されず、アプリケーション内に {% include product %} メニューは表示されません。つまり、{% include product %} 内の Toolkit でサポートされていないアプリケーションを起動できます。

これを行うには、エンジンのオプションを空にしたまま、起動するアプリケーションのパスを起動アプリケーションに指定します。

## 技術の詳細

### 3DSMax

このアプリは、3DSMax が起動プロセスの一部として実行する 3DSMax コマンド ラインに、MaxScript の `init_tank.ms` を自動的に追加します。

3DSMax が起動すると、次のプロセスが実行されます。

1. 3DSMax が起動時に `init_tank.ms` を実行します。
1. `init_tank.ms` により、Python インタプリタが利用可能で `tank_startup.py` が実行されることが確認されます。
1. {% include product %} Toolkit コンテキスト API を使用して、{% include product %} から渡されたエンティティ ID が Toolkit コンテキストに変換されます。
1. `tank.system.start_engine()` を介して適切なエンジンを起動し、コンテキストに渡します。エンジンが残りのプロセスを処理します。

### Maya

このアプリは `userSetup.py` 自動開始スクリプトを Maya に登録し、Maya はそれを起動プロセスの一部として呼び出します。

Maya が起動すると、次のプロセスが実行されます。

1. Maya が `userSetup.py` 起動スクリプトの実行を開始します
1. {% include product %} Toolkit コンテキスト API を使用して、{% include product %} から渡されたエンティティ ID が Toolkit コンテキストに変換されます。
1. `tank.system.start_engine()` を介して適切なエンジンを起動し、コンテキストに渡します。エンジンが残りのプロセスを処理します。

### MotionBuilder

このアプリは `init_tank.py` 自動開始スクリプトを MotionBuilder に登録し、MotionBuilder はそれを起動プロセスの一部として呼び出します。

MotionBuilder が起動すると、次のプロセスが実行されます。

1. MotionBuilder が `init_tank.py` 起動スクリプトの実行を開始します
1. {% include product %} Toolkit コンテキスト API を使用して、{% include product %} から渡されたエンティティ ID が Toolkit コンテキストに変換されます。
1. `tank.system.start_engine()` を介して適切なエンジンを起動し、コンテキストに渡します。エンジンが残りのプロセスを処理します。

### Nuke

このアプリは `menu.py` 自動開始スクリプトを Nuke に登録し、Nuke はそれを起動プロセスの一部として呼び出します。

Nuke が起動すると、次のプロセスが実行されます。

1. Nuke が `menu.py` 起動スクリプトの実行を開始します
1. {% include product %} Toolkit コンテキスト API を使用して、{% include product %} から渡されたエンティティ ID が Toolkit コンテキストに変換されます。
1. `tank.system.start_engine()` を介して適切なエンジンを起動し、コンテキストに渡します。エンジンが残りのプロセスを処理します。

### Photoshop

このアプリは、Adobe Extension Manager を使用して Tank プラグインのインストールやインストール確認を行います。

Photoshop が起動すると、次のプロセスが実行されます。

1. Photoshop が Tank プラグインの実行を開始します
1. {% include product %} Toolkit コンテキスト API を使用して、{% include product %} から渡されたエンティティ ID が Toolkit コンテキストに変換されます。
1. `tank.system.start_engine()` を介して適切なエンジンを起動し、コンテキストに渡します。エンジンが残りのプロセスを処理します。

#### 追加の設定

このアプリを使用して Photoshop を起動する場合、 _追加_ のセクションで 4 つの設定値を指定する必要があります。次に、システムとインストールの場所に合わせた調整が必要な設定および適切な既定値を示します。

```yaml
mac_python_path: "/usr/bin/python"
windows_python_path: "C:\\Python27\\python.exe"
mac_extension_manager_path: "/Applications/Adobe Extension Manager CS6/Adobe Extension Manager CS6.app"
windows_extension_manager_path: "C:\\Program Files (x86)\\Adobe\\Adobe Extension Manager CS6\\XManCommand.exe"
```
