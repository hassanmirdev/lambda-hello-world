resource "aws_lambda_function" "hello_world2" {
  function_name = "hello-world2"

  package_type = "Image"
  image_uri    = "677276078111.dkr.ecr.us-east-1.amazonaws.com/hello-world2:latest"

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_cloudwatch_log_group" "hello_world2" {
  name = "/aws/lambda/${aws_lambda_function.hello_world2.function_name}-v2"  # New log group name with a suffix

  retention_in_days = 30
}

