##
## AWS SageMaker Notebook Instance
##

resource "aws_sagemaker_notebook_instance" "sagemaker_instance" {
  count = var.enable_sagemaker_notebook_instance ? 1 : 0

  name                    = var.sagemaker_name != "" ? lower(var.sagemaker_name) : "${lower(var.sagemaker_name)}-sagemaker-notebook-instance"
  role_arn                = aws_iam_role.sagemaker_iam_role.arn
  instance_type           = var.instance_type
  platform_identifier     = var.platform_identifier
  volume_size             = var.volume_size
  subnet_id               = var.subnet_id
  security_groups         = var.security_groups
  kms_key_id              = var.kms_key_id
  lifecycle_config_name   = var.lifecycle_config_name != "" && ! var.enable_lifecycle_configuration ? var.lifecycle_config_name : element(concat(aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_lc.*.id, [""]), 0)
  root_access             = "Disabled"
  direct_internet_access  = "Disabled"
  default_code_repository = var.default_code_repository

  tags = merge({ Name = var.sagemaker_name }, var.tags)

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = [
    aws_sagemaker_notebook_instance_lifecycle_configuration.sagemaker_lc
  ]
}
