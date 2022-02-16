---
layout: default
title: Maya で Toolkit アプリを起動するシェルフ ボタンを追加するにはどうすればいいですか?
pagename: maya-shelf-app-launcher
lang: ja
---

# Maya で Toolkit アプリを起動するシェルフ ボタンを追加するにはどうすればいいですか?

Maya で Toolkit アプリを起動するシェルフ ボタンを Maya に追加するのは非常に簡単です。次に、[Loader アプリ](https://developer.shotgridsoftware.com/ja/a4c0a4f1/)を起動するカスタム シェルフ ボタンの追加方法の例を示します。

{% include info title="注" content="これは、Toolkit が現在の Maya セッションで有効であることが前提です。このコード例では Toolkit をブートストラップしません。"%}

Maya でスクリプト エディタを開き、次の Python コードを貼り付けます。 

```python
import maya.cmds as cmds

# Define the name of the app command we want to run.
# If your not sure on the actual name you can print the current_engine.commands to get a full list, see below.
tk_app = "Publish..."

try:
    import sgtk

    # get the current engine (e.g. tk-maya)
    current_engine = sgtk.platform.current_engine()
    if not current_engine:
        cmds.error("ShotGrid integration is not available!")

    # find the current instance of the app.
    # You can print current_engine.commands to list all available commands.
    command = current_engine.commands.get(tk_app)
    if not app:
        cmds.error("The Toolkit app '%s' is not available!" % tk_app)

    # now we have the command we need to call the registered callback
    command['callback']()

except Exception, e:
    msg = "Unable to launch Toolkit app '%s': %s" % (tk_app, e)
    cmds.confirmDialog(title="Toolkit Error", icon="critical", message=msg)
    cmds.error(msg)
```

このコードを選択して、カスタム シェルフにドラッグします。[カスタム シェルフ ボタンの使用方法に関する詳細については、Maya ドキュメント](https://knowledge.autodesk.com/ja/support/maya/learn-explore/caas/CloudHelp/cloudhelp/2016/JPN/Maya/files/GUID-C693E884-F81A-4858-B5D6-3856EB8F394E-htm.html)を参照してください。

上部の `tk_app` と `call_func` の各変数を修正して、Maya で有効な Toolkit アプリを起動するには、このコード サンプルを使用できる必要があります。
