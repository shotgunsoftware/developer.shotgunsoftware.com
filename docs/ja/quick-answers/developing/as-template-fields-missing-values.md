---
layout: default
title: as_template_fields() でコンテキスト内に存在する値が見つからない
pagename: as-template-fields-missing-values
lang: ja
---

# as_template_fields() でコンテキスト内に存在する値が見つからない

[as_template_fields()](https://developer.shotgridsoftware.com/tk-core/core.html?#sgtk.Context.as_template_fields) メソッドはパス キャッシュを使用するため、テンプレートのキーに対応するフォルダがまだ作成されていない場合、フィールドは返されません。これにはいくつかの原因があります。

- テンプレート定義とスキーマを同期させる必要があります。このテンプレート定義またはパイプライン設定のスキーマの両方ではなく、いずれかを修正した場合は、予想フィールドが返されません。
- フォルダはこの特定のコンテキスト用に作成されていません。まだ作成されていない場合は、パス キャッシュで一致するレコードがないため、予想フィールドが返されません。
