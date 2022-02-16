---
layout: default
title: 開発
pagename: toolkit-development
lang: ja
---

# 開発

## Toolkit とは何か?

Toolkit とは、パイプライン統合の基盤となるプラットフォームのことです。たとえば、Maya で {% include product %} Panel アプリを使用している場合や、{% include product %} Create から Publish アプリを起動している場合は、Toolkit プラットフォーム上に構築されたツールを使用しています。

## Toolkit を使用して開発するには、どうしたらよいですか?

Toolkit を使用して開発する場合は、複数の方法を使用できます。

- フックと呼ばれるカスタム コードを記述して、既存のアプリ、エンジン、またはフレームワークの動作を拡張します。
- 独自のアプリ、エンジン、またはフレームワークを作成します。
- または、API を利用する独自のスタンドアロン スクリプトを記述します。

これらのいずれかの操作を行うには、Toolkit API の使用方法を理解することが重要です。

 {% include product %} 全体には、3 つの主な API があります
- [{% include product %} Python API](https://developer.shotgridsoftware.com/python-api)
- [{% include product %} REST API](https://developer.shotgridsoftware.com/rest-api/)
- [{% include product %} Toolkit API](https://developer.shotgridsoftware.com/tk-core)

Toolkit API は、{% include product %} Python API または REST API と一緒に使用するように設計された Python API です。これらの API の代わりに使用することはできません。
Toolkit API にはいくつかのラッパー メソッドが含まれていますが、一般には、{% include product %} サイトのデータにアクセスする必要がある場合、{% include product %} Python API または REST API を代わりに使用します。

Toolkit API は主に、ファイル パスの統合と管理を行います。一部の Toolkit アプリおよびフレームワークには、[独自の API](../../reference/pipeline-integrations.md) も含まれています。

これらの記事では、Toolkit を使用した開発方法について説明します。