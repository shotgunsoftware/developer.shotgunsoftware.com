---
layout: default
title: 严重！无法使用文件夹数据更新 ShotGrid。
pagename: could-not-update-with-folder-data
lang: zh_CN
---

# TankError: 无法在磁盘上创建文件夹。报告错误: 严重！无法使用文件夹数据更新 {% include product %}。

## 用例

我们正在使用集中式配置，并为现有项目添加 Linux 支持，但文件系统配置存在问题。

我们已经

- 将相应的根添加到 roots.yml
- 在工作流配置、install_location.yml 等中添加了 Linux 路径
- 为软件实体添加了 Linux 路径

现在，{% include product %} Desktop 会成功启动，但尝试启动程序时，会出现：

```
TankError: Could not create folders on disk. Error reported: Critical! Could not update Shotgun with folder data. Please contact support. Error details: API batch() request with index 0 failed.  All requests rolled back.
API create() CRUD ERROR #6: Create failed for [Attachment]: Path /mnt/cache/btltest3 doesn't match any defined Local Storage.
```

同样，当尝试运行 tank 文件夹和其他命令时，也会出现相同的错误。

我相信我们已经在所有必要的位置添加了 Linux 路径。这是同步数据库的问题吗？

`tank synchronize_folders` 会输出消息和其他内容。

- 路径未与任何 {% include product %} 对象相关联。

## 如何修复

将您的 Linux 路径添加到 {% include product %} 中的本地存储，它位于“站点偏好设置 > 文件管理”(Site Preferences > File Management)下。


## 相关链接

[在社区中查看完整主题](https://community.shotgridsoftware.com/t/first-time-setting-up-shotgun-and-i-have-this-error/9384)