---
layout: default
title: 安装
pagename: event-daemon-installation
lang: zh_CN
---

# 安装

以下手册将帮助您为您的工作室设置 {% include product %}Events。

<a id="System_Requirements"></a>

## 系统要求

进程可以在已安装 Python 且对 {% include product %} 服务器具有网络访问权限的任何计算机上运行。它**不**需要在 {% include product %} 服务器本身上运行。实际上，如果您使用的是 {% include product %} 的托管版本，这不是可用选项。但是，您可以根据需要在 {% include product %} 服务器上运行它。否则，您可以使用任何服务器。

- Python v2.6、v2.7 或 3.7
- [{% include product %} Python API](https://github.com/shotgunsoftware/python-api)
  - 对于 Python v2.6 或 v2.7，应使用 v3.0.37 或更高版本，对 Python 3.7，则应使用 v3.1.0 或更高版本。
  - 无论是哪种情况，我们都强烈建议使用[最新版本的 Python API](https://github.com/shotgunsoftware/python-api/releases)，并随时更新此依存项。
- 对 {% include product %} 服务器的网络访问权限

<a id="Installing_Shotgun_API"></a>

## 安装 {% include product %} API

假设您的计算机上已安装 Python，现在需要安装 {% include product %} Python API，以便 {% include product %} Event 进程可以使用它来连接您的 {% include product %} 服务器。您可以通过多种方式完成此操作：

- 将它与 {% include product %} Event 进程置于同一目录中
- 将它放在 [`PYTHONPATH` 环境变量](http://docs.python.org/tutorial/modules.html)指定的某个目录中。

要测试 {% include product %} API 是否正确安装，请观察终端窗口：

```
$ python -c "import shotgun_api3"
```

终端窗口不应输出任何内容。如果您看到类似于以下输出的内容，则请检查 `PYTHONPATH` 的设置是否正确无误，或 {% include product %} API 是否位于当前目录中。

```
$ python -c "import shotgun_api3"
Traceback (most recent call last):
File "<string>", line 1, in <module>
ImportError: No module named shotgun_api3
```

<a id="Installing_shotgunEvents"></a>

## 安装 {% include product %}Events

{% include product %}Events 的安装位置完全由您决定。同样，只要计算机上安装了 Python 和 {% include product %} API，并且计算机具有 {% include product %} 服务器的网络访问权限，就可以从任意位置运行。但是，如果安装位置能够为工作室提供方便，那自然是再好不过了，比如说 `/usr/local/shotgun/shotgunEvents` 就很方便。因此，下面我们就以此为例进行介绍。

请访问 GitHub 获取源和归档：[https://github.com/shotgunsoftware/shotgunEvents]()

{% include info title="注意" content="**对于 Windows：**如果有 Windows 服务器，那么您可以使用 `C:\shotgun\shotgunEvents`，但是，在本文档中，我们使用的是 Linux 路径。" %}

<a id="Cloning_Source"></a>

### 克隆源

如果已在计算机上安装 `git`，那么抓取源时最简单方法就是克隆项目。这样，您还可以轻松获取所有已承诺的更新，以确保您随时获取错误修复和新功能。

```
$ cd /usr/local/shotgun
$ git clone git://github.com/shotgunsoftware/shotgunEvents.git
```

{% include info title="警告" content="请务必确保先备份您的配置、插件和对 shotgunEvents 所做的任何修改，然后再通过 GitHub 引入更新，以免数据丢失。或者，您也可以自己 Fork 项目，以便保留自己的更改存储库。:)" %}

<a id="Downloading_Archive"></a>

### 下载归档

如果您的计算机上没有 `git`，或者您只是想下载源的归档，则可以按照以下步骤进行操作。

- 转到 [https://github.com/shotgunsoftware/shotgunEvents/archives/master]()
- 下载所需格式的源
- 将其保存到计算机
- 将文件提取到 `/usr/local/shotgun` 目录
- 将 `/usr/local/shotgun/shotgunsoftware-shotgunEvents-xxxxxxx` 目录重命名为 `/usr/local/shotgun/shotgunEvents`

#### 将归档提取到 `/usr/local/shotgun`。

对于.tar.gz 归档：

```
$ tar -zxvf shotgunsoftware-shotgunEvents-v0.9-12-g1c0c3eb.tar.gz -C /usr/local/shotgun
```

对于.zip 归档：

```
$ unzip shotgunsoftware-shotgunEvents-v0.9-12-g1c0c3eb.zip -d /usr/local/shotgun
```

然后，您可以将 GitHub 指定的目录名称重命名为 `shotgunEvents`：

```
$ mv shotgunsoftware-shotgunEvents-1c0c3eb shotgunEvents
```

现在，您应该可以看到如下所示的内容：

```
$ ls -l /usr/local/shotgun/shotgunEvents
total 16
-rw-r--r--  1 kp  wheel  1127 Sep  1 17:46 LICENSE
-rw-r--r--  1 kp  wheel   268 Sep  1 17:46 README.mkd
drwxr-xr-x  9 kp  wheel   306 Sep  1 17:46 docs
drwxr-xr-x  6 kp  wheel   204 Sep  1 17:46 src
```

<a id="Installing Requirements"></a>

### 安装要求

在库的根目录下提供了一个 `requirements.txt` 文件。您应使用此文件来安装所需的软件包。

```
$ pip install -r /path/to/requirements.txt
```

<a id="Windows_Specifics"></a>

### Windows 特定注意事项

Windows 系统上需要具有以下其中一项：

- 已安装 [PyWin32](http://sourceforge.net/projects/pywin32/) 的 Python
- [Active Python](http://www.activestate.com/activepython)

Active Python 附带 PyWin32 模块，在集成 {% include product %} Event 进程和 Windows 服务架构时，需要用到此模块。

然后，您可以通过运行以下命令，以服务的形式来安装进程（假设 `C:\Python27_32\python.exe` 是 Python 可执行文件的路径，根据具体情况加以调整）：

```
> C:\Python27_32\python.exe shotgunEventDaemon.py install
```

或通过以下方式予以移除：

```
> C:\Python27_32\python.exe shotgunEventDaemon.py remove
```

借助常规服务管理工具或以下命令行，即可启动和停止服务：

```
> C:\Python27_32\python.exe shotgunEventDaemon.py start
> C:\Python27_32\python.exe shotgunEventDaemon.py stop
```

大多数情况下，您都需要确保以系统管理用户的身份运行列出的每一个命令。为此，您可以右键单击 cmd 应用程序并选择“以管理员身份运行”。

{% include info title="注意" content="如果您已在 Windows 上的网络位置安装了该进程，或者已将该进程配置为从网络位置读取和写入日志及其他资源，则您必须编辑服务的属性，将运行服务的用户从本地计算机帐户更改为能够访问网络资源的域帐户。" %}
