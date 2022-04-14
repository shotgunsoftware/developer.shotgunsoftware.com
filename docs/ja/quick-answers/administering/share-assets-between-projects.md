---
layout: default
title: プロジェクト間でアセットを共有するにはどうすればいいですか?
pagename: share-assets-between-projects
lang: ja
---

# プロジェクト間でアセットを共有するにはどうすればいいですか?

一般的に、アセット ライブラリとして使用されるプロジェクトが存在し、これには他のプロジェクトのショットにロードできるアセットが含まれています。

アセット エンティティに[リンク プロジェクト] (Linked Projects)フィールドを導入することで、すべてのリンク プロジェクトを含む単一のタブを[ローダー アプリ](https://help.autodesk.com/view/SGSUB/JPN/?guid=SG_Supervisor_Artist_sa_integrations_sa_integrations_user_guide_html#the-loader)に追加できるようになりました。このためには、作業しているエンジンと環境のローダー設定でこのタブを定義する必要があります。このタブは複数の場所で更新する必要があります。

```yaml
- caption: Assets - Linked
    entity_type: Asset
    filters:
      - [linked_projects, is, "{context.project}"]
    hierarchy: [project.Project.name, sg_asset_type, code]
```

[tk-config-default2](https://github.com/shotgunsoftware/tk-config-default2) に含まれている [tk-multi-loader2.yml 設定ファイル](https://github.com/shotgunsoftware/tk-config-default2/blob/a5af14aefbafaec6cf0933db83343f600eb75870/env/includes/settings/tk-multi-loader2.yml#L343-L347) の Alias エンジン設定を参照することができます。ここでは、これは既定の動作です。

---

アセットに[リンク プロジェクト] (Linked Projects)フィールドを導入する前に、プロジェクト間の共有を実現する最初の方法は、特定のアセット ライブラリ プロジェクトのアセットをリストするタブを[ローダー アプリ](https://help.autodesk.com/view/SGSUB/JPN/?guid=SG_Supervisor_Artist_sa_integrations_sa_integrations_user_guide_html#the-loader)に追加することです。

たとえば、[ショットのステップ環境の Maya エンジン](https://github.com/shotgunsoftware/tk-config-default2/blob/e09236bf4b91a6dd79ca5b3ef1258d0eb0afd871/env/includes/settings/tk-multi-loader2.yml#L122)にこのタブを追加するには、次のスニペットを追加します。

```yaml
- caption: Asset Library
    hierarchy: [project, sg_asset_type, code]
    entity_type: Asset
    filters:
      - [project, is, {'type': 'Project', 'id': 207}]
```

`207` をライブラリ プロジェクトの ID と置き換えます。

Maya のショットのステップ環境で作業している場合、このプロジェクトで使用可能なすべてのパブリッシュを表示する新しいタブが追加されます。他のエンジンのローダーにこのタブを追加する場合(Nuke や 3dsmax)、各エンジンで `tk-multi-loader2` 設定を変更する必要があります。他の環境でこの設定を有効にする場合は、アセットのステップ環境と設定する他の環境で同じ手順を実行する必要があります。手間が少しかかりますが、詳細に制御できるようになります。

これらの設定を使用すると、ローダー アプリで特定されたプロジェクトのパブリッシュをリストするタブを表示できます。

---

{% include info title="注" content="この最初の方法は、ローダー内でプロジェクトごとに異なるタブを識別する方法を提供するため、ここに含まれています。"%}

Web ベースのプロジェクト間のアセット リンクの詳細については、[プロジェクト間のアセット リンクに関するドキュメント](https://help.autodesk.com/view/SGSUB/JPN/?guid=SG_Administrator_ar_site_configuration_ar_cross_project_asset_linking_html)を参照してください。
