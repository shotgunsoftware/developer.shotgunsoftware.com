---
layout: default
title: Media Isolation
pagename: tier1-setup-s3_bucket
lang: en
---

# Media Isolation

{% include info title="Disclaimer" content="The security of your S3 bucket is solely a client responsibility, and the integrity of your data will be at risk without it. We very strongly recommend [securing your S3 bucket properly](https://aws.amazon.com/premiumsupport/knowledge-center/secure-s3-resources/)." %}

## AWS Account Creation

You can quickly [create your AWS Account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/).
You should also contact your AWS contacts to get help with your AWS account setup.

## AWS CloudFormation template

It's possible to start from the [Private S3 bucket AWS CloudFormation template](https://sg-shotgunsoftware.s3-us-west-2.amazonaws.com/tier1/cloudformation_templates/sg-private-s3-bucket.yml) and customize it for your needs for a faster deployment.

{% include info title="Disclaimer" content="This template is provided as an example only. It is your responsibility to validate that running the template will result in the [configuration/policy/security settings your studio requires](https://aws.amazon.com/premiumsupport/knowledge-center/secure-s3-resources/)." %}

  * Go the CloudFormation service in AWS Console
  * Select Template is ready
  * Set Amazon S3 URL to https://sg-shotgunsoftware.s3-us-west-2.amazonaws.com/tier1/cloudformation_templates/sg-private-s3-bucket.yml
  * Next
  * Set a stack name like {% include product %}-s3-bucket
  * Set your S3 bucket name and your {% include product %} site name
  * Next
  * Accept `I acknowledge that AWS CloudFormation might create IAM resources`
  * Next

### CORS Configuration

CORS policy on your S3 bucket will be minimally configured, allowing only the required origin (your site) and methods, amongst other things.

### IAM Role

The template will create an AWS Role with the following permissions on your bucket:

* Allow {% include product %} to access your S3 bucket.
* Allow the {% include product %} account to assume the role by setting the role Trust Relationship.

## Media Isolation Activation

Please contact {% include product %} support via the dedicated Microsoft Teams channel and provide the following information:
  * {% include product %} IAM Role ARN

{% include product %} will allow your site to use your IAM role.

## Media Configuration Setup

Navigate to your site's site preferences and under the "Isolation" section, fill in the "S3 Configuration" preference with the following JSON replacing all `<EXAMPLE_NAME>` below:

```json
{​​​​​​​
   "<S3_CONFIG_NAME>": {​​​​​​​
     "region": "<BUCKET_REGION>",
     "bucket": "<BUCKET_NAME>",
     "prefix": "<BUCKET_PREFIX>",
     "aws_role_arn": "<ROLE_ARN>",
     "s3_interface_vpc_endpoint_dns_name": ""
   }​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
}​​
```​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​

| Field| Description | 
|------|----------------------------------------------|
|S3_CONFIG_NAME|Unique name for the configuration. This will be selectable as a bucket later on.|
|BUCKET_REGION|Isolation bucket's region|
|BUCKET_NAME|Isolation bucket's name|
|BUCKET_PREFIX|The S3 prefix where the media is located on the isolation bucket|
|ROLE_ARN|AWS Role ARN that ShotGrid can use to access the bucket. This must be the same role specified in the Initial Setup|
|S3_INTERFACE_VPC_ENDPOINT|Optional - This is only needed if Media Traffic Isolation is utilized.|

## Testing Media Configuration

After the configuration has been updated on your site, navigate to the /admin/speedtest route of your ShotGrid site. Select the new S3_CONFIG_NAME that was just set up previously and start the test to confirm that all the upload/download tests work as intended.

## Next Steps

See [Media Traffic Isolation](./media_segregation.md) to activate the Media Traffic Isolation feature.

See [Media Replication](./s3_replication.md) to activate the Media Replication Isolation feature.

Go to [Setup](./setup.md) for an overview of the possible next steps.

