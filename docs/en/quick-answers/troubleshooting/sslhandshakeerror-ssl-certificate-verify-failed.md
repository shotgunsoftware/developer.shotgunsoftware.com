---
layout: default
title: SSLHandshakeError CERTIFICATE_VERIFY_FAILED certificate verify failed
pagename: sslhandshakeerror-ssl-certificate-verify-failed
lang: en
---

# SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed

## Use case

On a local network set up with a firewall that does local packet inspection, you can get the following error message: 

```
SSLHandshakeError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:727)
```

This is because these firewalls are often configured with a self-signed certificate that your network administrator created themselves and that Python does not have access to. Unfortunately, unlike other applications, Python does not always look inside the OS’s keychain for certificates, so you have to provide it yourself.

## How to fix

You need to set the `SHOTGUN_API_CACERTS` environment variable to point to a file on disk that contains the complete list of certificate authorities the Python API and Shotgun Desktop can trust.

You can download such a [copy](https://github.com/certifi/python-certifi/blob/master/certifi/cacert.pem) from the latest copy of the `certifi` package on Github. Once you've done this, you need to add the public key of your corporate firewall at the bottom of that file and save it.

Once this is done, simply set `SHOTGUN_API_CACERTS` environment variable to the path location, e.g. `/opt/certs/cacert.pem` and launch the Shotgun Desktop.

## Related links

[See the full thread in the community](https://community.shotgridsoftware.com/t/using-shotgun-desktop-behind-an-firewall-with-ssl-introspection/11434)