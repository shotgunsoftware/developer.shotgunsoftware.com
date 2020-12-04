---
layout: default
title: Media Isolation
pagename: tier1-features-media-isolation
lang: en
---

# Media Isolation
Media Isolation allows your studio to keep the ownership and control of the media and attachments that you upload to Shotgun. With Media Isolation, all the content that you upload to Shotgun can be stored in your studio private S3 Bucket. Access to the media is provided to the Shotgun services only, using [AWS AssumeRole keyless Security Token Service](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html).

<img alt="media-isolation-overview" src="../images/media-isolation-overview.png" width="400">

## Client Owned S3 Bucket
Storing media and attachments in a S3 bucket you own allow you to remain the legal owner of these artifacts, allowing you to comply with your security and legal intermal policies. Your studio remains in control of the assets and the access to the assets, access that you can revoke at will.

<img alt="media-isolation-arch" src="../images/media-isolation-arch.png" width="400">

## More about Access
When using Shotgun, media is downloaded and uploaded from/to S3, without transitting through Shotgun infrastructure. Shotgun will only get access to the media in two circonstances.
1. The Shotgun Transcoding service will get read/write access once, soon after upload, when transcoding the media. See [Ephemeral Transcoding](../getting_started/about.md#ephemeral-transcoding) for details.
2. When the Shotgun service generates S3 Links to your sources and transcoded media.

This is rendered possible by leveraging [AWS AssumeRole keyless Security Token Service](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html). When setting up Media Isolation, an AWS Role allowing Shotgun to access your media for the action listed above is created, and the Shotgun service is allowed to assume that role.

Shotgun Support staff doesn't have access to the S3 Bucket under any circonstances.

## Costs
When activating Media Isolation, the following costs, usually covered by Autodesk, becomes the responsibility of the client.
1. **S3 Costs.** All the S3 storage costs will be assumed by the customer. See [Media Isolation](../setup/tuning.md) for more details about how to reduce costs.
2. **S3 Bandwidth.** Bandwidth out of the S3 bucket will be assumed by the customer.

## What Media Isolation is not providing
Activating media isolation doesn't guarantee that the access to your site or media is done in closed network. 