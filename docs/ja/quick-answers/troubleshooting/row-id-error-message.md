---
layout: default
title: Could not resolve row id for path!
pagename: row-id-error-message
lang: ja
---

# Could not resolve row id for path!

## 関連するエラーメッセージ:

- Could not resolve row id for path!
- Database concurrency problems: The path `<PATH>` is already associated with {% include product %} entity `<ENTITY>`.

## サンプル

Toolkit ユーザがフォルダを生成すると、「Could not resolve row id for path!」というエラーが表示されます。

FileSystemLocation エンティティが作成されますが、場合によっては重複することがあり、その結果、多数の問題が発生する可能性があります。

完全なエラーは次のようになります。

```
Creating folders, stand by...

ERROR: Could not resolve row id for path! Please contact support! trying to
resolve path '\\server\nas_production\CLICK\00_CG\scenes\Animation\01\001'.
Source data set: [{'path_cache_row_id': 8711, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001',
'metadata': {'type': '{% include product %}_entity', 'name': 'sg_scenenum', 'filters':
[{'path': 'sg_sequence', 'values': ['$sequence'], 'relation': 'is'}],
'entity_type': 'Shot'}, 'primary': True, 'entity': {'type': 'Shot', 'id':
1571, 'name': '001_01_001'}}, {'path_cache_row_id': 8712, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001\\Fx',
'metadata': {'type': '{% include product %}_step', 'name': 'short_name'}, 'primary': True,
'entity': {'type': 'Step', 'id': 6, 'name': 'FX'}}, {'path_cache_row_id':
8713, 'path':
'\\\\server\\NAS_Production\\CLICK\\00_CG\\scenes\\Animation\\01\\001\\Comp',
```
_注: エラーはこれより大幅に長くなることがあります。_

## エラーの原因

このエラーは、{% include product %} ([サイト基本設定] (Site Preferences) -> [ファイル管理] (File Management))とパイプライン設定の c`onfig/core/roots.yml` で指定されているストレージ ルート間に不一致があること示しています。

Windows を実行しているスタジオでは、大文字と小文字の不一致が原因でこのエラーが発生することがあります。これらのスタジオでパスの大文字と小文字は区別されませんが、オートデスクの設定では大文字と小文字が区別されます。`E:\Projects` と `E:\projects` のような単純な違いによって、このエラーが発生する可能性があります。

## シーンの背後で実行される動作

このコードは、{% include product %} によって作成されたパスに FilesystemLocation エンティティを作成し、{% include product %} のストレージ ルートを使用してパスのルートを決定します。次に、ローカル キャッシュ内に同じエントリを作成し、データベース内の配置場所を決定する必要があります。ローカル キャッシュの場合は、`roots.yml` を使用してパスのルートを決定します。大文字と小文字が一致しないため、生成されたパスは {% include product %} に入力されたパスと一致しません。この時点で、エラーが発生します。

エラーが整然と発生しない場合は、特に不適切な状態になります。フォルダが作成され、FilesystemLocation エントリが作成されても、ローカル パス キャッシュでこれらが同期されることはなく、ストレージ ルートの不一致が原因で同期することもできなくなります。

## 修正方法

まず、[サイト基本設定] (Site Preferences)のストレージ ルート パスが `config/core/roots.yml` のパスと必ず一致するようにします。不一致を修正すると、以降のフォルダ作成呼び出しでエラーが解消されます。

次に、不正な FilesystemLocation エンティティをクリアします。エラーのある FilesystemLocation エンティティのセットに絞り込むことができた場合は、これらを削除するだけで済みます。通常はプロジェクトのすべてのパスが損なわれているため、すべてのパスを削除する必要があります。

- FilesystemLocation エンティティをクリアする方法: 理想的なのは、`tank unregister_folders` を実行できることです。これらすべてをクリアするには、tank `unregister_folders --all` を実行します。(`tank unregister_folders` のすべてのオプションでは、引数を指定しないで実行するだけで、使用上の注意事項が出力されます。)
- ただし、データベースは既に不安定な状態になっているため、この方法が機能しないか、部分的にしか機能しない場合があります。コマンドを実行したら、{% include product %} の FilesystemLocations に戻って、削除予定の内容が実際に削除されていることを確認します。削除されていない場合は、不適切なエンティティを選択し、手動でごみ箱に移動します。

この時点で、{% include product %} の FilesystemLocations はクリーンな状態ですが、アーティストのローカル キャッシュには変更が反映されていない可能性があります。最後の手順では、各ユーザのマシンのローカル キャッシュを実際に同期します。この操作を行うには、tank `synchronize_folders --full` を実行する必要があります。

これらの手順をすべて実行すると、パスのキャッシュは適切な状態になり、エラーは表示されなくなります。

## 関連リンク

- [問題のあるコード](https://github.com/shotgunsoftware/tk-core/blob/01bb9547cec19cc2a959858b09a8b349a388b56f/python/tank/path_cache.py#L491-L498)
- [パス キャッシュとは何ですか? ファイルシステムの場所とは何ですか?](https://developer.shotgridsoftware.com/ja/cbbf99a4/)

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/how-to-troubleshoot-folder-creation-errors/3578)を参照してください。

