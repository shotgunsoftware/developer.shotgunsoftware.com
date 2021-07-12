---
layout: default
title: API を使用して Toolkit の設定をプログラムによって更新するにはどうすればいいですか?
pagename: update-config-with-api
lang: ja
---

# API を使用して Toolkit の設定をプログラムによって更新するにはどうすればいいですか?

## アプリ、エンジン、およびフレームワークを更新する

エンジン、アプリ、およびフレームワークのすべてをプログラムによって最新バージョンに更新する場合は、次のコードを使用できます。

```python
import sys
sys.path.append("<path_to_your_config>/install/core/python")
import sgtk

# substitute your Project id here or alternatively use sgtk_from_path()
tk = sgtk.sgtk_from_entity('Project', 161)
c=tk.get_command("updates")

# setup authentication
if hasattr(sgtk, "set_authenticated_user"):
     from tank_vendor.shotgun_authentication import ShotgunAuthenticator
     user = ShotgunAuthenticator(sgtk.util.CoreDefaultsManager()).get_default_user()
     sgtk.set_authenticated_user(user)

# finally, execute the command
c.execute({})
```

{% include warning title="注意" content="これにより、追加の操作や確認を行うことなく、このパイプライン設定のエンジン、アプリ、およびフレームがすべて最新バージョンに更新されます。作業を進める前にこの操作を把握してください。"%}

## コアを更新する

スクリプトからプロジェクトのコア バージョンを非インタラクティブに更新する場合は、次のコードを使用できます。

```python
import sys
sys.path.append("<path_to_your_config>/install/core/python")
import sgtk

# substitute your Project id here or alternatively use sgtk_from_path()
tk = sgtk.sgtk_from_entity('Project', 161)
c=tk.get_command("core")

# setup authentication
if hasattr(sgtk, "set_authenticated_user"):
    from tank_vendor.shotgun_authentication import ShotgunAuthenticator
    user = ShotgunAuthenticator(sgtk.util.CoreDefaultsManager()).get_default_user()
    sgtk.set_authenticated_user(user)

# finally, execute the command
c.execute({})
```

{% include warning title="注意" content="これにより、追加の操作や確認を行うことなく、Toolkit コアが最新バージョンに更新されます。このコードを実行しているコアが共有コアの場合は、このコア バージョンを共有するすべてのプロジェクトで使用されているコア バージョンが更新されます。作業を進める前にこの操作を把握してください。" %}

関連トピック

- [カスタム スクリプトによる認証とログイン資格情報](https://support.shotgunsoftware.com/hc/ja/articles/219040338)
