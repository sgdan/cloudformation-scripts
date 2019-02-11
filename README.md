# CloudFormation test scripts

Some CloudFormation scripts to try out various features.

## Simple VPC and EC2 instance

Creates a simple VPC containing 2 private subnets. Also adds a
NAT gateway and related resources so that instances in those subnets
can connect out to the Internet e.g. for the following purposes:
- update via package manager repo
- download docker images from docker hub
- connect to Session Manager's public endpoint (enables use of session manager instead of SSH)

Copy `SimpleVpc.json.example` to `SimpleVpc.json` and configure the CIDR range you wish to
restrict incoming connections to.
```
./update.sh SimpleVpc
```
Once the VPC stack has been successfully created, create the instance:
```
./update.sh SimpleInstance
```
You should be able to use Systems Manager > Session Manager in the AWS console to log
in to the instance once it has been created.

## Test NLB with TLS (new AWS feature as of Jan 2019)

Copy `Https.json.example` to `Https.json` and configure certificate ARN and domain.
```
./update.sh Https
```
Go to https://nginx.mydomain.com and you should see the default nginx home page and the
correct certificate details.

## GitLab CE running in a docker container

- persistent data mapped to encrypted EBS
- additional encrypted EBS for /var/lib/docker
- listens on https://gitlab.mydomain.com with NLB configured for HTTPS termination
- also accepts SSH connections for git

Set parameters in `Gitlab.json` first.
```
./update.sh Gitlab
```
Go to https://gitlab.mydomain.com, add password and login as "root".
