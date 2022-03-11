######################
## Output variables ##
######################

##
## Notebook Instance / Lifecycle Configuration
##

output "id" {
  description = "The name of the notebook instance."
  value       = element(concat(aws_sagemaker_notebook_instance.sagemaker_instance.*.id, [""]), 0)
}

output "sagemaker_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this notebook instance."
  value       = element(concat(aws_sagemaker_notebook_instance.sagemaker_instance.*.arn, [""]), 0)
}

output "sagemaker_url" {
  description = "The URL that you use to connect to the Jupyter notebook that is running in your notebook instance."
  value       = element(concat(aws_sagemaker_notebook_instance.sagemaker_instance.*.url, [""]), 0)
}

output "sagemaker_network_interface_id" {
  description = "The network interface ID that Amazon SageMaker created at the time of creating the instance. Only available when setting subnet_id."
  value       = element(concat(aws_sagemaker_notebook_instance.sagemaker_instance.*.network_interface_id, [""]), 0)
}

output "sagemaker_lifecycle_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this lifecycle configuration"
  value       = element(concat(aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_lc.*.arn, [""]), 0)
}


##
## Endpoint Configuration
##

output "sagemaker_endpoint_configuration_id" {
  description = "The ID of sagemaker endpoint configuration"
  value       = element(concat(aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.*.id, [""]), 0)
}

output "sagemaker_endpoint_configuration_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this endpoint configuration."
  value       = element(concat(aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.*.arn, [""]), 0)
}

output "sagemaker_endpoint_configuration_name" {
  description = "The name of the endpoint configuration."
  value       = element(concat(aws_sagemaker_endpoint_configuration.sagemaker_endpoint_configuration.*.name, [""]), 0)
}


##
## Model Configuration
##

output "sagemaker_model_id" {
  description = "The ID of sagemaker model"
  value       = element(concat(aws_sagemaker_model.sagemaker_model.*.id, [""]), 0)
}

output "sagemaker_model_name" {
  description = "The name of the model"
  value       = element(concat(aws_sagemaker_model.sagemaker_model.*.name, [""]), 0)
}

output "sagemaker_model_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this model"
  value       = element(concat(aws_sagemaker_model.sagemaker_model.*.arn, [""]), 0)
}

##
## Domain
##

output "sagemaker_domain_id" {
  description = "The ID of the domain"
  value       = element(concat(aws_sagemaker_domain.sagemaker_domain.*.id, [""]), 0)
}

output "sagemaker_domain_url" {
  description = "The domain's URL"
  value       = element(concat(aws_sagemaker_domain.sagemaker_domain.*.url, [""]), 0)
}

output "sagemaker_domain_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this domain"
  value       = element(concat(aws_sagemaker_domain.sagemaker_domain.*.arn, [""]), 0)
}