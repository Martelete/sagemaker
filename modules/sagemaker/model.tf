##
## AWS Sagemaker model
##

resource "aws_sagemaker_model" "sagemaker_model" {
  count = var.enable_sagemaker_model ? 1 : 0

  name               = var.model_name != "" ? lower(var.model_name) : "${lower(var.sagemaker_name)}-model"
  execution_role_arn = aws_iam_role.sagemaker_iam_role.arn

  enable_network_isolation = var.model_enable_network_isolation

  dynamic "primary_container" {
    for_each = var.model_primary_container

    content {
      # image              = lookup(primary_container.value, "image", element(concat(data.aws_ecr_repository.sagemaker_ecr.*.arn, [""]), 0))
      image              = lookup(primary_container.value, "image", var.ecr_repository_name)
      model_data_url     = lookup(primary_container.value, "model_data_url", null)
      container_hostname = lookup(primary_container.value, "container_hostname", null)
      environment        = lookup(primary_container.value, "environment", null)
    }
  }

  dynamic "container" {
    for_each = var.model_container

    content {
      image              = lookup(container.value, "image", null)
      model_data_url     = lookup(container.value, "model_data_url", null)
      container_hostname = lookup(container.value, "container_hostname", null)
      environment        = lookup(container.value, "environment", null)
    }
  }

  dynamic "vpc_config" {
    for_each = var.model_vpc_config

    content {
      subnets            = lookup(vpc_config.value, "subnets", null)
      security_group_ids = lookup(vpc_config.value, "security_group_ids", null)
    }
  }

  tags = merge(
    {
      Name = var.model_name != "" ? lower(var.model_name) : "${lower(var.sagemaker_name)}-model"
    },
    var.tags
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes        = []
  }

  depends_on = []
}

# ##
# ## AWS ECR
# ##

# resource "aws_ecr_repository" "sagemaker_ecr" {
#   name = var.ecr_repository_name
# }
