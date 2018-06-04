# Let's Encrypt Certificate Manager

### About
The Let's Encrypt Certificate Manager obtains a free (SAN) SSL Certificate from the [Let's Encrypt CA](https://letsencrypt.org/) and adds it to Rancher's certificate store. Once the certificate is created it is scheduled for automatic renewal 20-days before expiration. Rancher load balancer services are automatically updated to use the renewed certificate.
     
### Usage
 1. Accept the terms of service.
 2. Select the API version to use. The Sandbox API should be used for testing purposes.
 3. Fill in your email address.
 4. Enter the name used for storing the certificate in Rancher and volumes. Any existing certificate by that name will be updated.
 5. Enter one or more domain names. The first domain will be used as the Common Name property of the certificate.
 6. Fill in the required credentials for the chosen provider. Note provider specific usage notes below.

If you want the certificate to be automatically renewed, leave the service running. Otherwise you may remove the service once the certificate has appeared in Rancher's certificate store.

### Using persistent storage volume

If you specify an existing volume storage driver (e.g. rancher-nfs) then the account data, certificate and private key will be stored in a stack scoped volume named `lets-encrypt`, allowing you to access them from other services in the same stack. See the [Storage Service documentation](https://docs.rancher.com/rancher/v1.3/en/rancher-services/storage-service/).

#### Example

When mounting the `lets-encrypt` storage volume to `/etc/letsencrypt` in another container, then production certificates and keys are located at:
 
- `/etc/letsencrypt/production/certs/<certificate name>/fullchain.pem`
- `/etc/letsencrypt/production/certs/<certificate name>/privkey.pem`

where `<certificate name>` is the name of the certificate sanitized to consist of only the following characters: `[a-zA-Z0-9-_.]`.
    
### Provider specific usage

#### AWS Route 53

The following IAM policy describes the minimum permissions required when using AWS Route 53 for domain authorization.    
Replace `<HOSTED_ZONE_ID>` with the ID of the hosted zone that encloses the domain(s) for which you are going to obtain certificates. You may use a wildcard (*) in place of the ID to make this policy work with all of the hosted zones associated with an AWS account.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:GetChange",
                "route53:ListHostedZonesByName"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": [
                "arn:aws:route53:::hostedzone/<HOSTED_ZONE_ID>"
            ]
        }
    ]
}
```

#### OVH

First create your credentials on https://eu.api.ovh.com/createToken/ by filling out the form like this:

- `Account ID`: Your OVH account ID
- `Password`: Your password
- `Script name`: letsencrypt
- `Script description`: Letsencrypt for Rancher
- `Validity`: Unlimited
- `Rights`:
  - GET /domain/zone/*
  - POST /domain/zone/*
  - DELETE /domain/zone/*

Then deploy this service using the generated key, application secret and consumer key.

#### HTTP

If you prefer not to use a DNS-based challenge or your provider is not supported, you can use the HTTP challenge.
Simply choose `HTTP` from the list of providers.
Then make sure that HTTP requests to `domain.com/.well-known/acme-challenge` are forwarded to the `rancher-letsencrypt` service, e.g. by configuring a Rancher load balancer accordingly.

### Suggestions & bug reports
Please submit suggestions or any issues you find to the [rancher-letsencrypt](https://github.com/janeczku/rancher-letsencrypt) GitHub repo.