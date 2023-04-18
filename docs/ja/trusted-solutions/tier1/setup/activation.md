---
layout: default
title: Activation
pagename: tier1-setup-activation
lang: ja
---

# Activation

Once everything is configured and properly tested, it's now time to migrate your production site to use the isolation features.

## Test

Navigate to the /admin/speedtest route of your {% include product %} site. Select the new S3_CONFIG_NAME that was just set up previously and start the test to confirm that all the upload/download tests work as intended.

## Switch to your own Isolation S3 Bucket

Navigate to the Advanced section of Site Preferences page and set the storage location to your own S3 bucket.
