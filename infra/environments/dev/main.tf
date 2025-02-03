provider "aws" {
  region = "us-east-1" 
}

# Call the IAM module for creating Lambda execution role
module "iam_lambda" {
  source = "../../iam"  # Path to the IAM module

  lambda_role_name = "serverless_lambda"  # You can customize this if needed
}

# Call the ECR module for creating an ECR repository
module "ecr_repository" {
  source = "../../ecr"  # Path to the ECR module

  ecr_repository_name = "hello-world-repo"  # You can customize this if needed
}

# Call the Lambda module for creating a Lambda function
module "lambda_function" {
  source = "../../lambda"  # Path to the Lambda module

  lambda_function_name = "hello-world2"
  lambda_image_uri  "677276078111.dkr.ecr.us-east-1.amazonaws.com/hello-world2:latest"
 # lambda_image_uri     = "${module.ecr_repository.ecr_repository_uri}:latest"  # Using ECR URI for the Lambda image
  lambda_role_arn      = module.iam_lambda.lambda_role_arn
}

# Call the API Gateway module for creating an API Gateway
module "api_gateway" {
  source = "../../api"  # Path to the API Gateway module

  api_name      = "serverless_lambda_gw"
  route_key     = "GET /hello"
  lambda_arn    = module.lambda_function.lambda_function_arn
  lambda_role_arn = module.iam_lambda.lambda_role_arn
}
