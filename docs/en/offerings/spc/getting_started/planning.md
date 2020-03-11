---
layout: default
title: Planning Your Setup
pagename: spc-getting_started-planning
lang: en
---

# Planning Your Setup

![Architecture](../images/spc-arch-setup.png)

## Pick your options

Pick which Shotgun Private Cloud options you want to implement:
  * Private S3 Bucket
  * Media Segregation
  * Traffic Segregation

## Choose an AWS Region

Choose an AWS Region for your AWS S3 bucket and VPC. We recommend us-east-1 if possible, as traffic segregation will be easier.

## Plan the VPC IP ranges

Plan the AWS VPC subnets' IP ranges.

### IP Range Example

| Region | VPC | Subnet 1 | Subnet 2 | Subnet 3 | 
|--------|-----|----------|----------|----------|
| us-east-1 | 10.0.0.0/16 | us-east-1a<br>10.0.0.0/24 | us-east-1b<br>10.0.1.0/24 | us-east-1c<br>10.0.2.0/24 |
| ap-southeast-2 | 10.1.0.0/16 | 10.1.0.0/24 | 10.1.1.0/24 | 10.1.2.0/24 |


### Plan how you will privately access your AWS VPC

  * AWS Direct Connect
  * Other VPN solution
