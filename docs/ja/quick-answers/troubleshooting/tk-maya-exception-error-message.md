---
layout: default
title: Error {% include product %} tk-maya An exception was raised from Toolkit
pagename: tk-maya-exception-error-message
lang: ja
---

# Error: {% include product %} tk-maya: An exception was raised from Toolkit

## 使用例

実行がトリガされたときにカスタム引数を受け取るように Toolkit アプリを設定することができます。

たとえば、アプリを実行するときに、状態に応じて異なる方法でアプリが起動するように設定するある種の状態フラグを指定することができます。

次に、このフラグの使用例をいくつか示します。

- `tk-shotgun-folders` アプリ(Shotgun Web アプリで選択したエンティティに基づいてフォルダを作成する)には、ユーザが Shotgun Web アプリで選択して、それに対してアクションを実行した Shotgun エンティティとエンティティ タイプが渡されます(https://github.com/shotgunsoftware/tk-shotgun-folders/blob/v0.1.7/app.py#L86)。
- `tk-multi-launchapp` (Shotgun 統合を使用してソフトウェアを起動する)には、`file_to_open` 引数を渡すことができます。この引数は、ソフトウェアの起動後にファイルを開く場合に使用します(https://github.com/shotgunsoftware/tk-multi-launchapp/blob/v0.11.2/python/tk_multi_launchapp/base_launcher.py#L157)。通常、{% include product %} Desktop を使用してソフトウェアを起動した場合は、`file_to_open` 引数が提供されませんが、一元管理設定(`tank maya_2019 /path/to/maya/file.mb`)を使用している場合は、tank コマンドをを使用してアプリを呼び出すことができます。また、`tk-shotgun-launchpublish` アプリによって `tk-multi-launchapp` が起動し、パブリッシュされたファイルが `file_to_open` 引数として提供されます。https://github.com/shotgunsoftware/tk-shotgun-launchpublish/blob/v0.3.2/hooks/shotgun_launch_publish.py#L126-L133

## 引数を受け入れるようにアプリをプログラミングする

[カスタム アプリを作成](https://developer.shotgridsoftware.com/ja/2e5ed7bb/)する場合に必要なことは、必要な引数を受け入れるためにエンジンに登録されるコールバック メソッドを設定することだけです。
次に、2 つの必須の引数のほかに追加の引数を受け入れて、これらを出力するように設定された単純なアプリを示します。

```python
from sgtk.platform import Application


class AnimalApp(Application):

    def init_app(self):
        self.engine.register_command("print_animal", self.run_method)

    def run_method(self, animal, age, *args):
        print ("",animal)
        print ("age",age)
        print ("args", args)
```

### Tank コマンドから実行する

ここで、シェルで次の tank コマンドを実行するとします。

```
 ./tank print_animal cat 7 Tortoiseshell large
```

すると、次のように出力されます。

```
...

----------------------------------------------------------------------
Command: Print animal
----------------------------------------------------------------------

libpng warning: iCCP: known incorrect sRGB profile
('animal', 'cat')
('age', '7')
('args', ('Tortoiseshell', 'large'))
```
### スクリプトから実行する

`tk-shell` エンジンのスクリプトからアプリを呼び出す場合は、次の操作を実行できます。

```python
# This assumes you have a reference to the `tk-shell` engine.
engine.execute_command("print_animal", ["dog", "3", "needs a bath"])
>>
# ('animal', 'dog')
# ('age', '3')
# ('args', ('needs a bath',))
```

Maya では、次のような操作を実行します。

```python
import sgtk

# get the engine we are currently running in.
engine = sgtk.platform.current_engine()
# Run the app.
engine.commands['print_animal']['callback']("unicorn",4,"it's soooo fluffy!!!!")

>>
# ('animal', 'unicorn')
# ('age', 4)
# ('args', ("it's soooo fluffy!!!!",))
```

## エラー メッセージ

Maya のメニューからアプリを起動しようとすると、次のようなエラーが表示されます。

```
// Error: Shotgun tk-maya: An exception was raised from Toolkit
Traceback (most recent call last):
  File "/Users/philips1/Library/Caches/Shotgun/bundle_cache/app_store/tk-maya/v0.10.1/python/tk_maya/menu_generation.py", line 234, in _execute_within_exception_trap
    self.callback()
  File "/Users/philips1/Library/Caches/Shotgun/mysite/p89c1.basic.maya/cfg/install/core/python/tank/platform/engine.py", line 1082, in callback_wrapper
    return callback(*args, **kwargs)
TypeError: run_method() takes at least 3 arguments (1 given) //
```

これは、アプリが引数を必要とするように設定されているのに、メニュー ボタンが引数を提供するよう指定されていないためです。

## 修正方法

次のようなキーワード引数を使用するようにアプリの `run_method` を記述することをお勧めします。

```python
    def run_method(self, animal=None, age=None, *args):
        print ("",animal)
        print ("age",age)
        print ("args", args)
```
こうすると、引数が提供されない場合の動作を処理し、フォールバック動作を実装することができます。

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/custom-app-args/8893)を参照してください。

