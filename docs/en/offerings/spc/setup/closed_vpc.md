---
layout: default
title: Closed VPC
pagename: spc-setup-closed_vpc
lang: en
---

# Closed VPC

{% include info title="Disclaimer" content="This documentation is provided as an example. It explains how to setup your Shotgun Tier 1 environment so it can be connected to Shotgun Tier 1 infrastructure. Please adapt it to you studio security requirements. As Shotgun as no visibility on your AWS Account. Making sure that this account is secure is the client responsibility." %}

## Setup a VPC with private subnets in the your S3 bucket AWS region

Using the AWS Console:

* Create your VPC

![Create VPC](../images/spc-vpc-create.png)

* Create your private subnets

![Create subnets](../images/spc-subnet-create.png)

## Setup access from your site network to your AWS VPC

Options provided by AWS:
* [AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html)
* [AWS Direct Connect](https://aws.amazon.com/directconnect/)

{% include info title="Note" content="If Direct Connect is chosen, we recommend to test with a simpler/faster solution first to validate the setup, then to replace the solution with Direct Connect when the setup is completed." %}