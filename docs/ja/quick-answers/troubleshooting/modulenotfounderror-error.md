---
layout: default
title: ModuleNotFoundError
pagename: modulenotfounderror-error
lang: ja
---

# ModuleNotFoundError

## 使用例

分散設定の場合に、エンジンの外部で `tk.templates` コマンドにアクセスするために `tk-shell` ブートストラップすると、このエラーが表示されます。[このドキュメント](https://developer.shotgridsoftware.com/ja/3d8cc69a/#part-2-logging)(パート 4)に従って、インストール フォルダから sgtk v0.19.18 を読み込むと、次のエラーが発生します。

```
Traceback (most recent call last):
  File ".../_wip/sgtk_bootstrap.py", line 9, in <module>
    import sgtk
  File "L:/_tech/sgtk_sandbox/install/core/python\sgtk\__init__.py", line 16, in <module>
    import tank
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\__init__.py", line 58, in <module>
    from . import authentication
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\__init__.py", line 33, in <module>
    from .shotgun_authenticator import ShotgunAuthenticator
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\shotgun_authenticator.py", line 13, in <module>
    from .sso_saml2 import (
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\sso_saml2\__init__.py", line 15, in <module>
    from .core.errors import (  # noqa
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\sso_saml2\core\__init__.py", line 15, in <module>
    from .sso_saml2_core import (  # noqa
  File "L:/_tech/sgtk_sandbox/install/core/python\tank\authentication\sso_saml2\core\sso_saml2_core.py", line 19, in <module>
    from Cookie import SimpleCookie
ModuleNotFoundError: No module named 'Cookie'
```

## 修正方法

この問題は、Python 3 の使用が原因である可能性があります。Python 2.7 には Cookie モジュールがありますが、3.x にはありません。したがって、この問題は python 2.7 を使用することで修正できます。

## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/bootstrap-sgtk-modulenotfounderror/11708)を参照してください。