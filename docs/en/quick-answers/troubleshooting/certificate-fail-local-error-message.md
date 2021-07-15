---
layout: default
title: Getting CERTIFICATE_VERIFY_FAILED when using {% include product %} Desktop on a local {% include product %} site
pagename: certificate-fail-local-error-message
lang: en
---

# Getting CERTIFICATE_VERIFY_FAILED when using {% include product %} Desktop on a local {% include product %} site

## Use cases:
When using a local install of {% include product %}, this error can arise in two scenarios:

- when logging in {% include product %} Desktop
- when downloading media from the Toolkit AppStore

## How to fix:
To solve this issue, need to provide a file to the {% include product %} API that contains the list of all valid CAs, including your own. We usually recommend that people download a fresh copy of [this file](https://github.com/certifi/python-certifi/blob/master/certifi/cacert.pem) from Python's `certifi` package as a starting point and then add their own CA at the end of the file. Then, save that file in a location all your users can access. Finally, on each computer, set the `SHOTGUN_API_CACERTS` environment variable to the full path to that file, for example `/path/to/my/ca/file.pem`.

Doing this should solve any `CERTIFICATE_VERIFY_FAILED` errors you are getting with your local site. Note that if you are able to connect to your {% include product %} site, but are still unable to download updates from the Toolkit AppStore, that's likely because you are missing the Amazon CAs in your `.pem` file. This usually happens if you've started from an empty file and only added your custom CAs instead of starting from something like the file we've linked to above.

Note that this information *only* applies to local installs. If you have a hosted site and are experiencing this error, if it's happening on Windows, take a look at [this forum post](https://community.shotgridsoftware.com/t/certificate-verify-failed-error-on-windows/8860). If it's happening on a different OS, take a look at [this document](https://developer.shotgridsoftware.com/c593f0aa/).

## Example of what's causing this error: 
This problem usually arises because you’ve configured your local site to use HTTPS, but you haven’t configured Toolkit so that the certificate authority (known as CA from here on out) that you’ve used to sign your local site’s certificate is recognized.

[See the full thread in the community](https://community.shotgridsoftware.com/t/getting-certificate-verify-failed-when-using-shotgun-desktop-on-a-local-shotgun-site/10466).

