# devops-tf-aws-sagemaker

## Description

Terraform module for AWS SageMaker

## Requirements

- [terraform](https://releases.hashicorp.com/terraform/) 0.13.4

Following software should be available to develop module:

- [terraform-docs](https://github.com/segmentio/terraform-docs/releases) 0.8+
- [pre-commit](https://pre-commit.com/#install)
- [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform)
- [tflint](https://github.com/terraform-linters/tflint)
- [tfsec](https://github.com/liamg/tfsec)


## Modules
Module supports a creation of AWS SageMaker Notebook Instance:

* [Notebook instance](modules/sagemaker)

Including some additional configs if required:

- [Notebook Lifecycle](modules/sagemaker/notebook_lifecycle.tf)
- [SageMaker Endpoint Configuration](modules/sagemaker/endpoint_config.tf)
- [SageMaker Model](modules/sagemaker/model.tf)

## Usage examples

For more usage examples see submodules documentations and the [examples](examples/sagemaker_instance)

## Usage

To use a module in Terraform configuration head for original [documentation](https://www.terraform.io/docs/modules/sources.html).

Cheat sheet:

- create a `module` resource and set its `source` field to the Git URL of Terraform module repository.
Good practice it to set the `ref` parameter so we're fixed to a specific version of repo, as the `master` branch could
change without backward compatibility).

Example:

```hcl
module "sagemaker" {
  source    = "git@github.com:worldremit/devops-tf-aws-sagemaker//modules/sagemaker?ref=master"

  providers = {
    aws = aws
  }

  ## SageMaker Notebook Instance
  sagemaker_name                    = "sagemaker-example"
  execution_policy_name             = "sagemaker-execution-policy-example"
  subnet_id                         = "subnet-abcde12345"
  security_groups                   = ["sg-12345678"]



  ### Only need to setup **Notebook Instance** however, if you would like extra settings you can add as below configs

  ## SageMaker Notebook Instance Lifecycle configuration
  enable_lifecycle_configuration    = true                          #### Default is set to false
  lifecycle_config_name             = "lifecycle-config-example"
  lifecycle_configuration_on_create = base64encode(data.template_file.instance_start.rendered)
  lifecycle_configuration_on_start  = base64encode(data.template_file.instance_create.rendered)

  ## SageMaker endpoint configuration
  enable_endpoint_configuration     = true                          #### Default is set to false
  endpoint_config_name              = "config-example"
  endpoint_config_production_variants = [{
    initial_instance_count          = 1
    instance_type                   = "ml.t2.medium"
    variant_name                    = "variant-example"
  }]

  ## SageMaker model
  enable_sagemaker_model            = true                           #### Default is set to false
  model_name                        = "model-name-example"
  model_vpc_config = [{
    subnets                         = "subnet-abcde12345"
    security_group_ids              = ["sg-12345678"]
  }]

  model_primary_container = [{
    image                           = "123456789.dkr.ecr.eu-central-1.amazonaws.com/sagemaker-ecr-example"
  }]
  model_container                   = []
  ecr_repository_name               = "sagemaker-ecr-example"

  tags = {
      managed_by                    = "terraform"
      Environment                   = "dev"
      description                   = "AWS SageMaker"
  }
}
```

### Notes

- `execution policy name` we are currently setting the **AmazonSageMakerReadOnly** policy, documentation below:

  - [SageMaker documentation](https://docs.aws.amazon.com/sagemaker/latest/dg/security-iam-awsmanpol.html#security-iam-awsmanpol-AmazonSageMakerReadOnly).

- `lifecycle_configuration_on_create` and `lifecycle_configuration_on_start` allows you to config bash scripts. The directory **templates** has examples of scripts you can passing on bootstrapping the Notebook Instance.

### IMPORTANT
To reinforce the statement above, we are only required to set up the **Notebook Instance** however you may want to set up additional services provided by AWS SageMaker.

- `model_primary_container` MUST to be set up when you choose to config **SageMaker Model**. There are multiple containers that can be set up, however it need to set a **primary container**, otherwise deployment will fail. The parameter **ecr_repository_name** will call the repo, even though, it's cross account.


## Making changes

* Module have to be well documented and documentation should be kept up to date.
* Keep in mind backward compatibility as other modules could reference the module.
* Always format and validate configuration.

### General best practices

Follow [standards](https://github.com/Worldremit/devops-standards/blob/master/terraform-best-practices.md)

### Modules best practices

Follow [module standards](https://github.com/Worldremit/devops-standards/blob/master/terraform-module-developing.md)

### Versioning

We are following the principles of [Semantic Versioning](http://semver.org/). During initial development, the major
version is to 0 (e.g., `0.x.y`), which indicates the code does not yet have a stable API. Once we hit `1.0.0`, we will
follow these rules:

1. Increment the patch version for backwards-compatible bug fixes (e.g., `v1.0.8 -> v1.0.9`).
2. Increment the minor version for new features that are backwards-compatible (e.g., `v1.0.8 -> 1.1.0`).
3. Increment the major version for any backwards-incompatible changes (e.g. `1.0.8 -> 2.0.0`).

The version is defined using Git tags.

## Authors

This module is created and maintained by DevOps team.
