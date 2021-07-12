---
layout: default
title: ShotGrid Desktop / browser integration fails to launch on Linux
pagename: browser-integration-fails-linux
lang: en
---

# {% include product %} Desktop / browser integration fails to launch on Linux

When running the {% include product %} Desktop on Linux for the first time, you may experience one of these error messages. If so, please follow the steps below for your specific error to see if that resolves things.
If you're still stuck, please visit our [support site](https://knowledge.autodesk.com/contact-support) for help.

###Contents

- [OPENSSL_1.0.1_EC or HTTPSConnection related issues](#openssl_101_ec-or-httpsconnection-related-issues)
- [libffi.so.5 related issues](#libffiso5-related-issues)
- [Certificate validation failed related issues](#certificate-validation-failed-related-issues)
- [Incompatible Qt versions](#incompatible-qt-versions)

## OPENSSL_1.0.1_EC or HTTPSConnection related issues

**Errors**

```
importing '/opt/Shotgun/Resources/Python/tk-framework-desktopstartup/python/server/resources/python/dist/linux/cryptography/_Cryptography_cffi_36a40ff0x2bad1bae.so':
 /opt/Shotgun/Resources/Python/tk-framework-desktopstartup/python/server/resources/python/dist/linux/cryptography/_Cryptography_cffi_36a40ff0x2bad1bae.so: symbol ECDSA_OpenSSL, version OPENSSL_1.0.1_EC not defined in file libcrypto.so.10 with link time reference
AttributeError: 'module' object has no attribute 'HTTPSConnection'
```

**Solution**

You need to install OpenSSL. To do so, run the following command as an administrator:

```
$ yum install openssl
```

## libffi.so.5 related issues

**Error**

```
Browser Integration failed to start. It will not be available if you continue.
libffi.so.5: cannot open shared object file: No such file or directory
```

**Solution**

You need to install libffi. To do so, run the following command as an administrator:

```
yum install libffi
```

If you've installed libffi and it still doesn't work, try creating the following symlink and then re-launching the {% include product %} Desktop:

```
sudo ln -s /usr/lib64/libffi.so.6.0.1 /usr/lib64/libffi.so.5
```

Some users have reported success with the above. Others still have issues. The latest version of {% include product %} Desktop added some additional dependencies with the web socket server which we're currently looking into.

## Certificate validation failed related issues

**Possible errors**

```
Browser Integration failed to start. It will not be available if you continue.
Error: There was a problem validating if the certificate was installed.
certutil: function failed: SEC_ERROR_BAD_DATABASE: security library: bad database.
```

**Solution**

If you have Google Chrome installed on your computer, launch it and then relaunch the {% include product %} Desktop. If you still have the issue, please visit our [support site](https://knowledge.autodesk.com/contact-support) for help.

If you don't have Chrome, open a terminal and run the following command:

```
ls -al $HOME/.pki/nssdb
```

If that search does not come up empty, please contact support and attach the contents of the following log file to your ticket:

```
~/.shotgun/logs/tk-desktop.log
```

If the search did come up empty, then type the following:

```
$ mkdir --parents ~/.pki/nssdb
$ certutil -N -d "sql:$HOME/.pki/nssdb"
```

Do not enter any password.

Launching the {% include product %} Desktop should now work correctly.

## Incompatible Qt versions

**Possible errors**

Cannot mix incompatible Qt library (version `0x40805`) with this library (version `0x40807`)

**Solution**

Often this comes up because there is an override happening that ends up loading incompatible Qt libraries.
You can try modifying your environment with this command to keep that from happening:

```
unset QT_PLUGIN_PATH
```
