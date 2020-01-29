---
layout: default
title: Planning Your Setup
pagename: spc-getting_started-planning
lang: en
---

# Planning Your Setup

## Initial Steps

* Choose your AWS Region for your VPC and S3 bucket
* Plan the VPC IP ranges
* Plan how you will access your AWS VPC
  * AWS Direct Connect
  * Other VPN solution

## IP Range Example

| Region | VPC | Subnet 1 | Subnet 2 | Subnet 3 | 
|--------|-----|----------|----------|----------|
| us-east-1 | 10.0.0.0/16 | us-east-1a<br>10.0.0.0/24 | us-east-1b<br>10.0.1.0/24 | us-east-1c<br>10.0.2.0/24 |
| ap-southeast-2 | 10.1.0.0/16 | 10.1.0.0/24 | 10.1.1.0/24 | 10.1.2.0/24 |