# Call the IAM module for creating Lambda execution role
module "iam_lambda" {
  source            = "../../modules/iam"
  lambda_role_name  = "serverless_lambda"  # Customize if needed
  lambda_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Call the ECR module for creating an ECR repository
module "ecr_repository" {
  source               = "../../modules/ecr"
  ecr_repository_name  = "hello-world-repo"  # Customize if needed
}

# Call the Lambda module for creating a Lambda function
module "lambda_function" {
  source                 = "../../modules/lambda"
  lambda_function_name   = "hello-world2"  # Customize if needed
  lambda_image_uri       = module.ecr_repository.ecr_repository_uri
  lambda_role_arn        = module.iam_lambda.lambda_role_arn
}

# Call the API Gateway module for creating an API Gateway
module "api_gateway" {
  source                = "../../modules/api"
  api_name              = "serverless_lambda_gw"
  route_key             = "GET /hello"
  lambda_arn            = module.lambda_function.lambda_function_arn
  lambda_role_arn       = module.iam_lambda.lambda_role_arn
}


