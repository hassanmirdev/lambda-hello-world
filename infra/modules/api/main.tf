# Creates an HTTP API Gateway with the specified name
resource "aws_apigatewayv2_api" "lambda" {
  name          = var.api_name
  protocol_type = "HTTP"
}

# Creates an API Gateway stage with CloudWatch logging for the API requests
resource "aws_apigatewayv2_stage" "lambda" {
  api_id     = aws_apigatewayv2_api.lambda.id
  name       = var.stage_name
  auto_deploy = true  # Automatically deploy the API stage when changes occur

  # Configures access logs for the API Gateway
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn  # Logs sent to CloudWatch Log Group
    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
    })
  }
}

# Integrates the Lambda function with the API Gateway using AWS_PROXY integration type
resource "aws_apigatewayv2_integration" "hello_world3" {
  api_id             = aws_apigatewayv2_api.lambda.id
  integration_uri    = var.lambda_invoke_arn  # ARN of the Lambda function to be invoked
  integration_type   = "AWS_PROXY"  # The API Gateway forwards the entire HTTP request to Lambda
  integration_method = "POST"  # HTTP method used for invoking the Lambda function
}

# Creates a route in the API Gateway to trigger the Lambda function
resource "aws_apigatewayv2_route" "hello_world3" {
  api_id   = aws_apigatewayv2_api.lambda.id
  route_key = var.route_key  # Defines the HTTP method and resource path (e.g., GET /hello)
  target   = "integrations/${aws_apigatewayv2_integration.hello_world3.id}"  # Binds the route to the Lambda integration
}

# Creates a CloudWatch Log Group to store API Gateway access logs
resource "aws_cloudwatch_log_group" "api_gw" {
  name              = var.log_group_name  # Log group name
  retention_in_days = var.retention_days  # Retention period for logs
}

# Grants API Gateway permission to invoke the Lambda function
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"  # Unique statement ID
  action        = "lambda:InvokeFunction"  # Permission to invoke the Lambda function
  function_name = "hello_world3"  # The Lambda function name
  principal     = "apigateway.amazonaws.com"  # Principal (API Gateway)
  source_arn    = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"  # The ARN of the API Gateway to allow invocation
}
