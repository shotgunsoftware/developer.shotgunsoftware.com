---
layout: default
title: Media Segregation
pagename: spc-setup-media_segregation
lang: en
---

# Media Segregation

The media segregation allows your users to access your media in your AWS S3 bucket privatly (not transiting on the public internet). 

## Add an S3 endpoint to your VPC

![Add endpoint](../images/spc-endpoint-create-1.png)
![Add endpoint](../images/spc-endpoint-create-2.png)
![Add endpoint](../images/spc-endpoint-create-3.png)

## Setup S3 proxy

An S3 proxy is needed in your VPC to proxy the traffic from your network into the S3 VPC endpoint. See [here](https://github.com/shotgunsoftware/s3-proxy-example) for an example Docker image that could be run in your AWS account using AWS ECS runnin with AWS Fargate.