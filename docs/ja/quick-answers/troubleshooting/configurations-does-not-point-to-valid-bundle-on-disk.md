---
layout: default
title: Configurations does not point to a valid bundle on disk!
pagename: configurations-does-not-point-to-valid-bundle-on-disk
lang: ja
---

# Configurations does not point to a valid bundle on disk!

## 使用例

{% include product %} Desktop を初めてインストールするときに、プロジェクトを開くと、ファイル パスの後にこのエラーが表示されることがあります。

## 修正方法

プロジェクトのパイプライン設定エンティティが、Windows の設定のパス `...\{% include product %}\Configurations` を指しています。これが正しいパスでない可能性があるため、最初の手順として、このパスが存在することを確認するか、パスを修正してください。

また、このパスの場所にアクセスできない一元管理セットアップからアクセスしようとしている可能性もあります。この場合は、分散セットアップに切り替えると便利です。


## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/first-time-setting-up-shotgun-and-i-have-this-error/9384)を参照してください。