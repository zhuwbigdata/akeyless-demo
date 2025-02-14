#

## Create AWS IAM user with proper permissions

Record AWS accout ID as <your-aws-account> 

Reference: 
Rotated Secret (https://docs.akeyless.io/docs/create-an-aws-rotated-secret)

IAM role
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteAccessKey",
                "iam:DeleteUser",
                "iam:CreateUser",
                "iam:CreateAccessKey",
                "iam:ListUserTags",
                "iam:ListAccessKeys"
            ],
            "Resource": "arn:aws:iam::<your-aws-account-id>:user/*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "iam:ListUsers"
            ],
            "Resource": "*"
        }
    ]
}
```

Dynamic Secret (https://docs.akeyless.io/docs/aws-producer)
IAM Role
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:DeleteAccessKey",
                "iam:AttachUserPolicy",
                "iam:DeleteUser",
                "iam:ListUserPolicies",
                "iam:CreateUser",
                "iam:TagUser",
                "iam:CreateAccessKey",
                "iam:CreateLoginProfile",
                "iam:RemoveUserFromGroup",
                "iam:AddUserToGroup",
                "iam:ListGroupsForUser",
                "iam:ListAttachedUserPolicies",
                "iam:DetachUserPolicy",
                "iam:GetLoginProfile",
                "iam:DeleteLoginProfile",
                "iam:ListUserTags",
                "iam:ListAccessKeys"
            ],
            "Resource": "arn:aws:iam::<your-aws-account-id>:user/*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "iam:ListPolicies",
                "iam:ListRoles",
                "iam:ListUsers",
                "iam:ListGroups"
            ],
            "Resource": "*"
        }
    ]
}
```


## Create Rotate AWS secret 

CLI command 
```
export AKEYLESS_PROFILE=<Your-Akeyless-Profile>
akeyless rotated-secret create aws \
--name <Rotated secret name> \
--gateway-url 'https://<Your-Akeyless-GW-URL:8000>' \
--target-name <target name to associate> \
--authentication-credentials <use-user-creds|use-target-creds> \
--rotator-type <api-key|target> \
--api-id <existing access key id> \
--api-key <existing access key secret> \
--grace-rotation <true|false>
--auto-rotate <true|false> \
--rotation-interval <1-365> \
--rotation-hour <hour in UTC> \



akeyless rotated-secret create aws \
--name /devops/aws_akeyless_rotated_secret  \
--gateway-url $AKEYLESS_GW \
--target-name $AWS_TARGET \
--authentication-credentials use-target-creds \
--rotator-type api-key \
--api-id  $ACCESS_KEY_ID \
--api-key $ACCESS_KEY_SECRET \
--grace-rotation true \
--auto-rotate true \
--rotation-interval 7 \
--rotation-hour 1 \


```


