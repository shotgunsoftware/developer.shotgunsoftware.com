---
layout: default
title: The path `<PATH>` is already associated with {% include product %} entity `<ENTITY>`
pagename: path-associated-error-message
lang: ja
---

# Database concurrency problems: The path `<PATH>` is already associated with {% include product %} entity `<ENTITY>`

## 関連するエラーメッセージ:

- Database concurrency problems: The path `<PATH>` is already associated with {% include product %} entity `<ENTITY>`.
- Could not resolve row id for path!

## 例:

このエラーは、Toolkit ユーザがフォルダの作成を試みたときに発生します。次に、完全なエラーを示します。

```
ERROR: Database concurrency problems: The path
'Z:\projects\SpaceRocks\shots\ABC_0059' is already associated with
Shotgun entity {'type': 'Shot', 'id': 1809, 'name': 'ABC_0059'}. Please re-run
folder creation to try again.
```
## エラーの原因

FilesystemLocation エンティティが既に含まれているフォルダに対してこのエンティティを作成しようとしているときに発生します。

## 修正方法

不正な FilesystemLocation エンティティをクリアします。エラーのある FilesystemLocation エンティティのセットに絞り込むことができた場合は、これらを削除するだけで済みます。通常はプロジェクトのすべてのパスが損なわれているため、すべてのパスを削除する必要があります。

- FilesystemLocation エンティティをクリアする方法: 理想的なのは、`tank unregister_folders` を実行できることです。これらすべてをクリアするには、tank `unregister_folders --all` を実行します。(`tank unregister_folders` のすべてのオプションでは、引数を指定しないで実行するだけで、使用上の注意事項が出力されます。)
- ただし、データベースは既に不安定な状態になっているため、この方法が機能しないか、部分的にしか機能しない場合があります。コマンドを実行したら、{% include product %} の FilesystemLocations に戻って、削除予定の内容が実際に削除されていることを確認します。削除されていない場合は、不適切なエンティティを選択し、手動でごみ箱に移動します。

この時点で、{% include product %} の FilesystemLocations はクリーンな状態ですが、アーティストのローカル キャッシュには変更が反映されていない可能性があります。最後の手順では、各ユーザのマシンのローカル キャッシュを実際に同期します。この操作を行うには、tank `synchronize_folders --full` を実行する必要があります。

これらの手順をすべて実行すると、パスのキャッシュは適切な状態になり、エラーは表示されなくなります。

## 関連リンク

- [問題のあるコード](https://github.com/shotgunsoftware/tk-core/blob/01bb9547cec19cc2a959858b09a8b349a388b56f/python/tank/path_cache.py#L491-L498)
- [パス キャッシュとは何ですか? ファイルシステムの場所とは何ですか?](https://developer.shotgridsoftware.com/ja/cbbf99a4/)

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/how-to-troubleshoot-folder-creation-errors/3578)を参照してください。

