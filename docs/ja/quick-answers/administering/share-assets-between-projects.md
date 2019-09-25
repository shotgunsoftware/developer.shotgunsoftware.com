---
layout: default
title: プロジェクト間でアセットを共有するにはどうすればいいですか?
pagename: share-assets-between-projects
lang: ja
---

# プロジェクト間でアセットを共有するにはどうすればいいですか?

他のプロジェクトのショットにロードできるアセットを含むアセット ライブラリとして使用されるプロジェクトを指定するのは珍しくありません。

これを実現するには、このアセット ライブラリ プロジェクトのアセットをリストする[Loader アプリ](https://support.shotgunsoftware.com/hc/ja/articles/219033078)にタブを追加します。このためには、作業しているエンジンと環境のローダー設定でこのタブを定義する必要があります。このタブは複数の場所で更新する必要があります。

たとえば、[ショットのステップ環境の Maya エンジン](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-multi-loader2.yml#L122)にこのタブを追加するには、次のスニペットを追加します。

    caption: Asset Library
    hierarchy: [project, sg_asset_type, code]
    entity_type: Asset
    filters:
    - [project, is, {'type': 'Project', 'id': 207}]

`207` をライブラリ プロジェクトの ID と置き換えます。

Maya のショットのステップ環境で作業している場合、このプロジェクトで使用可能なすべてのパブリッシュを表示する新しいタブが追加されます。他のエンジンのローダーにこのタブを追加する場合(Nuke や 3dsmax)、各エンジンで `tk-multi-loader2` 設定を変更する必要があります。他の環境でこの設定を有効にする場合は、アセットのステップ環境と設定する他の環境で同じ手順を実行する必要があります。手間が少しかかりますが、詳細に制御できるようになります。

これらの設定を使用すると、Loader アプリで一般的なプロジェクトのパブリッシュをリストするタブを表示できます。