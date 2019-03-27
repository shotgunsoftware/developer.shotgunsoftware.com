---
layout: default
title: Command Line Parameters
permalink: /rv/tweak-license-server/06-command-line-parameters/
lang: en
---

# Command Line Parameters

| | |
|-|-|
| **-f** | The path to the local license file. This can be relative to the Tweak License Server install directory, but an absolute path is safest. |
| **-log** | The path to the License Server log file. The license server can maintain a log of all its activity. Passing a filename to this parameter allows the information to be stored locally on the host machine. If no `-log` option is specified, the server prints to the standard output. |
| **-fg** | Runs the server in the foreground. If this parameter is not specified the server runs as a daemon or service. |
| **-s** | Shows the status of a currently running server. Lists the version/compile information for the running server, and lists each user who currently has a license checked out. To get the status from a remote machine You need to supply `-h` and `-p` options. The process will contact the other server and get a list of the available licenses and who is currently using them. Status information also contains expiration date and maintenance expiration date for licenses that have them. |
| **-q** | Contacts a running license server and requests it to shutdown. To shut down a remote server, you need to supply `-h` and `-p` options with the `-q` option. |
| **-h** | Specifies the host where the server will be run from. This defaults to localhost, and will only change in rare occasions. Also used with `-s` and `-q` options to contact a remote server. |
| **-p** | Specifies the port on which the local server will listen for incoming license requests. This defaults to port 5436. This is required with the `-s` and `-q` options. **Note** that on Windows the port can only be 5436. |
| **-help** | Prints out command line help. |
| **-version** | Show version. |
