---
layout: default
title: Windows パスが長すぎるためのエラー
pagename: paths-long-error-message
lang: ja
---

# Windows パスが長すぎるためのエラー(256 文字を超過)

## 厳然たる事実

Windows のパス名に関する既定の制限である 255/260 文字は、非常に低い値です。この制限に関する Microsoft の情報については[こちら](https://docs.microsoft.com/ja-jp/windows/win32/fileio/naming-a-file?redirectedfrom=MSDN#maximum-path-length-limitation)を、詳細な技術情報については[こちら](https://docs.microsoft.com/ja-jp/windows/win32/fileio/maximum-file-path-limitation)を参照してください。

## エラー

このエラー自体はさまざまな方法で現れますが、通常は SG Desktop が設定を初めてロードして、バンドル キャッシュに項目をダウンロードしている間に発生します。Windows 10 の最新バージョンでエラーはわずかに改善されたように見えますが、多少意味不明なところがあります。次に、表示されるエラーの例をいくつか示します。

```
[ WARNING] Attempt 1: Attachment download of id 3265791 from https://xxxxx.shotgunstudio.com failed: [Error 206] The filename or extension is too long: 'C:\\Users\\xxxxx\\AppData\\Roaming\\Shotgun\\bundle_cache\\tmp\\0933a8b9a91440a2baf3dd7df44b40ce\\bundle_cache\\git\\tk-framework-imageutils.git\\v0.0.2\\python\\vendors\\osx\\lib\\python2.7\\site-packages\\pip\\_vendor\\requests\\packages\\urllib3\\packages\\ssl_match_hostname'
[ WARNING] File 'c:\users\xxxxx\appdata\local\temp\ab35bd0eb2b14c3b9458c67bceeed935_tank.zip' could not be deleted, skipping: [Error 32] The process cannot access the file because it is being used by another process: 'c:\\users\\xxxxx\\appdata\\local\\temp\\ab35bd0eb2b14c3b9458c67bceeed935_tank.zip'
```

```
ERROR sgtk.core.descriptor.io_descriptor.downloadable] Failed to download into path C:\Users\xxxxx\AppData\Roaming\Shotgun\bundle_cache\tmp\123456789012a34b567c890d1e23456: Failed to download sgtk:descriptor:shotgun?entity_type=PipelineConfiguration&field=uploaded_config&id=38&version=123456 from https://xxxxx.shotgunstudio.com. Error: Failed to download from 'https://xxxxx.shotgunstudio.com' after 5 retries. See error log for details.. Attempting to remove it.
```

```
WARNING sgtk.core.util.shotgun.download Attempt 4: Attachment download of id 1182 from https://xxxxx.shotgunstudio.com failed: [Errno 2] No such file or directory: 'C:\\Users\\xxxxx\\AppData\\Roaming\\Shotgun\\bundle_cache\\tmp\\dd2cc0804122403a87ac71efccd383ea\\bundle_cache\\app_store\\tk-framework-desktopserver\\v1.3.1\\resources\\python\\build\\pip\\_vendor\\requests\\packages\\urllib3\\packages\\ssl_match_hostname\\_implementation.py'
WARNING sgtk.core.util.filesystem File 'c:\users\xxxxx\appdata\local\temp\08f94bfe9b6d43e7a7beba30c192a43c_tank.zip' could not be deleted, skipping: [Error 32] The process cannot access the file because it is being used by another process: 'c:\\users\\xxxxx\\appdata\\local\\temp\\08f94bfe9b6d43e7a7beba30c192a43c_tank.zip'
ERROR sgtk.core.descriptor.io_descriptor.downloadable] Failed to download into path C:\Users\xxxxx\AppData\Roaming\Shotgun\bundle_cache\tmp\dd2cc0804122403a87ac71efccd383ea: Failed to download sgtk:descriptor:shotgun?entity_type=PipelineConfiguration&field=sg_uploaded_config&id=1&version=1182 from https://xxxxx.shotgunstudio.com. Error: Failed to download from 'https://xxxxx.shotgunstudio.com' after 5 retries. See error log for details.. Attempting to remove it.
ERROR sgtk.core.bootstrap.cached_configuration Failed to install configuration sgtk:descriptor:shotgun?entity_type=PipelineConfiguration&field=sg_uploaded_config&id=1&version=1182. Error: Failed to download into path C:\Users\xxxxx\AppData\Roaming\Shotgun\bundle_cache\tmp\dd2cc0804122403a87ac71efccd383ea: Failed to download sgtk:descriptor:shotgun?entity_type=PipelineConfiguration&field=sg_uploaded_config&id=1&version=1182 from https://xxxxx.shotgunstudio.com. Error: Failed to download from 'https://xxxxx.shotgunstudio.com' after 5 retries. See error log for details.. Cannot continue.
```

## このエラーが発生する理由

Windows では、{% include product %} Desktop はデータを `%APPDATA%` フォルダ(通常は `C:\Users\jane\AppData\Roaming\Shotgun`)に保存します。標準の default2 Toolkit 設定を使用しているときは、ユーザ名が極端に長い場合を除いて、ほとんどの場合問題ありません。ただし、独自のアプリ、エンジン、またはフレームワークを作成する場合は、この問題が発生するリスクが高くなります。特に、(オートデスクと同様に)コードとの依存関係をバンドルしていて、バンドル内のディレクトリ ツリーの階層が深い場合はリスクが高くなります。 

## 問題の回避策

この問題を解決するには、通常、環境変数 `$SHOTGUN_HOME` を `C:\SG` のような非常に短い値に設定します。これにより、SG Desktop は `C:\Users\jane\AppData\Roaming\Shotgun` でなく、`C:\SG` にデータを保存するようになるため、文字数が節約されます。制限内に収まるよう維持するには、通常はこの方法で十分です。環境変数については、[こちら](https://developer.shotgridsoftware.com/tk-core/initializing.html?#environment-variables)を参照してください。

### 将来の可能性

[こちら](https://docs.microsoft.com/ja-jp/windows/win32/fileio/maximum-file-path-limitation#enable-long-paths-in-windows-10-version-1607-and-later)に記載されているように、レジストリを更新することにより、新しいバージョンの Windows 10 でこの問題を軽減できる*可能性があります*。ただし、`longPathAware` の設定を利用することを指定するには、SG Desktop のマニフェスト ファイルを更新する必要もあります。私は Mac ユーザであるため、この内容が役に立つかどうかは分かりません。

[コミュニティで完全なスレッドを参照](https://community.shotgridsoftware.com/t/errors-due-to-windows-paths-too-long-256-characters/10101)してください。

