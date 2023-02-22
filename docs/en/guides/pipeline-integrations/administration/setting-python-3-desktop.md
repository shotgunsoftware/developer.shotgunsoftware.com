---
layout: default
title: Setting Python 2 for Desktop
pagename: setting-python-3-desktop
lang: en
---

# Set Python 2 as the default Python version in {% include product %} Desktop

{% include info title="Warning" content="**This topic is only valid when using ShotGrid Desktop version 1.7.3**—these steps are no longer needed when using newer versions of ShotGrid Desktop. Python 2 was removed January 26, 2023 with the release of ShotGrid Desktop 1.8.0 due to security reasons. [Learn more here](https://community.shotgridsoftware.com/t/important-notice-upcoming-removal-of-python-2-7-and-3-7-interpreter-in-shotgrid-desktop/15166)." %}

- [Windows](#windows)
- [MacOS](#macos)
- [CentOS 7](#centos-7)

## Windows

### Manually Set the `SHOTGUN_PYTHON_VERSION` environment to 2 on Windows

- On the Windows taskbar, right-click the Windows icon and select **System**, navigate through the **Control Panel/System and Security/System**. 

![](images/setting-python-3-desktop/01-setting-python-3-desktop.png)

- Once there, select **Advanced system settings**.

![](images/setting-python-3-desktop/02-setting-python-3-desktop.png)

- Next, select **Environment Variables** in System Properties.

![](images/setting-python-3-desktop/03-setting-python-3-desktop.jpg)

- In the **Environment Variables** window, you can add/edit your paths by selecting **New...**. 

![](images/setting-python-3-desktop/04-setting-python-3-desktop.jpg)

- For the **Variable name**, add `SHOTGUN_PYTHON_VERSION`, and set the **Variable value** to `2`. 

![](images/setting-python-3-desktop/05-setting-python-3-desktop.jpg)

- Restart the {% include product %} Desktop application. Now, you should see that the Python version has been updated to run Python 2. 

![](images/setting-python-3-desktop/06-setting-python-3-desktop.jpg)


## MacOS

### Set the `SHOTGUN_PYTHON_VERSION` environment to 2 on MacOS

- Create a properties file under `~/Library/LaunchAgents/` named `my.startup.plist`  

```
$ vi my.startup.plist
```

- Add the following to `my.startup.plist` and **save**:

```
<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"> 
<plist version="1.0"> 
<dict> 
  <key>Label</key> 
  <string>my.startup</string> 
  <key>ProgramArguments</key> 
  <array> 
    <string>sh</string> 
    <string>-c</string> 
    <string>launchctl setenv SHOTGUN_PYTHON_VERSION 2</string> 
  </array> 
  <key>RunAtLoad</key> 
  <true/> 
</dict> 
</plist>
```

- After rebooting your Mac, the new environment variable will remain active.

- Restart the {% include product %} Desktop application. Now, you should see that the Python version has been updated to run Python 2. 

![](images/setting-python-3-desktop/07-setting-python-3-desktop.jpg)

## CentOS 7

### Set the `SHOTGUN_PYTHON_VERSION` environment to 2 on CentOS 7

- Add the following to your `~/.bashrc` file: 

```
export SHOTGUN_PYTHON_VERSION="2"
```

- Reboot your OS by running:  

```
$ sudo reboot 
```

- Restart the {% include product %} Desktop application. Now, you should see that the Python version has been updated to run Python 2. 

![](images/setting-python-3-desktop/08-setting-python-3-desktop.jpg)
