---
layout: default
title: 故障排除指南
pagename: quick-answers-troubleshooting
lang: zh_CN
---

故障排除指南
===

一组旨在解决问题的快速解答。

#### 常规疑难解答帮助

- [性能疑难解答](./troubleshooting/performance-troubleshooting.md)
- [如何启用调试日志记录？](./troubleshooting/turn-debug-logging-on.md)
- [远程调试](https://community.shotgridsoftware.com/t/remote-debugging/3869)
- [我的日志文件位于何处？](./troubleshooting/where-are-my-log-files.md)
- [Toolkit 日志工作方式以及如何知道要查看哪一个日志？](https://community.shotgridsoftware.com/t/how-do-the-toolkit-logs-work-and-how-do-i-know-which-one-to-look-at/6721)
- [我的配置位于何处？](https://community.shotgridsoftware.com/t/ive-asked-a-client-for-their-config-but-they-dont-know-where-it-is/6729)
- [如何调试 Toolkit 应用在菜单、{% include product %} Desktop 或 AMI 中不加载、不显示、缺失的问题](https://community.shotgridsoftware.com/t/how-to-debug-toolkit-apps-not-loading-showing-up-missing-in-the-menus-shotgun-desktop-or-the-amis/6739)
- [为什么我的上下文缺少任务/工序，但它是文件名的一部分？](./troubleshooting/context-missing-task-step.md)
- [为什么以及如何取消注册文件夹？](https://community.shotgridsoftware.com/t/toolkit-episode-sequence-shot-task/4604)
- [我能否删除站点上的文件系统位置而不是取消注册文件夹？](https://community.shotgridsoftware.com/t/unregistering-folders-in-tank-vs-moving-file-system-locations-to-trash/536)
- [使用分布式配置时如何取消注册文件夹？](https://community.shotgridsoftware.com/t/how-can-i-unregister-folders-when-using-a-distributed-config)

#### 错误消息指导
- [`ASCII` 编解码器无法解码位置 10 中的字节 0x97: 序号不在范围内](./troubleshooting/ascii-error-message.md)
- [配置未指向磁盘上的有效包！](./troubleshooting/configurations-does-not-point-to-valid-bundle-on-disk.md)
- [找不到程序“MTsetToggleMenuItem”](./troubleshooting/mtsettogglemenuitem-error-message.md)
- [无法解析路径的行 ID！](./troubleshooting/row-id-error-message.md)
- [data_handler_cache 错误消息: 错误 sgtk.env.project.tk-nuke.tk-multi-workfiles2 无法创建“文件打开”(File Open)对话框！](./troubleshooting/data-handler-cache-error-message.md)
- [数据库并发问题: 路径 `<PATH>` 已与 {% include product %} 实体 `<ENTITY>` 相关联](./troubleshooting/path-associated-error-message.md)
- [错误: 应用商店不包含名为 my-app 的项](./troubleshooting/myapp-appstore-error-message.md)
- [[错误] 尝试在未完成加密握手的情况下进行通信。](./troubleshooting/encryption-handshake-error-message.md)
- [错误“选择的 LUT 无效: Gamma2.2”](./troubleshooting/invalid-lut-error-message.md)
- [[错误] [代理] 调用 __commands::unreal_engine 时出错](./troubleshooting/unreal-proxy-error-message.md)
- [[错误 publish_creation] <urlopen 错误 [SSL: CERTIFICATE_VERIFY_FAILED] 证书验证失败(_ssl.c:726)>](./troubleshooting/publish-certificate-fail-error-message.md)
- [错误: {% include product %} tk-maya: Toolkit 产生异常](./troubleshooting/tk-maya-exception-error-message.md)
- [错误 18:13:28.365:Hiero(34236): 错误！任务类型](./troubleshooting/hiero-task-type-error-message.md)
- [异常: 审核提交失败。无法渲染和提交与审核关联的场。](./troubleshooting/review-submission-error-message.md)
- [由于 Windows 路径太长(> 256 个字符)而导致的错误](./troubleshooting/paths-long-error-message.md)
- [无法更改工作区 - 执行 MEL 脚本期间出错](./troubleshooting/error-during-execution-mel-script.md)
- [无法创建文件夹: 文件夹创建中止](./troubleshooting/folder-creation-aborded.md)
- [帧服务器遇到错误。](./troubleshooting/frame-server-error.md)
- [ModuleNotFoundError](./troubleshooting/modulenotfounderror-error.md)
- [在 Maya 中，当我输出 context.task 时，它为空白“无”(None)](./troubleshooting/maya-context-task-empty-none-error.md)
- [解决与 Python API 相关的 SSL: CERTIFICATE_VERIFY_FAILED 问题](./troubleshooting/fix-ssl-certificate-verify-failed.md)
- [在本地 {% include product %} 站点上使用 {% include product %} Desktop 时显示 CERTIFICATE_VERIFY_FAILED](./troubleshooting/certificate-fail-local-error-message.md)
- [SSLError: [Errno 8] _ssl.c:504: 违反协议时发生 EOF](./troubleshooting/eof-occurred-violation-protocol-tls.md)
- [[SSL: CERTIFICATE_VERIFY_FAILED] 证书验证失败: 无法获取本地颁发机构证书](./troubleshooting/unable-to-get-local-issuer-certificate-error.md)
- [TankInitError: 您正从位于以下位置的工作流配置加载 Toolkit 平台](./troubleshooting/tankinit-error-pipeline-config-location.md)
- [TankError: 无法解析上下文的模板数据](./troubleshooting/tankerror-cannot-resolve-template-data-error.md)
- [TankError: 尝试从模板解析路径](./troubleshooting/tankerror-tried-to-resolve-a-path.md)
- [Tk-desktop 控制台以静默方式忽略错误](./troubleshooting/tk-desktop-console-silently-ignoring-errors.md)
- [SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] 证书验证失败(_ssl.c:727)](./troubleshooting/sslhandshakeerror-ssl-certificate-verify-failed.md)
- [TankError: 无法在磁盘上创建文件夹。报告错误: 严重！无法使用文件夹数据更新 {% include product %}。](./troubleshooting/could-not-update-with-folder-data.md)
- [[警告] 存储根主存储无法映射到 SG 本地存储](./troubleshooting/storage-root-primary-error-message.md)


#### 软件集成
- [在项目之间共享/更新工作流配置的建议方式？](https://community.shotgridsoftware.com/t/recommended-way-to-share-update-pipeline-configurations-between-projects/5609)
- [如何为在家办公的用户分发工作流配置](https://community.shotgridsoftware.com/t/distributing-your-pipeline-configuration-to-users-working-from-home/7910)
- [对于某些用户，如何将集中式配置转变为分布式配置？](https://community.shotgridsoftware.com/t/turning-a-centralized-config-into-a-distributed-config-for-some-users/7744)
- [如何在 Windows 上编译 Qt UI 和资源文件](https://community.shotgridsoftware.com/t/how-to-compile-qt-ui-and-resource-files-on-windows/7099)
- [如何在 {% include product %} UI 中添加 Toolkit 上下文菜单项？](https://community.shotgridsoftware.com/t/toolkit-context-menu-items/8426)
- [为什么我的 Houdini {% include product %} 集成没有启动？](./troubleshooting/houdini-integrations-not-starting.md)
- [我已从 Shotgun Desktop 启动 Nuke/Maya 等，{% include product %} Desktop 启动 Nuke/Maya 等，但 {% include product %} 菜单中缺少相关条目](./troubleshooting/menu-entries-missing-in-launched-dcc.md)
- [当我设置 NUKE_PATH 环境变量时为什么 Nuke 集成无法启动？](./troubleshooting/nuke-path-environment-variable.md)
- [安装两种扩展时的 Photoshop 集成疑难解答](./troubleshooting/two-photoshop-shotgun-extensions.md)
- [使用 {% include product %} Toolkit 时，为什么启动时 3ds Max 发生崩溃？](./troubleshooting/3dsmax-crashes-on-startup.md)
- [如何设置默认软件版本？](https://community.shotgridsoftware.com/t/setting-a-default-software-version/1116)
- [为什么加载器应用不显示我的 Alembic 发布？](https://community.shotgridsoftware.com/t/why-is-the-loader-app-not-showing-my-alembic-publishes/906)
- [当 Toolkit 引导时，使用什么顺序来确定正确的 PipelineConfiguration 实体？](https://community.shotgridsoftware.com/t/when-toolkit-bootstraps-what-order-is-used-to-determine-the-correct-pipelineconfiguration-entity/7400)
- [为什么在 Photoshop 中显示两个不同的 SG 面板？](https://community.shotgridsoftware.com/t/why-do-i-get-two-different-sg-panels-in-photoshop/6976)
- [Photoshop 集成面板无法加载！“出现了一些问题”](https://community.shotgridsoftware.com/t/photoshop-integration-panel-is-stuck-loading-some-thing-went-wrong/6977)
- [Desktop 缺少软件实体，如何修复此问题？](https://community.shotgridsoftware.com/t/shotgun-deskop-missing-software-entities-help/858)
- [Tank.template_from_path() 无法返回多个模板？](https://community.shotgridsoftware.com/t/tank-template-from-path-cant-return-multiple-templates/614)
- [如何以程序方式使用艺术家的工作文件填充一系列镜头（整个场）？](https://community.shotgridsoftware.com/t/create-first-maya-workfile/3029)
- [当用户启动 tk-maya 时，我如何控制 userSetup.py？](https://community.shotgridsoftware.com/t/maya-usersetup-py/3993)
- [用于开发配置的 Tank 命令？](https://community.shotgridsoftware.com/t/tank-command-for-dev-config/3373)
- [我想仅在艺术家打开现有发布时（而不是在他们打开现有工作文件时）才执行操作。如何使用挂钩执行此操作？](https://community.shotgridsoftware.com/t/open-from-publish-in-tk-multi-workfiles2-scene-operation-hooks/352)
- [如何在文件夹创建期间将实体名称中的空格转换为下划线而不是连字符？](https://community.shotgridsoftware.com/t/how-do-i-convert-white-spaces-in-entity-names-to-underscores-and-not-hyphens-during-folder-creation/48)

#### 浏览器集成
- [我无法通过 Chrome 使用本地文件链接和启动 Toolkit 应用程序](./troubleshooting/cant-use-file-linking-toolkit-app-chrome.md)
- [我无法通过 Firefox 使用本地文件链接和启动 Toolkit 应用程序](./troubleshooting/cant-use-file-linking-toolkit-app-firefox.md)
- [无法在 Linux 上启动 {% include product %} Desktop/浏览器集成](./troubleshooting/browser-integration-fails-linux.md)

#### 找不到答案？
如需进一步排查问题，您可以[搜索我们的社区](https://community.shotgridsoftware.com)寻找答案！

![社区](images/search_community.gif)
