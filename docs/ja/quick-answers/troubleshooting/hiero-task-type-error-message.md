---
layout: default
title: ERROR 18:13:28.365:Hiero(34236) Error! タスク タイプ
pagename: hiero-task-type-error-message
lang: ja
---

# ERROR 18:13:28.365:Hiero(34236): Error! タスク タイプ

## 使用例:
`config_default2` に更新した後、nuke_studio が初期化されません。Nuke 12.0 Studio では、スクリプト エディタでエラーは発生しませんが、Nuke 11.1v3 では次のエラーが発生します。

```
ERROR 18:13:28.365:Hiero(34236): Error! Task type tk_hiero_export.sg_shot_processor.ShotgunShotProcessor Not recognised
```

ロールバック後にエラーが発生しなかった場合も、tk-nuke エンジンは初期化されず、{% include product %} で何もロードされません。

[コミュニティの投稿](https://community.shotgridsoftware.com/t/cant-get-shotgun-toolkit-to-work-with-nuke-studio-config-default2/4586)に完全なログが含まれているので、詳細を確認できます。

## エラーの原因
Nuke Studio の起動として処理されず、標準的な Nuke の起動として処理されている可能性があります。

Nuke Studio ソフトウェア エンティティとパスが定義されていて、引数が `-studio` に設定されています。引数は `--studio` に設定する必要があります。

## 修正方法
ソフトウェア エンティティの引数を `-studio` に設定する必要があります。

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/cant-get-shotgun-toolkit-to-work-with-nuke-studio-config-default2/4586)を参照してください。

