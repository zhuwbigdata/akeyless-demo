# Create DFC Key and Encrypt Static Secret

## Create DFC key for encryption
```
$ akeyless create-dfc-key -n /devops/dfc-master-key -a RSA2048 --rotation-interval 7 --profile okta-saml
=====================
Encryption DFCKey Fragment #0 created successfully in 372ns milliseconds
Encryption DFCKey Fragment #1 created successfully in 373ns milliseconds
Encryption DFCKey Fragment #2 created successfully in 374ns milliseconds
=====================
A new RSA2048 DFC key named /devops/dfc-master-key was successfully created
```

## Create static secret encrypted by DFC key
```
$ akeyless create-secret -n /devops/static_secret_encrypted_by_master -v 'showAndtell' -k /devops/dfc-master-key --profile okta-saml
failed to create the requested secret: Desc: failed to obtain upload secret credentials, Error: Desc: Failed to get upload secret creds. Status 400 Bad Request, Error: InvalidType. Message: account id: acc-xxx, access id: p-yyy. only a key of the algs - AES128GCM/AES256GCM can be used as a secret's protection key. Item name /devops/dfc-master-key, account id: acc-xxx
```

## Delete an exisitng key
```
$ akeyless delete-item -n /devops/dfc-master-key --profile  okta-saml
Item /devops/dfc-master-key set to be deleted on 2025-02-20 13:27:35.269401094 +0000 UTC
```

## Create DFC key with proper type 
```
$ akeyless create-dfc-key -n /devops/dfc-master-aes-key -a AES256GCM --rotation-interval 7 --profile okta-saml
=====================
Encryption DFCKey Fragment #0 created successfully in 108ns milliseconds
Encryption DFCKey Fragment #1 created successfully in 109ns milliseconds
Encryption DFCKey Fragment #2 created successfully in 110ns milliseconds
=====================
A new AES256GCM DFC key named /devops/dfc-master-aes-key was successfully created
```

## List the details of a key
```
$ keyless list-items --path /devops --type key  --filter dfc-master-aes-key --profile okta-saml

```

## Create static secret encrypted by DFC key
```
$ akeyless create-secret -n /devops/static_secret_encrypted_by_master -v 'showAndtell' -k /devops/dfc-master-aes-key --profile okta-saml
A new secret named /devops/static_secret_encrypted_by_master was successfully created
```

## List the details of a secret
```
$ akeyless list-items --path /devops --type static-secret   --filter static_secret_encrypted_by_master  --profile okta-saml
```

## Rotate DFC key
```
$ akeyless rotate-key --name  /devops/dfc-master-aes-key  --profile okta-saml
Key /devops/dfc-master-aes-key has been rotated successfully, new version: 2
```

## Disable a version of DFC key
```
$ akeyless set-item-state --name /devops/dfc-master-aes-key -s Disabled --version=1 --profile okta-saml
failed to set item /devops/dfc-master-aes-key version 1 state to Disabled: Desc: Failed to set item state. Status 403 Forbidden, Error: InvalidKeyStateUpdate. Message: account id: acc-xxx, access id: p-yyy. This key version is used as a protection key for the following secrets: /devops/static_secret_encrypted_by_master 
```



