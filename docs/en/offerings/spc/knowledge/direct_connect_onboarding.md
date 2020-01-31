---
layout: default
title: Shotgun AWS Direct Connect Onboarding
pagename: spc-knowledge-direct_connect_onboarding
---

# Shotgun AWS Direct Connect Onboarding


## Introduction

AWS Direct Connect (DX) is used to establish private connectivity between AWS and an on-prem facility. DX provides a private, high bandwidth network connection between your network and AWS Virtual Private Cloud (VPC) and bypasses the public Internet. AWS has established 100 Direct Connect locations globally and leverages the AWS Partner Network to extend the footprint. 

## Review of Shogun Configuration in AWS

![high-level-architecture](../images/spc-arch-s3_ue1.png)

## Customer Types

1. Customer already has AWS Direct Connect Dedicated Connection
2. Customer has equipment and network presence in an AWS Direct Connect location
3. Customer does not have equipment or presence in an AWS Direct Connect location


## Set-Up Options

1. Request a Dedicated Direct Connect Connection through AWS Console
    1.  Provision required connectivity yourself
    1. Work with Direct Connect Partner to help with establishing a Dedicated Connection to AWS equipment
2. Request a Hosted Direct Connect Connection through AWS Direct Connect Partner


## Criteria to Determine Set-Up Path 

If you answer “yes” to the following, then request Dedicated Direct Connect Connection through the AWS Console (Option 1a).

- Do you already have equipment and presence in an AWS Direct Connect Location?
- Do you know the process for requesting a cross connect within the Direct Connect Location facility?
- Are you looking for any one of the following? 1Gbps, 10Gbps port, or a dedicated connection

If you answer “yes” to the following, then request Dedicated Direct Connect Connection through the AWS Console and select a Partner to assist (Option 1b).

- Are you planning to use AWS Direct Connect to connect to other AWS resources outside of Shotgun?
- Do you have the time and resources to complete the setup?
- Are you looking for any one of the following? 1Gbps, 10Gbps port, or a dedicated connection

If you answer “yes” to the following then you should work with an AWS Direct Connect Partner to request a Hosted Direct Connect Connection (Option 2)

- Are you already working with an AWS Direct Connect Partner?
- Do you want a partner to facilitate the setup?
- Are you looking for a port less than 1Gbps or a hosted connection?
***Disclaimer:***  *All options are valid and the criteria are just a guidance to simplify the selection process. Customers can still pick any option based on more specific criteria.*

## Set-Up Directions

### Request through AWS Console - Option 1
1. [Create a Connection in the AWS Console](https://docs.aws.amazon.com/directconnect/latest/UserGuide/getting_started.html#ConnectionRequest)
1. [Download the LOA-CFA](https://docs.aws.amazon.com/directconnect/latest/UserGuide/getting_started.html#DedicatedConnection). The LOA is the authorization to connect to AWS and required to establish the cross-network connection.
1. (Option 1a) Request Cross Connects at AWS Direct Connect Locations. Find contact information [here](https://docs.aws.amazon.com/directconnect/latest/UserGuide/Colocation.html).
1. (Option 1b) [Reach out to an AWS Partner](https://aws.amazon.com/directconnect/partners/) and share the LOA with them.
1. Once the dedicated connection is provisioned into your account setup logical connectivity (Virtual Interfaces)

### Request through AWS Direct Connect Partner - Option 2

1. [Reach out to an AWS Partner](https://aws.amazon.com/directconnect/partners/). The criteria for choosing an AWS Partner are:
    - AWS Region
    - Providers
    - If you are already working with an AWS Direct Connect Partner
2. If hosted connection, [accept a Hosted Connection](https://docs.aws.amazon.com/directconnect/latest/UserGuide/getting_started.html#ConnectionRequest). More information can be found [here](https://docs.aws.amazon.com/directconnect/latest/UserGuide/accept-hosted-connection.html).
3. Once the hosted connection is provisioned into your account setup logical connectivity (Virtual Interfaces)

## FAQ

**How long should it take to set up AWS Direct Connect?**

Short Answer - It depends. A lot of factors go into the time it takes so set up AWS Direct Connect. The timeline can range from a few days to a few months. Some of the factors include current infrastructure, location of equipment, providers, partners and more. If you are looking to expedite the process, consider using an AWS Direct Connect Partner who is geographically nearby.

**Further questions about AWS Direct Connect?**

[AWS Direct Connect FAQs](https://aws.amazon.com/directconnect/faqs/?nc=sn&loc=6)



## VPN

A site-to-site VPN can be used as an alternative to AWS Direct Connect. Learn more about [AWS VPN here](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html).

## AWS Documentation & Resources

- [What is AWS Direct Connect?](https://www.youtube.com/watch?v=eNxPhHTN8gY&feature=youtu.be&t=716)
- [Direct Connect User Guide](https://docs.aws.amazon.com/directconnect/latest/UserGuide/dc-ug.pdf)
- [re:Invent 2018 - 400 level Deep Dive on Direct Connect](https://www.youtube.com/watch?v=DXFooR95BYc)
- [AWS Direct Connect Locations](https://aws.amazon.com/directconnect/features/#AWS_Direct_Connect_Locations)
- [AWS Direct Connect Partners](https://aws.amazon.com/directconnect/partners/)