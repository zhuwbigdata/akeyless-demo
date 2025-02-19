# subClaims from idP and Access Role

## Get sub-claim for idP on Akeyless CLI

```
$ akeyless describe-sub-claims --profile okta-saml
{
  "sub_claims": {
    "client_ip": [
      "10.20.30.40"
    ],
    "client_unique_id": [
      "danielakeyless@akeyless.com"
    ],
    "email": [
      "danielakeyless@akeyless.com"mdk
    ],
    "groups": [
      "Everyone",
      "devops"
    ],
    "user": [
      "danielakeyless@akeyless.com"
    ]
  }
}

```

## Create auth_method using subClaims


## Assign access role using auth_method