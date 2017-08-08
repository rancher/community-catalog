# Let's Encrypt Certificate Manager

### About
The Let's Encrypt Certificate Manager obtains a free (SAN) SSL Certificate from the [Let's Encrypt CA](https://letsencrypt.org/) and adds it to Rancher's certificate store. Once the certificate is created it is scheduled for automatic renewal 20-days before expiration. Rancher load balancer services are automatically updated to use the renewed certificate.

### Changelog v0.5.0

- Added support for Aurora DNS, Azure DNS and NS1
- Added support for stopping container after creating/renewing certificate
- Added configuration option to specify DNS resolvers to use (fixes an issue with private zones on AWS)
- Added configuration option to specify renewal grace period
- Added support for Rancher servers using self-signed certs
- Logs now contain ACME library messages
     
### Usage
 1. Accept the terms of service.
 2. Select the API version to use. The Sandbox API should be used for testing purposes.
 3. Fill in your email address.
 4. Enter the name used for storing the certificate in Rancher and volumes. Any existing certificate by that name will be updated.
 5. Enter one or more domain names. The first domain will be used as the Common Name property of the certificate.
 6. Fill in the required credentials for the chosen provider. Note provider specific usage notes below.

If you want the certificate to be automatically renewed, leave the service running. Otherwise you may remove the service once the certificate has appeared in Rancher's certificate store.

### Store data in a persistent volume

If you specify a name under "Volume Name" then account data, certificate and private key are stored in a (host scoped) Docker volume with the specified name.
To store the data in a stack scoped volume that can be shared with services running on other hosts, you should provide the name of an already active persistent storage service under "Persistent Storage Driver". See the [Storage Service documentation](https://docs.rancher.com/rancher/v1.3/en/rancher-services/storage-service/).

#### Example

1. Configure the service with a volume named "letsencrypt".
2. Mount the volume to `/etc/letsencrypt` in another service.

This service can then access the certificate and key in the following locations:
 
- `/etc/letsencrypt/production/certs/<certificate name>/fullchain.pem`
- `/etc/letsencrypt/production/certs/<certificate name>/privkey.pem`

where `<certificate name>` is the name of the certificate sanitized to consist of only the following characters: `[a-zA-Z0-9-_.]`.
    
### Provider specific usage

#### AWS Route 53

Note: If you have both a private and public zone for the domain, make sure you configure the service to use public DNS resolvers (the default ones are fine).

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
Then make sure that HTTP requests to `domain.com/.well-known/acme-challenge` are forwarded to port 80 of the `rancher-letsencrypt` service, e.g. by configuring a Rancher load balancer accordingly. Make sure the reverse proxy passes the original `host` header to the backend.

### Suggestions & bug reports
Please submit suggestions or any issues you find to the [rancher-letsencrypt](https://github.com/janeczku/rancher-letsencrypt) GitHub repo.