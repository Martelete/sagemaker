########################################################################################################################
##
## VPC Endpoint for sagemaker
##
########################################################################################################################

resource "aws_vpc_endpoint" "sagemaker" {
  count = var.enable_sagemaker_endpoint ? 1 : 0

  vpc_id            = var.vpc_id
  service_name      = "aws.sagemaker.${var.region}.notebook"
  vpc_endpoint_type = "Interface"

  security_group_ids  = var.sagemaker_endpoint_security_group_ids
  subnet_ids          = var.sagemaker_endpoint_subnet_ids
  private_dns_enabled = true

  tags = merge(
    {
      Name = format("vpce-sagemaker-%s", var.region)
    },
    var.tags
  )
}
