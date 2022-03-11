########################################################################################################################
##
## Module for deployment and management of an AWS SageMaker
##
########################################################################################################################

data "aws_caller_identity" "current" {}

locals {
  tf_account_id = data.aws_caller_identity.current.account_id
}

resource "aws_iam_role" "sagemaker_iam_role" {
  name = var.sagemaker_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "sagemaker.amazonaws.com"
          ]
        }
        Action = "sts:AssumeRole"
      },
    ]
  })

  tags = merge(var.tags, {
    Name = var.sagemaker_name
  })
}


##
## AWS SAGEMAKER EXECUTION POLICY / ATTACHMENT
##

## The Policy configuration below is following the "AmazonSageMakerReadOnly" access. For the policy doc, see link:
## https://docs.aws.amazon.com/sagemaker/latest/dg/security-iam-awsmanpol.html#security-iam-awsmanpol-AmazonSageMakerReadOnly

data "aws_iam_policy" "sagemaker_execution_policy" {
  name = "AmazonSageMakerReadOnly"
}

resource "aws_iam_role_policy_attachment" "sagemaker_iam_role_policy_attachment" {
  role       = aws_iam_role.sagemaker_iam_role.name
  policy_arn = data.aws_iam_policy.sagemaker_execution_policy.arn
}




##
## AWS SAGEMAKER API OPERATIONS
##

## Below is the documentation
## https://docs.aws.amazon.com/sagemaker/latest/dg/security_iam_id-based-policy-examples.html#security_iam_id-based-policy-examples-console


# data "aws_iam_policy_document" "sagemaker_api_operations" {
#   statement {
#     sid = "SageMaker API"

#     effect = "Allow"

#     actions = [
#       "sagemaker:*",
#     ]

#     resources = [
#       "arn:aws:sagemaker:${var.region}:${local.tf_account_id}:notebook-instance/${var.sagemaker_name}"
#     ]
#   }

#   statement {
#     effect = "Allow"

#     actions = [
#       "iam:PassRole",
#     ]

#     resources = ["*"]

#     condition {
#       test     = "StringEquals"
#       variable = "iam:PassedToService"
#       values   = ["sagemaker.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_policy" "sagemaker_iam_policy" {
#   name   = var.policy_name
#   path   = "/functional/"
#   policy = data.aws_iam_policy_document.sagemaker_api_operations.json
# }

# resource "aws_iam_role_policy_attachment" "sagemaker_policy_attachment" {
#   role       = aws_iam_role.sagemaker_iam_role.name
#   policy_arn = aws_iam_policy.sagemaker_iam_policy.arn
# }


# ##
# ## CALLING A MODULE
# ##

# module "sagemaker_role" {
#   source = "??"

#   providers = {
#     aws = aws
#   }

#   enabled = true

#   policy_enabled = true

#   roles = {
#     AWSConversionSAML = {
#       description = "SageMaker Application Service role"

#       managed_policies_arns = [
#         "arn:aws:iam::aws:policy/AmazonSageMakerReadOnly",
#       ]
#       policy = data.aws_iam_policy_document.sagemaker_api_operations.json
#     }
#   }

#   tags = merge(var.tags, {
#     Name = var.sagemaker_name
#   })
# }



### IMPORTANT ###
### In case we need add an extra policy (for example S3), we can create by attaching below to the profile of the team.

##
## SAGEMAKER S3
##

# data "aws_iam_policy_document" "sagemaker_s3_policy_document"{

#   statement {
#     effect = "Allow"

#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#       "s3:PutObject"
#     ]

#     resources = [
#       format("arn:aws:s3:::%s", var.bucket)
#     ]
#   }
# }

##
## AWS SAGEMAKER S3 POLICY / ATTACHMENT
##

# resource "aws_iam_policy" "sagemaker_s3_policy" {
#   name   = var.s3_policy_name
#   path   = "/"
#   policy = data.aws_iam_policy_document.sagemaker_s3_policy_document.json
# }


# resource "aws_iam_role_policy_attachment" "sagemaker_s3_iam_role_policy_attachment" {
#   role       = aws_iam_role.sagemaker_iam_role.name
#   policy_arn = aws_iam_policy.sagemaker_s3_policy.arn
# }


# variable "bucket" {
#   description = "The name of the S3 bucket"
#   type        = string
# }

# variable "s3_policy_name" {
#   description = "The name of the Execution policy"
#   type        = string
# }