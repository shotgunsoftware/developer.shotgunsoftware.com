---
layout: default
title: Web Traffic Segregation
pagename: spc-setup-traffic_segregation
lang: en
---

# Web Traffic Segregation

The goal is to setup an AWS Private link to privately access Shotgun site.

## Setup a VPC with in us-east-1 AWS region if needed

Using the AWS Console:

* Create your VPC

![Create VPC](../images/spc-vpc-create.png)

* Create your private subnets

![Create subnets](../images/spc-subnet-create.png)

## Setup Private Link to Shotgun

* Add a new VPC Endpoint in your us-east-1 VPC

* The service name is `com.amazonaws.vpce.us-east-1.vpce-svc-001d9eddae4b841b8`

* For the security group, Shotgun only requires the inbound port tcp/443 to be open

* Please contact Shotgun Support to get the endpoint approved so you can start using it

![Create endpoint](../images/spc-endpoint-create_privatelink.png)