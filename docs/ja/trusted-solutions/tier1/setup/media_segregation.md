---
layout: default
title: Media Traffic Isolation
pagename: tier1-setup-media_segregation
lang: ja
---

# Media Traffic Isolation using AWS PrivateLink for Amazon S3

{% include info title="Disclaimer" content="This documentation is provided solely as an example. It explains how to set up your ShotGrid Isolation environment so that it can be connected to ShotGrid cloud infrastructure. Please adapt it to your studio security requirements as needed. As ShotGrid has no visibility on your AWS Account, ensuring that this account is secure is a client responsibility." %}

The media traffic isolation feature allows your users to access media in your AWS S3 bucket privately (not transiting over the public Internet). Please note that if you have a multi-region setup and that leverages the {% include product %} Transcoding service there may still be instances where media transits across the public Internet. Reach out to our support team for more details.

Media Isolation activation is a pre-requisite to enable this feature. If you haven't done so already, see [Media Isolation](./s3_bucket.md).

## Set up a VPC in your S3 bucket AWS region

You will need to deploy a VPC with the required VPC endpoint. We provide a [private VPC](https://sg-shotgunsoftware.s3-us-west-2.amazonaws.com/tier1/cloudformation_templates/sg-private-vpc-s3-privatelink.yml) CloudFormation templates as starting points. This template create the necessary VPC, subnets and VPC endpoint.

* Create a [new CloudFormation stack](https://console.aws.amazon.com/cloudformation/home?#/stacks/create/template)
* Select Template is ready
* Set Amazon S3 URL to [`https://sg-shotgunsoftware.s3-us-west-2.amazonaws.com/tier1/cloudformation_templates/sg-private-vpc-s3-privatelink.yml`](https://sg-shotgunsoftware.s3-us-west-2.amazonaws.com/tier1/cloudformation_templates/sg-private-vpc-s3-privatelink.yml)
* Click Next
* Set a stack name. Eg. `{% include product %}-vpc`
* Choose network ranges that doesn't conflict with your studio network and set subnet CIDR values accordingly
* Set your S3 bucket name
* Click Next
* Click Next

## Set up access from your site network to your AWS VPC

Options provided by AWS:
* [AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html)
* [AWS Direct Connect](https://aws.amazon.com/directconnect/)

{% include info title="Note" content="If Direct Connect is chosen, we recommend testing with a simpler / faster solution in the meantime to validate your Isolation setup. You can then replace that solution with Direct Connect once it is available." %}

## Add an S3 endpoint to your VPC

{% include info title="Note" content="This step should only be performed if the CloudFormation template was *not* used." %}

Simply add an `com.amazonaws.us-west-2.s3` Interface VPC Endpoint to your existing VPC. Make sure the associated security group allow traffic from your site network.

### Add the VPC to your S3 bucket policy

In order for the S3 VPC endpoint to communicate with your S3 bucket your bucket policy must allow access from the S3 endpoint's VPC. You can find instructions on how to configure the policy in the [Fine Tuning](./tuning.md#s3-bucket-policy) step.

## Validation

### Test the S3 VPC endpoint

Use the endpoint URL to list objects in your bucket using AWS CLI. In the following example, replace the VPC endpoint ID `vpce-1a2b3c4d-5e6f.s3.us-east-1.vpce.amazonaws.com` and bucket name `my-bucket` with appropriate information.

```
    aws s3 --endpoint-url https://bucket.vpce-1a2b3c4d-5e6f.s3.us-east-1.vpce.amazonaws.com ls s3://my-bucket/
```

### Configure site to use your S3 VPC endpoint

You can test by adding a temporary entry to the **S3 Configuration** site preference on your site.
The complete entry will look like the following:


```json
{​​​​​​​​
   "<S3_CONFIG_NAME>": {​​​​​​​​
     "region": "<BUCKET_REGION>",
     "bucket": "<BUCKET_NAME>",
     "prefix": "<BUCKET_PREFIX>",
     "aws_role_arn": "<ROLE_ARN>"
   }​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​,
   "<S3_CONFIG_NAME_WITH_S3_VPC_ENDPOINT>": {​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
     "region": "<BUCKET_REGION>",
     "bucket": "<BUCKET_NAME>",
     "prefix": "<BUCKET_PREFIX>",
     "aws_role_arn": "<ROLE_ARN>",
     "s3_interface_vpc_endpoint_dns_name": "vpce-1234567-5e6f.s3.us-east-1.vpce.amazonaws.com"
   }​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
}​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
```

After the configuration has been updated on your site, navigate to the /admin/speedtest route of your ShotGrid site. Select the new **S3_CONFIG_NAME_WITH_S3_VPC_ENDPOINT** and start the test to confirm that all the upload/download tests work as intended.

Once it has been verified to work correctly, add the value from s3_interface_vpc_endpoint_dns_name to the main S3 configuration **S3_CONFIG_NAME** and your current setup should be using Media Traffic Isolation.

Erase the **S3_CONFIG_NAME_WITH_S3_VPC_ENDPOINT** entry from the S3 Configuration to clean up your configurations.

## Next Steps

See [Media Replication](./s3_replication.md) to activate the Media Replication Isolation feature.

Go to [Setup](./setup.md) for an overview of the possible next steps.
