---
layout: default
title: ModuleNotFoundError
pagename: modulenotfounderror-error
lang: en
---

# ModuleNotFoundError

## Use Case

With a distributed confguration, when bootrstrapping `tk-shell` to access the `tk.templates` command outside of an engine, this error is presented. When following [this doc](https://developer.shotgridsoftware.com/3d8cc69a/#part-2-logging) (part 4), and importing sgtk v0.19.18 from an install folder this is the error:

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

## How to fix

This issue may be due to using Python 3. Python 2.7 does have a Cookie module, but 3.x does not. So this can be fixed by using python 2.7.

## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/bootstrap-sgtk-modulenotfounderror/11708)