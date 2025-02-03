output "lambda_role_arn" {
  description = "The ARN of the Lambda execution IAM role."
  value       = aws_iam_role.lambda_exec.arn
}

output "lambda_role_name" {
  description = "The name of the Lambda execution IAM role."
  value       = aws_iam_role.lambda_exec.name
}
