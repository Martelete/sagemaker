# AWS SageMaker


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13.4 |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | >= 3.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider_aws) | >= 3.45 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.sagemaker_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.sagemaker_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_sagemaker_domain.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_domain) | resource |
| [aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_endpoint_configuration) | resource |
| [aws_sagemaker_model.sagemaker_model](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_model) | resource |
| [aws_sagemaker_notebook_instance.sagemaker_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_notebook_instance) | resource |
| [aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_lc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sagemaker_notebook_instance_lifecycle_configuration) | resource |
| [aws_vpc_endpoint.sagemaker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.sagemaker_execution_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_network_access_type"></a> [app_network_access_type](#input_app_network_access_type) | Specifies the VPC used for non-EFS traffic. The default value is PublicInternetOnly. Valid values are PublicInternetOnly and VpcOnly | `string` | n/a | yes |
| <a name="input_default_code_repository"></a> [default_code_repository](#input_default_code_repository) | The Git repository associated with the notebook instance as its default code repository. This can be either the name of a Git repository stored as a resource in your account, or the URL of a Git repository in AWS CodeCommit or in any other Git repository. | `string` | `""` | no |
| <a name="input_ecr_repository_name"></a> [ecr_repository_name](#input_ecr_repository_name) | Name of the ecr repository | `string` | `null` | no |
| <a name="input_enable_endpoint_configuration"></a> [enable_endpoint_configuration](#input_enable_endpoint_configuration) | Enable sagemaker endpoint configuration | `bool` | `false` | no |
| <a name="input_enable_lifecycle_configuration"></a> [enable_lifecycle_configuration](#input_enable_lifecycle_configuration) | Enable sagemaker notebook instance lifecycle configuration usage | `bool` | `false` | no |
| <a name="input_enable_sagemaker_domain"></a> [enable_sagemaker_domain](#input_enable_sagemaker_domain) | Enable provisioning of a sagemaker domain. | `bool` | `false` | no |
| <a name="input_enable_sagemaker_endpoint"></a> [enable_sagemaker_endpoint](#input_enable_sagemaker_endpoint) | Enable provisioning of a sagemaker endpoint. | `bool` | `true` | no |
| <a name="input_enable_sagemaker_model"></a> [enable_sagemaker_model](#input_enable_sagemaker_model) | Enable sagemaker model | `bool` | `false` | no |
| <a name="input_enable_sagemaker_notebook_instance"></a> [enable_sagemaker_notebook_instance](#input_enable_sagemaker_notebook_instance) | Enable SageMaker Notebook Instance | `bool` | `true` | no |
| <a name="input_endpoint_config_kms_key_arn"></a> [endpoint_config_kms_key_arn](#input_endpoint_config_kms_key_arn) | Amazon Resource Name (ARN) of a AWS Key Management Service key that Amazon SageMaker uses to encrypt data on the storage volume attached to the ML compute instance that hosts the endpoint | `string` | `null` | no |
| <a name="input_endpoint_config_name"></a> [endpoint_config_name](#input_endpoint_config_name) | The name of the endpoint configuration. If omitted, Terraform will assign a random, unique name | `string` | `null` | no |
| <a name="input_endpoint_config_production_variants"></a> [endpoint_config_production_variants](#input_endpoint_config_production_variants) | Required fields set up in block | `any` | `{}` | no |
| <a name="input_execution_policy_name"></a> [execution_policy_name](#input_execution_policy_name) | The name of the Execution policy | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type) | The name of ML compute instance type | `string` | `"ml.t2.medium"` | no |
| <a name="input_kms_key_id"></a> [kms_key_id](#input_kms_key_id) | The AWS Key Management Service (AWS sagemaker) key that Amazon SageMaker uses to encrypt the model artifacts at rest using Amazon S3 server-side encryption. | `string` | `""` | no |
| <a name="input_lifecycle_config_name"></a> [lifecycle_config_name](#input_lifecycle_config_name) | The name of a lifecycle configuration to associate with the notebook instance. | `string` | `null` | no |
| <a name="input_lifecycle_configuration_on_create"></a> [lifecycle_configuration_on_create](#input_lifecycle_configuration_on_create) | A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created. | `string` | `null` | no |
| <a name="input_lifecycle_configuration_on_start"></a> [lifecycle_configuration_on_start](#input_lifecycle_configuration_on_start) | A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created. | `string` | `null` | no |
| <a name="input_model_container"></a> [model_container](#input_model_container) | Specifies containers in the inference pipeline. If not specified, the primary_container argument is required | `any` | `{}` | no |
| <a name="input_model_enable_network_isolation"></a> [model_enable_network_isolation](#input_model_enable_network_isolation) | Isolates the model container. No inbound or outbound network calls can be made to or from the model container | `bool` | `false` | no |
| <a name="input_model_name"></a> [model_name](#input_model_name) | The name of SageMaker model | `string` | `null` | no |
| <a name="input_model_primary_container"></a> [model_primary_container](#input_model_primary_container) | Specifies containers in the inference pipeline. If not specified, the primary_container argument is required | `any` | `{}` | no |
| <a name="input_model_vpc_config"></a> [model_vpc_config](#input_model_vpc_config) | Specifies the VPC that you want your model to connect to. VpcConfig is used in hosting services and in batch transform | `any` | `{}` | no |
| <a name="input_platform_identifier"></a> [platform_identifier](#input_platform_identifier) | The platform identifier of the notebook instance runtime environment. This value can be either notebook-al1-v1 or notebook-al2-v1, depending on which version of Amazon Linux you require. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input_region) | Region where main resources should be created. | `string` | `"eu-central-1"` | no |
| <a name="input_sagemaker_domain"></a> [sagemaker_domain](#input_sagemaker_domain) | The domain name | `string` | n/a | yes |
| <a name="input_sagemaker_endpoint_security_group_ids"></a> [sagemaker_endpoint_security_group_ids](#input_sagemaker_endpoint_security_group_ids) | The ID of one or more security groups to associate with the network interface for sagemaker endpoint. | `list(string)` | `[]` | no |
| <a name="input_sagemaker_endpoint_subnet_ids"></a> [sagemaker_endpoint_subnet_ids](#input_sagemaker_endpoint_subnet_ids) | The ID of one or more subnets in which to create a network interface for sagemaker endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used. | `list(string)` | `[]` | no |
| <a name="input_sagemaker_name"></a> [sagemaker_name](#input_sagemaker_name) | The name of the notebook instance (must be unique) | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security_groups](#input_security_groups) | The associated security groups | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id) | The VPC subnet ID | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input_tags) | Resources tag information. | `map(string)` | `{}` | no |
| <a name="input_tf_account_id"></a> [tf_account_id](#input_tf_account_id) | Data account to have cross access | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume_size](#input_volume_size) | The size, in GB, of the ML storage volume to attach to the notebook instance. The default value is 5 GB. | `string` | `5` | no |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id) | ID of the VPC where to create security group | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output_id) | The name of the notebook instance. |
| <a name="output_sagemaker_arn"></a> [sagemaker_arn](#output_sagemaker_arn) | The Amazon Resource Name (ARN) assigned by AWS to this notebook instance. |
| <a name="output_sagemaker_domain_arn"></a> [sagemaker_domain_arn](#output_sagemaker_domain_arn) | The Amazon Resource Name (ARN) assigned by AWS to this domain |
| <a name="output_sagemaker_domain_id"></a> [sagemaker_domain_id](#output_sagemaker_domain_id) | The ID of the domain |
| <a name="output_sagemaker_domain_url"></a> [sagemaker_domain_url](#output_sagemaker_domain_url) | The domain's URL |
| <a name="output_sagemaker_endpoint_configuration_arn"></a> [sagemaker_endpoint_configuration_arn](#output_sagemaker_endpoint_configuration_arn) | The Amazon Resource Name (ARN) assigned by AWS to this endpoint configuration. |
| <a name="output_sagemaker_endpoint_configuration_id"></a> [sagemaker_endpoint_configuration_id](#output_sagemaker_endpoint_configuration_id) | The ID of sagemaker endpoint configuration |
| <a name="output_sagemaker_endpoint_configuration_name"></a> [sagemaker_endpoint_configuration_name](#output_sagemaker_endpoint_configuration_name) | The name of the endpoint configuration. |
| <a name="output_sagemaker_lifecycle_arn"></a> [sagemaker_lifecycle_arn](#output_sagemaker_lifecycle_arn) | The Amazon Resource Name (ARN) assigned by AWS to this lifecycle configuration |
| <a name="output_sagemaker_model_arn"></a> [sagemaker_model_arn](#output_sagemaker_model_arn) | The Amazon Resource Name (ARN) assigned by AWS to this model |
| <a name="output_sagemaker_model_id"></a> [sagemaker_model_id](#output_sagemaker_model_id) | The ID of sagemaker model |
| <a name="output_sagemaker_model_name"></a> [sagemaker_model_name](#output_sagemaker_model_name) | The name of the model |
| <a name="output_sagemaker_network_interface_id"></a> [sagemaker_network_interface_id](#output_sagemaker_network_interface_id) | The network interface ID that Amazon SageMaker created at the time of creating the instance. Only available when setting subnet_id. |
| <a name="output_sagemaker_url"></a> [sagemaker_url](#output_sagemaker_url) | The URL that you use to connect to the Jupyter notebook that is running in your notebook instance. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
