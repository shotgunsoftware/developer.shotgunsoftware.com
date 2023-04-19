---
layout: default
title: SSLHandshakeError CERTIFICATE_VERIFY_FAILED 证书验证失败
pagename: sslhandshakeerror-ssl-certificate-verify-failed
lang: zh_CN
---

# SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] 证书验证失败

## 用例

在使用防火墙进行本地数据包检测的本地网络上，您可能会收到以下错误消息： 

```
SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:727)
```

发生此错误是因为这些防火墙通常配置有网络管理员自行创建且 Python 无权访问的自签名证书。遗憾的是，与其他应用程序不同，Python 并不总是在操作系统的密钥链中查找证书，因此您必须自己提供。

## 如何修复

您需要设置 `SHOTGUN_API_CACERTS` 环境变量以指向磁盘上的文件，该文件包含 Python API 和 Shotgun Desktop 可以信任的证书颁发机构的完整列表。

您可以从 Github 上最新的 `certifi` 软件包副本下载此类[副本](https://github.com/certifi/python-certifi/blob/master/certifi/cacert.pem)。完成此操作后，**需要在该文件的底部添加公司防火墙的公共密钥并保存。**

完成后，只需将 `SHOTGUN_API_CACERTS` 环境变量设置为路径位置，例如 `/opt/certs/cacert.pem`，然后启动 Shotgun Desktop。

## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/using-shotgun-desktop-behind-an-firewall-with-ssl-introspection/11434)
