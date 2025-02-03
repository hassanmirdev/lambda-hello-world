output "function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.hello_world2.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function."

  value = aws_lambda_function.hello_world2.arn
}

output "lambda_function_image_uri" {
  description = "The ECR URI for the Lambda function image."

  value = aws_lambda_function.hello_world2.image_uri
}
output "base_url" {
  description = "Base URL for API Gateway stage."

  value = aws_apigatewayv2_stage.lambda.invoke_url
}

