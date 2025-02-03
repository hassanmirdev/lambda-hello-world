resource "aws_iam_role" "lambda_exec" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Sid       = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = var.lambda_policy_arn
}

output "lambda_role_arn" {
  description = "The ARN of the Lambda execution IAM role."
  value       = aws_iam_role.lambda_exec.arn
}

output "lambda_role_name" {
  description = "The name of the Lambda execution IAM role."
  value       = aws_iam_role.lambda_exec.name
}
