# Creates a Lambda function with the specified Docker image URI and role for execution
resource "aws_lambda_function" "hello_world3" {
  function_name = var.lambda_function_name

  package_type = "Image"
  image_uri    = var.lambda_image_uri

  role = var.lambda_role_arn
}

# Creates a CloudWatch Log Group to store logs for the Lambda function with defined retention period
resource "aws_cloudwatch_log_group" "hello_world3" {
  name              = "/aws/lambda/${aws_lambda_function.hello_world3.function_name}-v2"
  retention_in_days = var.log_group_retention_days
}
