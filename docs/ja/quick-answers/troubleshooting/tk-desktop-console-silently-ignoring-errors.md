---
layout: default
title: Tk-desktop console silently ignoring errors
pagename: desktop-console-silently-ignoring-errors
lang: ja
---

# Tk-desktop console silently ignoring errors

## 使用例

Toolkit アプリを開発している場合は、[Toggle debug logging]チェックボックスがオンになっていても、初期化時にアプリで発生したすべての例外は tk-desktop によって自動的に無視されます。問題が発生していることを把握するには、プロジェクトの設定をロードした後に登録済みのコマンドが表示されないことを確認する必要があります。

## 修正方法

Desktop がプロジェクトのアプリをロードするときに、このログが SG Desktop のメイン UI プロセスに渡されることはありません。ただし、`tk-desktop.log` への出力は引き続き取得されます。このファイルを調べて、例外がないか確認します。


## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/8570)を参照してください。