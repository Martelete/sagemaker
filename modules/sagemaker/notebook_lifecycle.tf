##
## AWS SageMaker Notebook Instance Lifecycle Configuration
##

resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "sagemaker_lc" {
  count = var.enable_lifecycle_configuration ? 1 : 0

  name      = var.lifecycle_config_name != "" ? lower(var.lifecycle_config_name) : "${lower(var.lifecycle_config_name)}-sagemaker-lc-conf"
  on_create = var.lifecycle_configuration_on_create
  on_start  = var.lifecycle_configuration_on_start

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}