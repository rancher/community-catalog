# Rancher ECR Credentials Updater

This is Docker container that when executed will update the Docker registry credentials in Rancher for an Amazon Elastic Container Registry.

## Why is this needed?

Because access to ECR is controlled with AWS IAM.
An IAM user must request a temporary credential to the registry using the AWS API.
This temporary credential is then valid for 12 hours.

Rancher only supports registries that authenticate with a username and password.

## How to use

Run this container with the following environment variables:
* `AWS_REGION` - the AWS region of the ECR registry
* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`

Add the following labels to the service in Rancher:
* `io.rancher.container.create_agent: true`
* `io.rancher.container.agent.role: environment`

These labels will cause Rancher to provision an API key for this service and create the `CATTLE_URL`, `CATTLE_ACCESS_KEY`, and `CATTLE_SECRET_KEY` environment variables.

## Running container outside of Rancher

If you are running this container outside of a Rancher managed environment, then you must provide the following envvars in additional to the ones above.
* `CATTLE_URL` - the url of the Rancher server to update
* `CATTLE_ACCESS_KEY`
* `CATTLE_SECRET_KEY`

```bash
$ docker run -d -e AWS_REGION=us-east-1 -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e CATTLE_URL=http://rancher.mydomain.com -e CATTLE_ACCESS_KEY=$CATTLE_ACCESS_KEY -e CATTLE_SECRET_KEY=$CATTLE_SECRET_KEY objectpartners/rancher-ecr-credentials:latest
```

## Notes

The AWS credentials must correspond to an IAM user that has permissions to call the ECR `GetToken` API.
The application then parses the resulting response to retrieve the ECR registry URL, username, and password.
The returned registry URL, is used to discover the corresponding registry in Rancher.

Rancher stores registries by environment.
If multiple environments exists, one instance of this container must be run per environment.
Rancher credentials are tied to an environment, so specifying them will indicate which environment to update in Rancher.

__NOTE__: This application runs on a 6 hour loop. It's possible there could be a slight gap where the credentials expire before this program updates them.
