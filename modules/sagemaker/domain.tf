########################################################################################################################
##
## Sagemaker Domain
##
########################################################################################################################

resource "aws_sagemaker_domain" "domain" {
  count = var.enable_sagemaker_domain ? 1 : 0

  name                    = var.sagemaker_domain != "" ? lower(var.sagemaker_domain) : "${lower(var.sagemaker_domain)}-sagemaker-domain"
  auth_mode               = "IAM"
  vpc_id                  = var.vpc_id
  subnet_ids              = [var.subnet_id]
  kms_key_id              = var.kms_key_id
  app_network_access_type = var.app_network_access_type

  tags = merge({ Name = var.sagemaker_domain }, var.tags)

  default_user_settings {
    execution_role  = aws_iam_role.sagemaker_iam_role.arn
    security_groups = [var.security_groups]
  }
}