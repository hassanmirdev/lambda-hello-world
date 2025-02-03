# Define variables for reusable parameters

variable "api_name" {
  description = "The name of the API Gateway."
  type        = string
  default     = "serverless_lambda_gw"
}

variable "stage_name" {
  description = "The name of the stage."
  type        = string
  default     = "serverless_lambda_stage"
}

variable "log_group_name" {
  description = "The name of the CloudWatch Log Group."
  type        = string
  default     = "/aws/api_gw/hello-world2"
}

variable "lambda_function_name" {
  description = "The Lambda function name."
  type        = string
}

variable "lambda_invoke_arn" {
  description = "The invoke ARN for the Lambda function."
  type        = string
}

variable "retention_days" {
  description = "The retention days for the CloudWatch Log Group."
  type        = number
  default     = 30
}

variable "route_key" {
  description = "The route key for the API Gateway route."
  type        = string
  default     = "GET /hello"
}
