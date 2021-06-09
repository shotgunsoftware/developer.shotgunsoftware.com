---
layout: default
title: デスクトップ起動
pagename: tk-framework-desktopstartup
lang: ja
---

# Toolkit デスクトップ起動フレームワーク
デスクトップ起動フレームワークには、{% include product %} Desktop の起動ロジックが実装されています。主な機能は次のとおりです。

1. ブラウザの統合の初期化
2. ユーザのログイン
3. Toolkit のダウンロード
4. サイト構成の設定
5. 自分自身の自動更新とサイト構成(必要な場合)
6. `tk-desktop` エンジンを起動します。

> これは内部の Toolkit フレームワークなので、実装するインタフェースは変更される可能性があります。プロジェクトではこのフレームワークを使用しないことを推奨します。

### 起動ロジックのロックダウン

> これには、バージョン `1.3.4` の {% include product %} Desktop アプリが必要です。アプリケーションのバージョンが不明な場合は、{% include product %} Desktop を起動します。ログインしたら、右下のユーザ アイコンをクリックし、`About...` をクリックします。`App Version` は `1.3.4` 以上でなければなりません。

既定では、{% include product %} Desktop はユーザのローカル マシンに `tk-framework-desktopstartup` アップデートをダウンロードし、アプリケーションの起動シーケンス時に使用します。アプリケーションを起動すると、Toolkit は自動的にフレームワークの更新をチェックします。利用可能なアップデートがあれば、自動的にダウンロードしてインストールします。

または、ローカル コピーではなくフレームワークの特定のコピーを使用するように {% include product %} Desktop を構成することもできます。これにより自動更新機能が無効になり、ユーザが自分自身が起動ロジックを更新できるようになります。[こちらのページ](https://support.shotgunsoftware.com/hc/ja/articles/219040058)を定期的に確認し、常に最新のバージョンを使用することを推奨します。

#### GitHub から特定のリリースをダウンロードする

GitHub から手動でアップデートをダウンロードする必要があります。バンドルは、[リリース](https://github.com/shotgunsoftware/tk-framework-desktopstartup/releases) ページから簡単にダウンロードできます。公式リリースの詳細については、[こちら](https://support.shotgunsoftware.com/entries/97454918#toc_release_notes)を参照してください。

#### 特定のコピーを使用する場合の {% include product %} Desktop の設定

起動ロジックをロックダウンする唯一の方法は環境変数を使用することです。`SGTK_DESKTOP_STARTUP_LOCATION` をフレームワークのコピーのルート フォルダに設定すると、{% include product %} Desktop は起動時にこのコードのコピーを使用します。環境変数を設定すると、このコピーの起動ロジックを使用して {% include product %} Desktop を起動できます。

> 本マニュアルの執筆時点では、技術的な制限のため、起動ロジックをロックするときに `About...` ボックスの `Startup Version` フィールドは `Undefined` になります。

#### 以前の動作に戻す

変更を元に戻すには、環境変数の設定を解除して {% include product %} Desktop を起動します。
