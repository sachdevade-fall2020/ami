![Build AMI](https://github.com/sachdevade-fall2020/ami/workflows/Build%20AMI%20Workflow/badge.svg)


# AWS AMI for CSYE 6225
Template to build AWS AMI using [Hashicorp Packer](https://packer.io/) for CSYE 6225 course in Fall 2020

## Usage

### Validate template
```
packer validate ami.json
```

### Build AMI

Required variables:
- aws_access_key
- aws_secret_key
- aws_region
- source_ami
- ami_users
- ssh_username

#### using vars params
```
packer build \
    -var 'aws_access_key=REDACTED' \
    -var 'aws_secret_key=REDACTED' \
    -var 'aws_region=us-east-1' \
    -var 'source_ami=REDACTED' \
    -var 'ami_users=REDACTED' \
    -var 'ssh_username=ubuntu' \
    ami.json
```
or

#### using vars file
create vars-local.json from vars.json and provide appropriate values for variables
```
packer build -var-file=./vars-local.json ami.json
```

## Author
Deepansh Sachdeva (NUID 001399788)
