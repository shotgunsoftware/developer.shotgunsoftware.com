---
layout: default
title: Windows で ShotGrid Desktop をサイレント インストールするにはどうすればいいですか?
pagename: install-desktop-silent
lang: ja
---

# Windows で {% include product %} Desktop をサイレント インストールするにはどうすればいいですか?

{% include product %} Desktop インストーラをサイレントで実行するには、次の方法で {% include product %} Desktop インストーラを起動します。

`ShotgunInstaller_Current.exe /S`

インストール フォルダも指定する場合は、引数 `/D` を使用して起動します。

`ShotgunInstaller_Current.exe /S /D=X:\path\to\install\folder.`

{% include info title="注" content="引数 `/D` は最後の引数として指定する必要があります。パスの中にスペースがある場合でも、`\"` は使用しないでください。" %}