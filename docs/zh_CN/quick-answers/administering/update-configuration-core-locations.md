---
layout: default
title: 如何更新我的工作流配置核心位置？
pagename: update-configuration-core-locations
lang: zh_CN
---

# 如何更新我的工作流配置核心位置？

## 如何更新我的工作流配置以使用本地核心？

如果您的工作流配置已设置为使用共享 Toolkit 核心，那么您实际上可以撤消该过程，或者“取消共享”核心，并使用 tank localize 命令在工作流配置内安装 Toolkit 核心 API 的副本。我们将其称为“本地化”核心。

1.  打开终端并导航到要安装 Toolkit 核心的工作流配置。

        $ cd /sgtk/software/shotgun/scarlet

2.  运行以下 tank 命令：

         $ ./tank localize

         ...
         ...

         ----------------------------------------------------------------------
         Command: Localize
         ----------------------------------------------------------------------

         This will copy the Core API in /sgtk/software/shotgun/studio into the Pipeline
         configuration /sgtk/software/shotgun/scarlet.

         Do you want to proceed [yn]

    Toolkit 将确认所有内容，然后再继续。工作流配置当前指向的 Toolkit 核心的副本将在本地复制到您的工作流配置中。

3.  Toolkit 现在会将工作流配置使用的所有应用、插件和框架本地复制到 `install` 文件夹中。然后，它将复制 Toolkit 核心并更新工作流配置中的配置文件，以使用新安装的本地 Toolkit 核心。

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

{% include info title="注意" content="您的输出将根据所安装的应用、插件和框架版本而有所不同。" %}

## 如何更新我的工作流配置以使用现有共享核心？

如果您有现有的共享 Toolkit 核心，则可以使用 tank 命令来更新任何现有的“本地化”工作流配置，以使用该共享核心。

1.  打开终端并导航到要更新的工作流配置。

        $ cd /sgtk/software/shotgun/scarlet

2.  接下来，您将运行 `tank attach_to_core` 命令并提供共享核心在当前平台上的有效路径。

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

    Toolkit 将确认所有内容，然后再继续。由于此共享核心已针对多个平台设置，它将显示每个平台的位置。

    _如果您需要为新平台添加该位置，请更新共享核心配置中的 config/core/install_location.yml 文件并添加必要的路径。_

3.  现在，Toolkit 会在工作流配置中备份本地核心 API，移除本地化核心，并添加必要的配置以将工作流配置指向共享核心。

         Backing up local core install...
         Removing core system files from configuration...
         Creating core proxy...
         The Core API was successfully processed.

    如果您稍后决定要在工作流配置中本地化 Toolkit 核心（即，从共享核心分离工作流配置并使用本地安装的版本），则可以使用 `tank localize` 命令执行此操作。

{% include info title="注意" content="共享工作室核心的版本必须与当前工作流配置的核心相同或更高。" %}

## 如何在项目之间共享 Toolkit 核心？

目前，使用 SG Desktop 设置项目时，Toolkit 核心 API 会进行“本地化”，这意味着它会安装在工作流配置内部。也就是说，每个工作流配置会完全独立地安装 Toolkit。您可能更希望在项目之间共享 Toolkit 核心 API 版本，这样可以最大程度减少维护量，并可确保所有项目均使用相同的核心代码。我们有时称之为 “**共享工作室核心**”。

以下介绍了如何创建可在不同项目工作流配置之间共享的新 Toolkit 核心 API 配置。

1.  打开终端并导航到包含要共享的 Toolkit 核心版本的现有工作流配置。该过程完成后，此工作流配置将不再进行本地化，而是使用新创建的共享核心。

        $ cd /sgtk/software/shotgun/pied_piper

2.  运行以下 tank 命令，以将 Toolkit 核心复制到磁盘上的外部位置。您提供的位置应该是可以在所有平台上找到此路径（linux_path、windows_path、mac_path）。我们建议使用引号将每个路径引起来。如果不是在特定平台上使用 Toolkit，只需指定一个空字符串 `""`。

        $ ./tank share_core "/mnt/sgtk/software/shotgun/studio" "Z:\sgtk\software\shotgun\studio" \ "/sgtk/software/shotgun/studio"

3.  系统将显示一个在 Toolkit 继续之前要进行的更改的摘要。

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

4.  Toolkit 将核心安装复制到新共享位置，并将更新现有工作流配置以指向新共享核心。

        Setting up base structure...
        Copying configuration files...
        Copying core installation...
        Backing up local core install...
        Removing core system files from configuration...
        Creating core proxy...
        The Core API was successfully processed.

现在，您可以从其他工作流配置中使用此新共享核心。要更新工作流配置以使用现有共享核心（如刚创建的共享核心），您可以使用 `tank attach_to_core` 命令。
