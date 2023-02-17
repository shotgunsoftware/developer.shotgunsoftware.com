---
layout: default
title: Installation
pagename: event-daemon-installation
lang: en
---


# Installation

The following guide will help you setup {% include product %}Events for your studio.

<a id="System_Requirements"></a>
## System Requirements

The daemon can run on any machine that has Python installed and has network access to your {% include product %} server. It does **not** need to run on the {% include product %} server itself. In fact, if you are using the hosted version of {% include product %}, this isn't an option. However, you may run it on your {% include product %} server if you like. Otherwise, any server will do.

* [{% include product %} Python API](https://github.com/shotgunsoftware/python-api)
  * Use use v3.1.0+ for Python 3.7+ (_note: Python 2 is no longer supported_).
  * In either case, we strongly suggest using [the most up to date Python API version](https://github.com/shotgunsoftware/python-api/releases) and keeping this dependency updated over time.
* Network access to your {% include product %} server

<a id="Installing_Shotgun_API"></a>
## Installing the {% include product %} API

Assuming Python is already installed on your machine, you now need to install the {% include product %} Python API so that the {% include product %} Event Daemon can use it to connect to your {% include product %} server. You can do this in a couple of ways:

- place it in the same directory as the {% include product %} Event Daemon
- place it in one of the directories specified by the [`PYTHONPATH` environment variable](http://docs.python.org/tutorial/modules.html).

To test that the {% include product %} API is installed correctly, from your terminal window:

```
$ python -c "import shotgun_api3"
```

You should see no output. If you see something like the output below then you need to make sure your `PYTHONPATH` is setup correctly or that the {% include product %} API is located in the current directory.

```
$ python -c "import shotgun_api3"
Traceback (most recent call last):
File "<string>", line 1, in <module>
ImportError: No module named shotgun_api3
```

<a id="Installing_shotgunEvents"></a>
## Installing {% include product %}Events

The location you choose to install {% include product %}Events is really up to you. Again, as long as Python and the {% include product %} API are installed on the machine, and it has network access to your {% include product %} server, it can run from anywhere. However, it makes sense to install it somehwere that is logical to your studio, something like `/usr/local/shotgun/shotgunEvents` seems logical so we'll use that as the example from here on out.

The source and archives are available on GitHub at [https://github.com/shotgunsoftware/shotgunEvents]()

{% include info title="Note" content="**For Windows:** You could use `C:\shotgun\shotgunEvents` if you have a Windows server but for this documentation we will be using the Linux path." %}

<a id="Cloning_Source"></a>
### Cloning the source

The easiest way to grab the source if you have `git` installed on the machine is to simply clone the project. This way you can also easily pull in any updates that are committed to ensure you stay up to date with bug fixes and new features.

```
$ cd /usr/local/shotgun
$ git clone git://github.com/shotgunsoftware/shotgunEvents.git
```

{% include info title="Warning" content="Always make sure you backup your configuration, plugins, and any modifications you make to shotgunEvents before pulling in updates from GitHub so you don't lose anything. Or, fork the project yourself so you can maintain your own repository of changes :)" %}

<a id="Downloading_Archive"></a>
### Downloading the archive

If you don't have `git` on your machine or you simply would rather download an archive of the source, you can get things rolling following these steps.

- head over to [https://github.com/shotgunsoftware/shotgunEvents/archives/master]()
- download the source in the format you want
- save it to your machine
- extract the files to the `/usr/local/shotgun` directory
- rename the `/usr/local/shotgun/shotgunsoftware-shotgunEvents-xxxxxxx` directory to `/usr/local/shotgun/shotgunEvents`

#### Extracting the archive into `/usr/local/shotgun`.

For .tar.gz archives:

```
$ tar -zxvf shotgunsoftware-shotgunEvents-v0.9-12-g1c0c3eb.tar.gz -C /usr/local/shotgun
```

For .zip archives:

```
$ unzip shotgunsoftware-shotgunEvents-v0.9-12-g1c0c3eb.zip -d /usr/local/shotgun
```

Then you can rename the GitHub-assigned directory name to `shotgunEvents`:

```
$ mv shotgunsoftware-shotgunEvents-1c0c3eb shotgunEvents
```

Now you should now have something like this:

```
$ ls -l /usr/local/shotgun/shotgunEvents
total 16
-rw-r--r--  1 kp  wheel  1127 Sep  1 17:46 LICENSE
-rw-r--r--  1 kp  wheel   268 Sep  1 17:46 README.mkd
drwxr-xr-x  9 kp  wheel   306 Sep  1 17:46 docs
drwxr-xr-x  6 kp  wheel   204 Sep  1 17:46 src
```

<a id="Installing Requirements"></a>
### Installing Requirements

A `requirements.txt` file is provided at the root of the repository. You should use this to install the required packages

```
$ pip install -r /path/to/requirements.txt
```


<a id="Windows_Specifics"></a>
### Windows specifics

You will need one of the following on your Windows system:

* Python with [PyWin32](http://sourceforge.net/projects/pywin32/) installed
* [Active Python](http://www.activestate.com/activepython)

Active Python ships with the PyWin32 module which is required for integrating the {% include product %} Event Daemon with Windows' Service architecture.

You can then install the deamon as a service by running the following command (we are assuming that `C:\Python27_32\python.exe` is the path to your Python executable, adjust accrodingly):

```
> C:\Python27_32\python.exe shotgunEventDaemon.py install
```

Or remove it with:

```
> C:\Python27_32\python.exe shotgunEventDaemon.py remove
```

Starting and stopping the service can be achieved through the normal service management tools or via the command line with:

```
> C:\Python27_32\python.exe shotgunEventDaemon.py start
> C:\Python27_32\python.exe shotgunEventDaemon.py stop
```

In most cases you will need to be sure you are running each of the commands listed as your system's administrative user. You can do so by right clicking the cmd application and choosing "Run as Administrator".

{% include info title="Note" content="If you have installed the daemon on Windows in a network location or if you have configured it to read and write logs and other resources from a network location you will need to edit the service's properties to change the user running the service from the local machine account to a domain account that has access to the network resources." %}
