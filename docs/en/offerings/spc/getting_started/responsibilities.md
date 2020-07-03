---
layout: default
title: Client Responsibilities for Shotgun Private Cloud
pagename: spc-getting_started-responsibilities
lang: en
---
  
# Client Responsibilities

Below, we have outlined setup responsibilities between Shotgun and You. 

## Shotgun Private Cloud Setup

You are entirely responsible for the validity, security, and execution of the Shotgun Private Cloud setup in Your AWS Account. Shotgun should not, under any circumstances, be granted access to Your AWS environment.
 
Shotgun is available during the process for assistance, but the configuration of Shotgun Private Cloud in Your AWS Account is to be executed by You on Your own.

You understand that an estimated period of 2-6 weeks is usually required to set up a Shotgun Private Cloud site. Autodesk does not guarantee on any timeline of setup completion.  

## Shotgun Private Cloud Onboarding

|Type|	Description / Agreement |	Responsibility	| Available for Assistance|
|--------|-----|----------|---------|
|AWS Knowledge	|	Acquiring the AWS-specific knowledge required to set up a Shotgun Private Cloud site.	|You	|N/A|
|S3|Setting up the S3 Bucket that will host Your media Securing access to the S3 Bucket. Additional high-availability measures (versioning, bucket replication, etc.)	|You	|Shotgun and *AWS|
|Closed VPC	|Setting up DirectConnect/VPN, etc. to allow closed access to the VPC. Securing the VPC by putting the correct Security Groups in place.	|You	|*AWS |
|Media Segregation	|Creating the S3 end-points. Deploying the S3 Proxy.	|You|	Shotgun and *AWS |
|Web Traffic Segregation	|Creating VPCs. Creating Subnets.|	You|Shotgun|
|Private Access Point|Checking that the access point is only available from Your network.|	Shotgun|	N/A|
|Monitoring and Reliability|Maintaining uptime up to Autodesk standards. High availability and redundancy of Cloud Services. Metadata and database resiliency and redundancy. Maintaining Recovery Point Objective (RPO) for metadata and database.	|Shotgun|N/A|
|Service Level Objective|Maintaining Shotgun target RPO and RTO (See [Shotgun Security White Paper](https://support.shotgunsoftware.com/hc/en-us/articles/114094526153-Shotgun-security-white-paper) for more details).|Shotgun|	N/A|
|Security and Governance |Maintaining the Shotgun Cloud Services that Shotgun Private Cloud clients are interfacing with, so that they are meeting expectations in terms of security, vulnerability patching, scanning, auditing, etc. (See Shotgun Security White Paper for more details)|	Shotgun	|N/A|

*You are solely responsible to seek or obtain any support services AWS may provide under any existing relationship between You and AWS. Autodesk and Shotgun team are not parties to Your relationship with AWS and therefore not responsible or liable for any services or lack thereof provided by AWS to You. 
