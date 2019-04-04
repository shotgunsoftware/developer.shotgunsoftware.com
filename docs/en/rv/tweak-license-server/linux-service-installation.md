---
layout: default
title: Linux Service Installation
permalink: /rv/tweak-license-server/linux-service-installation/
lang: en
---

# Linux Service Installation

**Note:** The `service` command mentioned below is common on linux dists derived from RedHat or Fedora, like CentOS. On others, such as Debian or Ubuntu, you may need to install the `sysvconfig` package.

1. Edit/Review the installation script (`install_tlmserver`). The installation should be edited (or just checked) to make sure it makes sense with your Linux system. By default it will install a script that calls the license server binary as a system service. If you did not install the package in `/usr/local/tweak` you will need to change the variables at the top of the file.
2. Edit/Review the `start_tlmserver_init.sh` script. Check the command line parameters below and make sure the start script is pointing at the correct place for the license file (for example). **Note** that if you rename this script when you install it in the init directory, be sure that the string “tlm_server” is not in the name, since tlm_server will refuse to run if there is any other process running with “tlm_server” in the name.
3. Run the installer script (or install by hand). The script should be run from the directory it lives in.
4. Start the Server. Use the service command to start the Server like this: “service start_tlmserver start”, or “/etc/init.d/start_tlmserver start” if you’re not using the service interface.
5. On reboot the server should start automatically.

We test our license server internally on Ubuntu 8.04. tlm_server may run on other flavors of Linux. If you are not running a Debian or Red Hat derived distribution, we can work with you to get it installed.

## Network Timeouts on Linux

If RV exits for any reason, the licenses should be released immediately. If the server looses contact with machine running RV (for example, if network service to that machine is interrupted), the connection will time out and the the license will be released in 2-3 minutes.
