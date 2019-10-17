---
layout: default
title: パイプライン設定のコアの場所を更新するにはどうすればいいですか?
pagename: update-configuration-core-locations
lang: ja
---

# パイプライン設定のコアの場所を更新するにはどうすればいいですか?

## ローカル コアを使用するようにパイプライン設定を更新するにはどうすればいいですか?

[共有 Toolkit コアを使用するようにパイプラインが設定されている](https://support.shotgunsoftware.com/hc/ja/articles/219040468#shared)場合は、基本的に、このプロセスを元に戻すことができます。つまり、コアの「共有を解除」し、tank localize コマンドを使用してパイプライン設定内に Toolkit Core API のコピーをインストールします。これをコアの「ローカライズ」と呼んでいます。 

1. ターミナルを開いて、Toolkit コアのインストール先のパイプライン設定に移動します。

        $ cd /sgtk/software/shotgun/scarlet

2. 次の tank コマンドを実行します。

        $ ./tank localize

        ...
        ...

        ----------------------------------------------------------------------
        Command: Localize
        ----------------------------------------------------------------------

        This will copy the Core API in /sgtk/software/shotgun/studio into the Pipeline
        configuration /sgtk/software/shotgun/scarlet.

        Do you want to proceed [yn]

   続行する前に、Toolkit がすべてを確認します。パイプライン設定が現在指定している Toolkit コアのコピーは、パイプライン設定にローカルにコピーされます。

3. Toolkit は、パイプライン設定で使用中のすべてのアプリ、エンジン、フレームワークを `install` フォルダにローカルにコピーします。次に Toolkit コアがコピーされ、新たにインストールされたローカルな Toolkit コアを使用するようにパイプライン設定内の設定ファイルが更新されます。


        Copying 59 apps, engines and frameworks...
        1/59: Copying tk-multi-workfiles v0.6.15...
        2/59: Copying tk-maya v0.4.7...
        3/59: Copying tk-nuke-breakdown v0.3.0...
        4/59: Copying tk-framework-widget v0.2.2...
        5/59: Copying tk-shell v0.4.1...
        6/59: Copying tk-multi-launchapp Undefined...
        7/59: Copying tk-motionbuilder v0.3.0...
        8/59: Copying tk-hiero-openinshotgun v0.1.0...
        9/59: Copying tk-multi-workfiles2 v0.7.9...
        ...
        ...
        59/59: Copying tk-framework-qtwidgets v2.0.1...
        Localizing Core: /sgtk/software/shotgun/studio/install/core ->
        /sgtk/software/shotgun/scarlet/install/core
        Copying Core Configuration Files...
        The Core API was successfully localized.

        Localize complete! This pipeline configuration now has an independent API. If
        you upgrade the API for this configuration (using the 'tank core' command), no
        other configurations or projects will be affected.

{% include info title="注" content="出力は、インストールしたアプリ、エンジン、およびフレームワークのバージョンによって異なります。" %}

## 既存の共有コアを使用するようにパイプライン設定を更新するにはどうすればいいですか?
既存の共有 Toolkit コアを使用する場合は、tank コマンドを使用して共有コアを使用するように「ローカライズされた」既存のパイプライン設定を更新できます。

1. ターミナルを開いて、更新するパイプライン設定に移動します。

        $ cd /sgtk/software/shotgun/scarlet

2. 次に、`tank attach_to_core` コマンドを実行して、現在のプラットフォーム上の共有コアへの有効なパスを指定します。

        $ ./tank attach_to_core /sgtk/software/shotgun/studio
        ...
        ...
        ----------------------------------------------------------------------
        Command: Attach to core
        ----------------------------------------------------------------------
        After this command has completed, the configuration will not contain an
        embedded copy of the core but instead it will be picked up from the following
        locations:

        - Linux: '/mnt/hgfs/sgtk/software/shotgun/studio'
        - Windows: 'z:\sgtk\software\shotgun\studio'
        - Mac: '/sgtk/software/shotgun/studio'

        Note for expert users: Prior to executing this command, please ensure that you
        have no configurations that are using the core embedded in this configuration.

        Do you want to proceed [yn]

   続行する前に、Toolkit がすべてを確認します。この共有コアは複数のプラットフォーム用に既にセットアップされているため、それぞれの場所を示します。

   *新しいプラットフォームに場所を追加する必要がある場合、共有コア設定内の config/core/install_location.yml を更新して、必要なパスを追加します。*

3. Toolkit は、パイプライン設定のローカル コア API をバックアップし、ローカライズされたコアを削除し、共有コアでパイプライン設定を指定するために必要な設定を追加します。

        Backing up local core install...
        Removing core system files from configuration...
        Creating core proxy...
        The Core API was successfully processed.

   後で、パイプライン設定内で Toolkit コアをローカライズする(つまり、共有コアからパイプライン設定を切り離して、ローカルにインストールされたバージョンを使用する)場合は、`tank localize` コマンドを使用してこの操作を行うことができます。

{% include info title="注" content="スタジオの共有コアは、現在のパイプライン設定のコアと同じかそれ以降のバージョンである必要があります。" %}

## プロジェクト間で Toolkit コアを共有するにはどうすればいいですか?

現在、Toolkit Core API は、SG Desktop を使用してプロジェクトを設定するときに「ローカライズ」されます。つまり、この API がパイプライン設定内にインストールされます。 これは、すべてのパイプライン設定が完全に独立した Toolkit インストールであることを意味します。プロジェクト間で共有する Toolkit Core API のバージョンを使用して、メンテナンスを最小限に抑え、すべてのプロジェクトで同じコア コードが使用されるようにします。これを「**スタジオの共有コア**」と呼ぶこともあります。

次に、異なるプロジェクト パイプライン設定間で共有できる新しい Toolkit Core API 設定を作成する方法を示します。

1. ターミナルを開いて、共有する Toolkit Core バージョンが含まれる既存のパイプライン設定に移動します。プロセスが完了すると、このパイプライン設定はローカライズされなくなりますが、新しく作成した共有コアは使用されます。

        $ cd /sgtk/software/shotgun/pied_piper

2. 次の tank コマンドを実行して、Toolkit core をディスクの外部の場所にコピーします。このパスがすべてのプラットフォームで見つかるように、場所を指定する必要があります(inux_path、windows_path, mac_path)。各パスに引用符を使用することをお勧めします。特定のプラットフォームで Toolkit を使用しない場合は、空の文字列 `""` を指定するだけです。 

        $ ./tank share_core "/mnt/sgtk/software/shotgun/studio" "Z:\sgtk\software\shotgun\studio" \ "/sgtk/software/shotgun/studio"

3. Toolkit が処理を続ける前に、加えられる変更の概要が表示されます。

        ----------------------------------------------------------------------
        Command: Share core
        ----------------------------------------------------------------------
        This will move the embedded core API in the configuration
        '/sgtk/software/shotgun/pied_piper'.
        After this command has completed, the configuration will not contain an
        embedded copy of the core but instead it will be picked up from the following
        locations:
        - Linux: '/mnt/sgtk/software/shotgun/studio'
        - Windows: 'Z:\sgtk\software\shotgun\studio'
        - Mac: '/sgtk/software/shotgun/studio'
        Note for expert users: Prior to executing this command, please ensure that you
        have no configurations that are using the core embedded in this configuration.
        Do you want to proceed [yn]

4. Toolkit は新しい共有場所にコア インストールをコピーし、新しい共有コアを指定するように既存のパイプライン設定を更新します。

        Setting up base structure...
        Copying configuration files...
        Copying core installation...
        Backing up local core install...
        Removing core system files from configuration...
        Creating core proxy...
        The Core API was successfully processed.

これで他のパイプライン設定からこの新しい共有コアを使用できます。既存の共有コア(先ほど作成したコアなど)を使用するようにパイプライン設定を更新するには、`tank attach_to_core` コマンドを使用します。