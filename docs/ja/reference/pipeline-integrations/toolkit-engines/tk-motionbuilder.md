---
layout: default
title: Motion Builder
pagename: tk-motionbuilder
lang: ja
---

# Motion Builder

![エンジン](../images/engines/sg_mobu_1.png)

{% include product %} Engine for Motion Builder は、{% include product %} Toolkit アプリと MotionBuilder を統合するための標準プラットフォームを提供します。軽量で操作性に優れており、メイン メニューに {% include product %} のメニューを追加します。

![エンジン](../images/engines/mobu.png)

## サポート対象のアプリケーション バージョン

この項目はテスト済みです。次のアプリケーション バージョンで動作することが分かっています。

{% include tk-motionbuilder %}

最新のリリースでの動作は十分可能ですが、正式なテストはまだ完了していません。

## インストールと更新

### {% include product %} Pipeline Toolkit にこのエンジンを追加する

Project XYZ にこのエンジンを追加するには、asset という名前の環境で次のコマンドを実行します。

```
> tank Project XYZ install_engine asset tk-motionbuilder
```

### 最新バージョンに更新する

この項目が既にプロジェクトにインストールされている場合に最新バージョンを取得するには、`update` コマンドを実行します。特定のプロジェクトに含まれている tank コマンドに移動し、そこでこのコマンドを実行します。

```
> cd /my_tank_configs/project_xyz
> ./tank updates
```

または Studio の tank コマンドを実行し、プロジェクトの名前を指定して、更新チェックを実行するプロジェクトを指定します。

```
> tank Project XYZ updates
```

## コラボレーションと発展

{% include product %} Pipeline Toolkit にアクセスできる場合は、すべてのアプリ、エンジン、およびフレームワークのソース コードにも Github からアクセスできます。これらは Github を使用して格納および管理しています。これらの項目は自由に発展させてください。さらなる独立した開発用の基盤として使用したり、変更を加えたり(その際はプル リクエストを送信してください)、 いろいろと研究してビルドの方法やツールキットの動作を確認してください。このコード リポジトリには、https://github.com/shotgunsoftware/tk-motionbuilder からアクセスできます。



