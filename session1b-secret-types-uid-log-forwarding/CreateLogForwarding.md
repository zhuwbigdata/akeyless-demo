# Log Forwarding
Reference: 
(https://docs.akeyless.io/docs/log-forwarding)


## AWS S3
Block All Public Access


### Cloud Identity

### Assume Role if the gateway is running in AWS

### Credential / IAM User /  IAM Policy

IAM policy
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:ListBucketMultipartUploads",
                "s3:ListBucketVersions",
                "s3:ListBucket",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::<bucket_name>",
                "arn:aws:s3:::<bucket-name>/*"
            ]
        }
    ]
}
```
