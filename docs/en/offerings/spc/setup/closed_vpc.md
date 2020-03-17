---
layout: default
title: Closed VPC
pagename: spc-setup-closed_vpc
lang: en
---

# Closed VPC

{% include info title="Disclaimer" content="This documentation is provided solely as an example. It explains how to set up your Shotgun Private Cloud environment so that it can be connected to Shotgun Private Cloud infrastructure. Please adapt it to your studio security requirements as needed. As Shotgun has no visibility on your AWS Account, ensuring that this account is secure is a client responsibility." %}


## Set up a VPC with private subnets in your S3 bucket AWS region

You will need to deploy a private VPC with the required VPC endpoints. We provide a [private VPC CloudFormation template](https://sg-shotgunsoftware.s3-us-west-2.amazonaws.com/tier1/cloudformation_templates/sg-private-vpc.yml) as a starting point. The template creates a VPC with 2 private subnets and the required VPC endpoints.

## Set up access from your site network to your AWS VPC

Options provided by AWS:
* [AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html)
* [AWS Direct Connect](https://aws.amazon.com/directconnect/)

{% include info title="Note" content="If Direct Connect is chosen, we recommend testing it with a simpler/faster solution first to validate the setup. You can then replace that solution with Direct Connect once the setup is complete." %}
