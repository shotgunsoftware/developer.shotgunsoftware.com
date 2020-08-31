---
layout: default
title: S3 Replication
pagename: spc-setup-s3_replication
lang: en
---

# Shotgun S3 Replication Support (BETA)

## Description

It's possible to add S3 replication between two S3 buckets in different regions and configure Shotgun to leverage it for faster access to media.

![S3 Replication Diagram](../images/spc-s3-replication.png)

## Features

 * Support one replica bucket in another region leveraging the [AWS S3 replication feature](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html).
 * A preference at the individual Shotgun user level can be configured to use the primary or replica bucket

## How it works

When S3 bucket replication is activated, users download media files from the replica S3 bucket.

## Limitations

 * A maximum of one replica S3 bucket can be configured
 * Only downloading from the replica bucket is supported
 * Configurable delay for new media to populate in the replica bucket before being made available to users

# Setup steps

  * Create the replica S3 bucket in a new AWS region. See [Private S3 Bucket](../s3_bucket.md)
  * Update your existing Shotgun role policy to allow Shotgun to also access the replica bucket
  * Setup the replication rules on the primary S3 bucket. See [How do I add a replication rule to an S3 bucket?](https://docs.aws.amazon.com/AmazonS3/latest/user-guide/enable-replication.html#enable-replication-add-rule)
  * Setup a VPC + Direct Connect + S3 proxy in the new AWS region. See [Media Segregation](../media_segregation.md)
  * Contact Shotgun Support to configure your site to use the new S3 replica bucket, providing the following information:
    * Replica Bucket Name
    * Replica Bucket Region
    * Replica S3 proxy URL

# FAQ

## Copy existing media

S3 replication only applies to media uploaded after the feature has been enabled. Existing media in the primary bucket must be copied to the replica bucket manually. You can simply use `aws-cli` sync or use [Amazon S3 Batch Operations](https://aws.amazon.com/s3/features/batch-operations/) if you have a lot of media to achieve this.
