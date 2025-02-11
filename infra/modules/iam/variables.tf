variable "lambda_role_name" {
  description = "The name of the IAM role for Lambda execution."
  type        = string
  default     = "serverless_lambda"
}

variable "lambda_policy_arn" {
  description = "The ARN of the IAM policy to attach to the Lambda execution role."
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
variable "api_name" {

}

variable "retention_days" {
  description = "Retention period in days for CloudWatch logs"
  type        = number
  default     = 30  # Adjust this value based on your preference
}

variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
  default     = "my-api"  # Set a default name or pass it dynamically
}

variable "log_group_name" {
  description = "The name of the CloudWatch Log Group"
  type        = string
  default     = "api-gateway-log-group"  # Set a default log group name or pass dynamically
}
