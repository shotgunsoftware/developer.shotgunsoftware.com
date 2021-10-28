---
layout: default
title: ascii codec can’t decode byte 0x97 in position 10
pagename: ascii-error-message
lang: ja
---

# ASCII codec can’t decode byte 0x97 in position 10: ordinal not in range

## 関連するエラーメッセージ:

設定のクローン作成している場合
- TankError: Could not create file system structure: `ascii`! codec can’t decode byte 0x97 in position 10: ordinal not in range(128)

別のプロジェクトを使用してプロジェクト設定をセットアップしている場合
- " ‘ascii’ codec can’t decode byte 0x97 in position 10: ordinal not in range(128)"

## 修正方法:

通常、「config」フォルダ内に Unicode または特殊文字が存在する場合は、このエラーが表示されます。ユーザが特殊文字を見つけることができるかどうかを確認するために、コメントを追加しました。

## このエラーの原因の例:

この場合、エラーは、Windows がファイル名の末尾に接尾語 `–` を追加したことに起因していました。これらのファイルをすべて削除すると、機能するようになりました。

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/ascii-problem/7688)を参照してください。

