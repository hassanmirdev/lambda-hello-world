variable "lambda_role_name" {
  description = "The name of the IAM role for Lambda execution."
  type        = string

}

variable "lambda_policy_arn" {
  description = "The ARN of the IAM policy to attach to the Lambda execution role."
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

variable "retention_days" {
  description = "Retention period for CloudWatch logs"
  type        = number
}

variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type        = string
}

variable "lambda_role_name" {
  description = "Name of the Lambda execution role"
  type        = string
}
