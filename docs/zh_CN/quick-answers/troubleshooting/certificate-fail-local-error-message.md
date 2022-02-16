---
layout: default
title: 在本地 {% include product %} 站点上使用 {% include product %} Desktop 时显示 CERTIFICATE_VERIFY_FAILED
pagename: certificate-fail-local-error-message
lang: zh_CN
---

# 在本地 {% include product %} 站点上使用 {% include product %} Desktop 时显示 CERTIFICATE_VERIFY_FAILED

## 用例：

使用 {% include product %} 的本地安装时，在以下两种情况中可能会出现此错误：

- 登录 {% include product %} Desktop 时
- 从 Toolkit 应用商店下载媒体时

## 如何修复：

要解决此问题，您需要向 {% include product %} API 提供一个文件，其中包含所有有效 CA 的列表，包括您自己的 CA。我们通常建议用户从 Python 的 `certifi` 软件包下载[此文件](https://github.com/certifi/python-certifi/blob/master/certifi/cacert.pem)的最新副本作为起点，然后在文件末尾添加自己的 CA。然后，将该文件保存到所有用户都可以访问的位置。最后，在每台计算机上，将 `SHOTGUN_API_CACERTS` 环境变量设置为该文件的完整路径，例如 `/path/to/my/ca/file.pem`。

这样做应该可以解决您在本地站点上遇到的任何 `CERTIFICATE_VERIFY_FAILED` 错误。请注意，如果您能够连接到 {% include product %} 站点，但仍无法从 Toolkit 应用商店下载更新，则可能是因为您的 `.pem` 文件中缺少 Amazon CA。如果您从一个空文件开始，而且仅添加了您的自定义 CA，而不是从我们上面链接到的文件开始，通常会发生这种情况。

请注意，这些信息*仅*适用于本地安装。如果您有一个托管站点并遇到此错误，对于 Windows，请查看[此论坛帖子](https://community.shotgridsoftware.com/t/certificate-verify-failed-error-on-windows/8860)。对于其他操作系统，请查看[此文档](https://developer.shotgridsoftware.com/zh_CN/c593f0aa/)。

## 导致此错误的原因示例：

之所以出现此问题，通常是因为您已将本地站点配置为使用 HTTPS，但您尚未配置 Toolkit，因此识别的是您用于签署本地站点证书的证书颁发机构（此后称为 CA）。

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/getting-certificate-verify-failed-when-using-shotgun-desktop-on-a-local-shotgun-site/10466)。

