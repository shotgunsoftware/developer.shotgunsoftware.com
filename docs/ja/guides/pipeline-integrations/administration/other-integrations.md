---
layout: default
title: その他の統合
pagename: other-integrations
lang: ja
---

# その他の統合

{% include product %} の API を使用することで、多数のサードパーティのパッケージと統合することができます。ただし、{% include product %} とすぐに統合できるものもあります。

## Cinesync

Cinesync では、複数の場所から再生を同時に同期できます。{% include product %} との統合により、バージョンのプレイリストを作成し、Cinesync で再生して、セッション時に作成したノートを {% include product %} に送信できます。

詳細については、[https://www.cinesync.com/manual/latest](https://www.cinesync.com/manual/latest)を参照してください。

## Deadline

{% include product %} と Deadline の統合により、すべてのサムネイル、フレームへのリンク、および他のメタデータとともにレンダリングしたバージョンが {% include product %} に自動的に送信されます。

詳細については、[https://docs.thinkboxsoftware.com/products/deadline/5.2/User%20Manual/manual/shotgunevent.html](https://docs.thinkboxsoftware.com/products/deadline/5.2/User%20Manual/manual/shotgunevent.html) を参照してください。

## Rush

Deadline との統合とほぼ同じように、{% include product %} と Rush の統合により、すべてのサムネイル、フレームへのリンク、および他のメタデータとともにレンダリングしたバージョンが {% include product %} に自動的に送信されます。

詳細については、[https://seriss.com/rush-current/index.html](https://seriss.com/rush-current/index.html) を参照してください。

## Subversion (SVN)

内部で使用される、軽量で柔軟性に優れた {% include product %} の統合では、{% include product %} でリビジョンをトラックし、チケットとリリースにリンクすることができます。また、外部ウェブ SVN リポジトリ ビューアと統合できるように Trac にもリンクできます。これは SVN にポストコミット フックを追加することで実行できます。このフックは、コミットからいくつかの ENV 変数を取得し、さまざまなフィールドに設定して {% include product %} でリビジョン エンティティを作成する {% include product %} API スクリプトです。スタジオのニーズに合わせて修正し、API を使用しているだけなので、ローカルまたはホストされたインストールで使用することができます。詳細については、[https://subversion.apache.org/docs](https://subversion.apache.org/docs/)を参照してください。
