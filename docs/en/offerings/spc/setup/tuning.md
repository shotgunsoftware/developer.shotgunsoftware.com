---
layout: default
title: Fine Tuning
pagename: spc-setup-tuning
lang: en
---

# Fine Tuning

## Cost Management Recommendations

### S3 Infrequent Access

We recommend enabling S3 Infrequent access to reduce easily reduce costs without impacting performance. For the Shotgun Cloud hosted offering, we apply a policy for all objects older than a month.

With Infrequent Access, objects are stored at lower cost, but if they are accessed, it involves an additional cost. Shotgun has observed that one month was the right policy to use globally, but you may want to adapt that policy to your studio workflows.

Read more about S3 Infrequent Access and other storage classes [here](https://aws.amazon.com/s3/storage-classes/).

## S3 Endpoint policy

We recommend you set a VPC endpoint policy on your S3 endpoint to allow access to your S3 bucket only. See [here](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints-s3.html#vpc-endpoints-policies-s3) for an example.
