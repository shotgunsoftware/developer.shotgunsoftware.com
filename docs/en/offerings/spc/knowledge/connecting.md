---
layout: default
title: Connecting Your Studio With Your AWS VPC
pagename: spc-knowledge-connecting
lang: en
---

# Connecting Your Studio With Your AWS VPC

Clients can connect their studio networks with AWS using in one of many ways, described in detail in [Amazon Virtual Private Cloud Connectivity Options](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/network-to-amazon-vpc-connectivity-options.html) whitepaper.

Some of the common options our clients have used include

## VPN Connection

Using a VPN appliance - AWS managed or client managed - a client studio can establish a secure connection between their data center, or offices to their AWS private VPC.


## AWS Direct Connect

[AWS Direct Connect](./direct_connect.md), creates a dedicated link between a client studio and the client's AWS VPC. This will help segregate the client studio's network traffic to their private AWS VPC from general internet traffic.

