# Variables file for defining configurable parameters

# Lambda function name
variable "lambda_function_name" {
  description = "The name of the Lambda function."
  type        = string
  default     = "hello-world2"
}

# Image URI for the Lambda function (stored in Amazon ECR)
variable "lambda_image_uri" {
  description = "The URI of the Lambda function's image stored in Amazon ECR."
  type        = string
  default     = "677276078111.dkr.ecr.us-east-1.amazonaws.com/hello-world2:latest"
}

# CloudWatch Log Group retention in days
variable "log_group_retention_days" {
  description = "Retention period (in days) for the CloudWatch Log Group."
  type        = number
  default     = 30
}
