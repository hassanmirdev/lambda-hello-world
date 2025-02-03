# Outputs file to expose resource information

# Output the Lambda function name
output "lambda_function_name" {
  description = "The name of the Lambda function."
  value       = aws_lambda_function.hello_world2.function_name
}

# Output the Lambda function ARN
output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = aws_lambda_function.hello_world2.arn
}

# Output the CloudWatch Log Group name
output "log_group_name" {
  description = "The name of the CloudWatch Log Group for the Lambda function."
  value       = aws_cloudwatch_log_group.hello_world2.name
}

# Output the CloudWatch Log Group ARN
output "log_group_arn" {
  description = "The ARN of the CloudWatch Log Group for the Lambda function."
  value       = aws_cloudwatch_log_group.hello_world2.arn
}
