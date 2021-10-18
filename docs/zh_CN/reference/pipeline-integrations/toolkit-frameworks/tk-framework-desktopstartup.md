---
layout: default
title: 桌面启动
pagename: tk-framework-desktopstartup
lang: zh_CN
---

# Toolkit 桌面启动框架
桌面启动框架用于执行 {% include product %} Desktop 的启动逻辑。它的主要功能包括：

1. 初始化浏览器集成
2. 完成用户登录
3. 下载 Toolkit
4. 配置站点配置
5. 自动更新自身并在必要时更新站点配置
6. 启动 `tk-desktop` 插件。

> 这是一个内部 Toolkit 框架，因此它实现的界面随时可能发生变化。建议您不要在自己的项目中使用此框架。

### 锁定启动逻辑

> 请注意，此操作需要使用版本为 `1.3.4` 的 {% include product %} Desktop 应用。如果您不确定自己的应用程序版本，请启动 {% include product %} Desktop。登录后，单击右下角的用户图标，然后单击 `About...`。`App Version` 应该为 `1.3.4` 或更高版本。

默认情况下，{% include product %} Desktop 会将 `tk-framework-desktopstartup` 更新下载到用户计算机本地，并在应用程序启动过程中使用它。当您启动应用程序时，Toolkit 会自动检查是否有此框架的更新。如果有更新，它还会自动下载并安装更新。

另外，您还可以将 {% include product %} Desktop 配置为使用框架的特定副本，而不使用本地副本。这样做将禁用自动更新功能，您需要自己更新启动逻辑。

#### 从 GitHub 下载特定的发布版本

有时，您需要手动从 GitHub 下载更新。您可以很容易地从[版本(Releases)](https://github.com/shotgunsoftware/tk-framework-desktopstartup/releases)页面下载软件包，并可在[此处](https://community.shotgridsoftware.com/tags/c/pipeline/6/release-notes)找到有关每个官方发布版本的详细信息。

#### 配置 {% include product %} Desktop 使用特定副本

要锁定启动逻辑，唯一的方法是使用环境变量。将 `SGTK_DESKTOP_STARTUP_LOCATION` 设置为框架某个副本的根文件夹，即表示您指示 {% include product %} Desktop 在启动时使用这份代码副本。变量设置完毕后，您可以启动 {% include product %} Desktop，它将使用这份特定的启动逻辑副本。

> 请注意，撰写本文时，由于技术限制，`About...` 框中的 `Startup Version` 字段在锁定启动逻辑时将为 `Undefined`。

#### 还原至旧的行为

要还原您的更改，只需取消设置环境变量，然后启动 {% include product %} Desktop 即可。
