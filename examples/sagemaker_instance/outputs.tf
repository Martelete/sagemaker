##
## Output variables
##

##
## Notebook Instance / Lifecycle Configuration
##

output "id" {
  description = "The name of the notebook instance."
  value       = module.sagemaker.id
}

output "sagemaker_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this notebook instance."
  value       = module.sagemaker.sagemaker_arn
}

output "sagemaker_url" {
  description = "The URL that you use to connect to the Jupyter notebook that is running in your notebook instance."
  value       = module.sagemaker.sagemaker_url
}

output "sagemaker_network_interface_id" {
  description = "The network interface ID that Amazon SageMaker created at the time of creating the instance. Only available when setting subnet_id."
  value       = module.sagemaker.sagemaker_network_interface_id
}

output "sagemaker_lifecycle_arn" {
  description = "The Amazon Resource Name (ARN) assigned by AWS to this lifecycle configuration"
  value       = module.sagemaker.sagemaker_lifecycle_arn
}