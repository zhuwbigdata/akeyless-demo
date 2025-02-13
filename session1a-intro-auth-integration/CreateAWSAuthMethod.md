# Create AWS Auth Method

## Create AWS IAM role that can be assumed by EC2 instances.
IAM > Role > Create Role > AWS Service (EC2)

Trust relationships (EC2)
```
Trust relationships
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```
Permissions
```
AmazonEC2ReadOnlyAccess
```

Record the account ID <AccountID>
arn:aws:iam::<AccountID>:role/waynez_aws_iam_ec2_role

## Create auth method based on AWS account ID and its role association
```
akeyless auth-method create aws-iam \
--name /devops/aws_iam_auth_devops \
--bound-aws-account-id <AWS Account ID>

akeyless assoc-role-am -r  /devops/devops_ENGR -a /devops/aws_iam_auth_devops
```

## Install and Configure CLI on EC2 with IAM role 
Reference: (https://tutorials.akeyless.io/docs/installing-and-configuring-akeyless-cli)
```
$ akeyless configure --profile default --access-id <AccessID>  \ 
                   --access-type aws_iam 
$ akeyless get-cloud-identity --cloud-provider aws_iam
$ akeyless get-secret-value --name /devops/static_secret_1
```