---
layout: default
title: Failed to change work area - Error during execution of MEL script
pagename: error-during-execution-mel-script
lang: ja
---

# Failed to change work area - Error during execution of MEL script

## 使用例

ネットワークにアクセスできないフリーランス専用の新しいパイプライン設定を作成するときに、新しいルート名を作成して、別のパスを指すように指定しました。プロダクション パイプライン設定には、ファイル サーバを指すルート パスが含まれています。

ところが、Maya で `tk-multi-workfiles` を使用して新しいファイルを作成すると、次のエラーが発生します。

```
Failed to change work area - Error during execution of MEL script: file: C:/Program files/Autodesk/Maya2019/scripts/others/setProject.mel line 332: New project location C:\VetorZero\work\Shotgun-workflow_completo\sequences\Seq_001\SH_010\ANIM\maya is not a valid directory, project not created.
Calling Procedure: setProject, in file “C:\Program Files\Shotgun\c” set project(“C:\Vetorzero\work\SHOTGUN-workflow_completo\sequences\Seq_001\SH_010\ANIM\maya”)
```

フォルダは作成されましたが、「maya」フォルダは作成されませんでした。

## 修正方法

フォルダ「maya」が誤って削除されていないか確認します。このエラーは、エラーが発生した場合に表示されています。

## 関連リンク

[コミュニティの完全なスレッド](https://community.shotgridsoftware.com/t/new-file-maya-action-error/8225)を参照してください。