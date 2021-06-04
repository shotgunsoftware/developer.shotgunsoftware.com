---
layout: default
title: ShotGrid Desktop は Ubuntu のような Debian システムで動作しますか?
pagename: sg-desktop-run-on-ubuntu
lang: ja
---

# {% include product %} Desktop は Ubuntu のような Debian システムで動作しますか?

現在、{% include product %} Desktop では Debian ベースのディストリビューションをサポートしていません。cpio を使用して RPM から {% include product %} Desktop を抽出し、そのライブラリの依存関係を維持して、うまく動作させようとしたクライアントが過去にいましたが、良い結果は得られませんでした。参考として、[当社の開発グループで次のスレッドを確認することができます](https://groups.google.com/a/shotgunsoftware.com/d/msg/shotgun-dev/nNBg4CKNBLc/naiGlJowBAAJ)。

Python 自体が多くのシステム レベル ライブラリの最上部に配置されているため、ライブラリの依存関係の明示的なリストはありません。

現在、Debian をサポートする正式な予定はありません。Ubuntu 向けの開発を行うのには問題があります。変更ごとに追加オペレーティング システムの QA とサポートを更新する必要があり、これが大きな負担になります。

{% include product %} Desktop を使用せずに Toolkit を手動で実行して有効にする場合([このドキュメントの説明を参照](https://support.shotgunsoftware.com/hc/ja-jp/articles/219033208#Step%208.%20Run%20the%20activation%20script)) - そのドキュメントのページから `activate_shotgun_pipeline_toolkit.py` スクリプトをダウンロードしてください。ガイドの手順 8 にある「クリックして {% include product %} Pipeline Toolkit アクティベーション パッケージをダウンロード」という見出しをクリックします。


