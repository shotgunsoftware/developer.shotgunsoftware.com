---
layout: default
title: S3 Replication
pagename: spc-setup-s3_replication
lang: en
---

# Shotgun S3 Replication Support (BETA)

## Description

It's possible to add S3 replication between 2 S3 buckets in different regions and configure Shotgun to leverage it for faster access to media.

## Features

 * Support one replica bucket in another region leveraging S3 replication feature. https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html
 * Each human User can be configured to use the replica bucket and get faster download.

## How it work

Human users with use replicate S3 bucket activated download all media files from the replica S3 bucket faster.

## Limitations

 * Only download are supported.
 * Wait a configurable delay for new files before using the replica S3 bucket.

# Setup steps

  * Create the replica S3 bucket in a new AWS region.
  * Update your shotgun role policy to allow Shotgun to access the replicaa bucket.
  * Setup the replication rules on the primary S3 bucket.
  * Setup a VPC + Direct Connect + S3 proxy in the new AWS region.
  * Contact Shotgun support to configure your site to use the new S3 replica bucket.
    * Replica Bucket Name
    * Replica Bucket Region
    * Replica S3 proxy URL