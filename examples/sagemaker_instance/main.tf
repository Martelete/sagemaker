##
## Locals
##

locals {
  team                  = ""
  lifecycle_name        = ""
  sagemaker_name        = format("sagemaker-%s", local.team)
  execution_policy_name = ""

  subnet     = ""
  subnet_ids = ["", ""] #### We can multiple private subnets in this section
  vpc_id     = ""

  config_name  = ""
  variant_name = ""

  model_name          = ""
  ecr_repository_name = ""

  ### In case we are using an extra policy (for example S3), see "modules/sagemaker/iam.tf" for more information

  # bucket         = format("arn:aws:s3:::%s", local.bucket_name)
  # bucket_name    = ""
  # s3_policy_name = ""
}


##
## Variables
##

variable "region" {
  description = "AWS Region to deploy resources."
  type        = string
  default     = "eu-west-1"
}

##
## Data Sources
##

data "aws_caller_identity" "current" {}


### In case you are using the Notebook Lifecycle uncomment the templates below

# data "template_file" "instance_create" {
#   template = file("${path.module}/templates/sagemaker_instance_create.sh")
# }

# data "template_file" "instance_start" {
#   template = file("${path.module}/templates/sagemaker_instance_start.sh")
# }


##
## SageMaker Environment
##

module "sagemaker" {
  source = "../../modules/sagemaker"

  providers = {
    aws = aws
  }

  sagemaker_name        = local.sagemaker_name
  execution_policy_name = local.execution_policy_name
  # s3_policy_name        = local.s3_policy_name          #### ONLY used in case you are using the S3 policy defined on "modules/sagemaker/iam.tf"
  # bucket                = local.bucket                  #### ONLY used in case you are using the S3 policy defined on "modules/sagemaker/iam.tf"
  # kms_key_id            = local.kms_key_id              #### Only need to be set up for the main accounts (DEV, TST, PPD, PRD)
  subnet_id       = local.subnet
  security_groups = [aws_security_group.sagemaker_sg.id]


  ## SageMaker Notebook Instance Lifecycle configuration
  enable_lifecycle_configuration    = true #### Default is set to false
  lifecycle_config_name             = local.lifecycle_name
  lifecycle_configuration_on_create = base64encode(data.template_file.instance_start.rendered)
  lifecycle_configuration_on_start  = base64encode(data.template_file.instance_create.rendered)


  ## In case you are using SageMaker endpoint configuration
  enable_endpoint_configuration = true #### Default is set to false
  endpoint_config_name          = local.config_name
  endpoint_config_production_variants = [{
    # initial_instance_count = 1                          #### Update in case need to change the instance count
    # instance_type          = local.instance_type        #### Default set to "ml.t2.medium"
    variant_name = local.variant_name
  }]


  ## In case you are using SageMaker model
  enable_sagemaker_model = true #### Default is set to false
  model_name             = local.model_name
  model_vpc_config = [{
    subnets            = local.subnet_ids
    security_group_ids = [aws_security_group.sagemaker_sg.id]
  }]

  model_primary_container = [{
    image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${local.ecr_repository_name}"
  }]
  model_container     = []
  ecr_repository_name = local.ecr_repository_name

  tags = module.tags.tags

  ##
  ## VPC ENDPOINT
  ##

  vpc_id = local.vpc_id

  enable_sagemaker_endpoint             = true
  sagemaker_endpoint_security_group_ids = aws_security_group.sagemaker_sg.*.id
  sagemaker_endpoint_subnet_ids         = local.subnet_ids

  default_tags = {
    description = "AWS SageMaker"
    environment = "dev"
    category    = "infrastructure"
    team        = "devops"
    managed_by  = "terraform"
  }
}


##
## SageMaker Security Group
##

resource "aws_security_group" "sagemaker_sg" {
  name        = "sagemaker-sg-${var.region}"
  description = "Security Group for SageMaker Notebook Instance"
  vpc_id      = local.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["10.1.0.0/16"]
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "sagemaker-sg-${var.region}"
    },
    module.tags.tags
  )
}
