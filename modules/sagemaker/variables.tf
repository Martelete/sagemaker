########################################################################################################################
##
## Variables
##
########################################################################################################################

##
## Terraform configuration section
##

variable "region" {
  description = "Region where main resources should be created."
  type        = string
  default     = "eu-central-1"
}

variable "tf_account_id" {
  description = "Data account to have cross access"
  type        = string
  default     = ""
}


##
## AWS SageMaker Notebook Instance Configuration section
##

variable "enable_sagemaker_notebook_instance" {
  description = "Enable SageMaker Notebook Instance"
  type        = bool
  default     = true
}

variable "sagemaker_name" {
  description = "The name of the notebook instance (must be unique)"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The name of ML compute instance type"
  type        = string
  default     = "ml.t2.medium"
}

variable "platform_identifier" {
  description = "The platform identifier of the notebook instance runtime environment. This value can be either notebook-al1-v1 or notebook-al2-v1, depending on which version of Amazon Linux you require."
  type        = string
  default     = null
}

variable "volume_size" {
  description = "The size, in GB, of the ML storage volume to attach to the notebook instance. The default value is 5 GB."
  type        = string
  default     = 5
}

variable "subnet_id" {
  description = "The VPC subnet ID"
  type        = string
  default     = null
}

variable "security_groups" {
  description = "The associated security groups"
  type        = list(string)
  default     = []
}

variable "kms_key_id" {
  description = "The AWS Key Management Service (AWS sagemaker) key that Amazon SageMaker uses to encrypt the model artifacts at rest using Amazon S3 server-side encryption."
  type        = string
  default     = ""
}

variable "default_code_repository" {
  description = "The Git repository associated with the notebook instance as its default code repository. This can be either the name of a Git repository stored as a resource in your account, or the URL of a Git repository in AWS CodeCommit or in any other Git repository."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Resources tag information."
  type        = map(string)
  default     = {}
}

##
## AWS SageMaker Notebook Instance Lifecycle Configuration
##

variable "enable_lifecycle_configuration" {
  description = "Enable sagemaker notebook instance lifecycle configuration usage"
  type        = bool
  default     = false
}

variable "lifecycle_config_name" {
  description = "The name of a lifecycle configuration to associate with the notebook instance."
  type        = string
  default     = null
}

variable "lifecycle_configuration_on_create" {
  description = "A shell script (base64-encoded) that runs only once when the SageMaker Notebook Instance is created."
  type        = string
  default     = null
}

variable "lifecycle_configuration_on_start" {
  description = "A shell script (base64-encoded) that runs every time the SageMaker Notebook Instance is started including the time it's created."
  type        = string
  default     = null
}


##
## AWS Sagemaker endpoint configuration
##

variable "enable_endpoint_configuration" {
  description = "Enable sagemaker endpoint configuration"
  type        = bool
  default     = false
}

variable "endpoint_config_name" {
  description = "The name of the endpoint configuration. If omitted, Terraform will assign a random, unique name"
  type        = string
  default     = null
}

variable "endpoint_config_kms_key_arn" {
  description = "Amazon Resource Name (ARN) of a AWS Key Management Service key that Amazon SageMaker uses to encrypt data on the storage volume attached to the ML compute instance that hosts the endpoint"
  type        = string
  default     = null
}

variable "endpoint_config_production_variants" {
  description = "Required fields set up in block"
  type        = any
  default     = {}
}

##
## AWS Sagemaker model
##

variable "enable_sagemaker_model" {
  description = "Enable sagemaker model"
  type        = bool
  default     = false
}

variable "model_name" {
  description = "The name of SageMaker model"
  type        = string
  default     = null
}

variable "model_enable_network_isolation" {
  description = "Isolates the model container. No inbound or outbound network calls can be made to or from the model container"
  type        = bool
  default     = false
}

variable "model_primary_container" {
  description = "Specifies containers in the inference pipeline. If not specified, the primary_container argument is required"
  type        = any
  default     = {}
}

variable "model_container" {
  description = "Specifies containers in the inference pipeline. If not specified, the primary_container argument is required"
  type        = any
  default     = {}
}

variable "model_vpc_config" {
  description = "Specifies the VPC that you want your model to connect to. VpcConfig is used in hosting services and in batch transform"
  type        = any
  default     = {}
}

variable "ecr_repository_name" {
  description = "Name of the ecr repository"
  type        = string
  default     = null
}


##
## Policies
##

variable "execution_policy_name" {
  description = "The name of the Execution policy"
  type        = string
  default     = ""
}

##
## SageMaker VPC Endpoint
##

variable "enable_sagemaker_endpoint" {
  description = "Enable provisioning of a sagemaker endpoint."
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = ""
}

variable "sagemaker_endpoint_security_group_ids" {
  description = "The ID of one or more security groups to associate with the network interface for sagemaker endpoint."
  type        = list(string)
  default     = []
}

variable "sagemaker_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for sagemaker endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}

##
## AWS SageMaker Domain
##

variable "enable_sagemaker_domain" {
  description = "Enable provisioning of a sagemaker domain."
  type        = bool
  default     = false
}

variable "sagemaker_domain" {
  description = "The domain name"
  type        = string
  default     = ""
}

variable "app_network_access_type" {
  description = "Specifies the VPC used for non-EFS traffic. The default value is PublicInternetOnly. Valid values are PublicInternetOnly and VpcOnly"
  type        = string
  default     = ""
}

