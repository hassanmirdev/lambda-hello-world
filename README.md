# lambda-hello-world

Lambda Container Deployment  

Use Case Overview 

In this use case, we will demonstrate the deployment of a simple NodeJS Hello World application using AWS Lambda containers, Infrastructure as Code (IaC) with Terraform, and CI/CD pipelines with GitHub Actions.  

The application consists of a basic "Hello World" functionality. This microservice will be containerized using Docker and deployed onto AWS Lambda, leveraging AWS services such as API Gateway, ECR (Elastic Container Registry), CloudWatch for logging, and Terraform for infrastructure automation. 

The primary objective is to showcase skills in containerization, DevOps practices, and cloud deployment, using AWS to deploy and manage the application in a scalable, serverless environment. The project will involve setting up a CI/CD pipeline, provisioning AWS resources using Terraform, and implementing basic monitoring and logging. 

Target Architecture :  Lambda Function With API Gateway 

A diagram of a software application

AI-generated content may be incorrect. 

Lambda Deployment Infra: 

 

A diagram of a software development



Use Case Components: 

1. AWS Lambda 

Definition: AWS Lambda is a serverless compute service that automatically manages the compute fleet providing a balance of memory, CPU, and networking for the application. It runs code in response to events (e.g., API calls) and automatically scales with the request volume. 

 Why Used: The use of Lambda enables efficient and cost-effective serverless execution of microservices without the need to manage infrastructure. This aligns with the healthcare application's need for scalability and on-demand resource allocation. 

2. Docker 

Definition: Docker is a platform that enables developers to package applications and dependencies into containers that can run on any system. The Dockerfile defines the environment for building the containerized microservice. 

 Why Used: Docker is used to ensure consistency across development, testing, and production environments. Containerization provides a clean, isolated environment to run the Node.js microservices within AWS Lambda. 

3. Terraform (IaC - Infrastructure as Code) 

Definition: Terraform is an open-source IaC tool that allows the automation of infrastructure management using code. It provides a framework to create, update, and manage resources in AWS using declarative configuration files. 

 Why Used: Terraform is used to automate the creation of AWS infrastructure, making the deployment process repeatable and reliable. It is particularly useful for managing infrastructure across multiple environments (dev, staging, prod). 

4. AWS API Gateway 

Definition: AWS API Gateway is a fully managed service that enables developers to create and publish RESTful APIs. API Gateway provides the interface for clients (users) to interact with backend services (Lambda functions in this case). 

 Why Used: API Gateway is used to expose the Lambda functions as HTTP endpoints so the microservices can be accessed by end-users. 

5. Amazon ECR (Elastic Container Registry) 

Definition: Amazon ECR is a fully managed Docker container registry that allows users to store, manage, and deploy Docker container images. 

 Why Used: ECR is used to store the container images of the Node.js microservices. These images are then pulled by AWS Lambda to run the microservices. 

6. AWS CloudWatch 

Definition: AWS CloudWatch is a monitoring service for cloud resources and applications. It collects logs, metrics, and events to help track system health and performance. 

 Why Used: CloudWatch is used for logging and monitoring Lambda function execution, providing visibility into system performance, errors, and anomalies. 

7. GitHub Actions (CI/CD) 

Definition: GitHub Actions is an automation tool that helps developers set up continuous integration and continuous delivery pipelines directly in their GitHub repositories. 

 Why Used: GitHub Actions is used to automate workflows for infrastructure provisioning, application code deployment, Docker image building, and pushing, as well as managing Terraform operations (linting, checkov, planning, and applying). It ensures that the deployment process is consistent and automated, improving efficiency and reducing human error. 

8. IAM Roles and Security Groups 

Definition: AWS Identity and Access Management (IAM) roles and security groups are used to manage permissions and secure network access for AWS resources. 

 Why Used: IAM roles are configured to give the Lambda functions and other AWS resources the least privileges required to perform their tasks. Security groups define the network access controls for AWS resources like API Gateway and Lambda functions. 

9. S3 and DynamoDB for state locking 

Definition: S3 is used to securely store and centralize the Terraform state file, ensuring persistence and easy access. DynamoDB is used for state locking, preventing concurrent modifications to the state file during Terraform operations, ensuring consistency. 

Why: Using S3 for state storage ensures that the Terraform state is safely stored and shared across teams and environments. DynamoDB for state locking prevents multiple users from making conflicting changes to the state, ensuring consistent and reliable deployments 

 

Target Architecture and Tech Stack 

Target Architecture Overview 

The architecture is designed to be fully serverless, leveraging AWS Lambda for compute, Amazon API Gateway for HTTP access, and ECR for container storage. The overall design is modular to ensure scalability and easy management of different environments (development, staging, production). 

API Gateway is responsible for handling HTTP requests and invoking Lambda functions. 

Lambda functions are containerized microservices (Node.js applications) triggered by the API Gateway. 

ECR stores the containerized Docker images that the Lambda functions use. 

IAM Roles grant appropriate permissions for Lambda, API Gateway, and ECR interactions. 

CloudWatch provides logging and metrics for monitoring the Lambda functions. 

Terraform automates the provisioning of all AWS resources in a consistent manner across multiple environments. 

Tech Stack 

Backend: Node.js (Express.js) 

Containerization: Docker 

Cloud Provider: AWS (Lambda, API Gateway, ECR, CloudWatch, IAM, etc.) 

Infrastructure as Code: Terraform 

CI/CD: GitHub Actions 

Monitoring and Logging: AWS CloudWatch 

 

  

 

Implementation: Infra Provisioning using Terraform. 

Navigate to Infra/modules and write the configuration modules for API, ECR, IAM, Lambda. 

Navigate to the infra/environments/dev directory and configure the environment-call the modules, specific variables (e.g., AWS access keys, region). 

Initialize and apply the Terraform configuration to provision AWS resources: 

cd infra/environments/dev 
terraform init 
terraform apply 

Directory Structure 

GitHub Repo: https://github.com/hassanmirdev/lambda-hello-world.git 

├── README.md                    # Project overview and documentation 
├── app                           # Application code (microservices) 
│   ├── Dockerfile                # Defines the containerized environment for Node.js 
│   ├── hello.js                  # Microservice code (simple Hello World endpoint) 
│   ├── package.json              # Node.js dependencies 
│   └── response.json             # Example response data 
└── infra                         # Infrastructure as Code (Terraform) 
    ├── environments              # Multiple environments (dev, staging, prod) 
    │   └── dev                   # Development environment configuration 
    │       ├── backend.tf         # Backend configuration (S3, DynamoDB, etc.) 
    │       ├── main.tf            # Main Terraform configuration for the environment 
    │       ├── outputs.tf         # Outputs from Terraform deployment 
    │       ├── providers.tf       # Provider configuration (AWS) 
    │       ├── terraform.tfstate  # Terraform state file 
    │       ├── terraform.tfstate.backup # Backup state file 
    │       ├── variables.tf       # Variables specific to the environment 
    │       └── versions.tf        # Terraform versioning 
    └── modules                    # Reusable Terraform modules for different resources 
        ├── api                    # API Gateway Terraform module 
        │   ├── main.tf            # API Gateway configuration 
        │   ├── outputs.tf         # Outputs for API Gateway deployment 
        │   ├── outputs.tf.bk      # Backup of outputs 
        │   └── variables.tf       # Variables for the API Gateway module 
        ├── ecr                    # ECR Terraform module 
        │   ├── main.tf            # ECR repository configuration 
        │   ├── outputs.tf         # Outputs for ECR repository 
        │   └── variables.tf       # Variables for the ECR module 
        ├── iam                    # IAM roles and security groups module 
        │   ├── main.tf            # IAM roles and policies configuration 
        │   ├── outputs.tf         # Outputs for IAM resources 
        │   └── variables.tf       # Variables for IAM module 
        └── lambda                 # Lambda function module 
            ├── main.tf            # Lambda configuration using container images 
            ├── outputs.tf         # Outputs for Lambda deployment 
            └── variables.tf       # Variables for Lambda module 
 
  

main.tf - Infrastructure Configuration 

# Call the IAM module for creating Lambda execution role. 
 

module "iam_lambda" { 
  source = "../../modules/iam"  # Path to the IAM module 
  lambda_role_name = "serverless_lambda"  # You can customize this if needed 
} 
  

Explanation:  

This block uses the module feature in Terraform to call an IAM module that defines the IAM role for the Lambda function. This IAM role allows the Lambda function to execute with specific permissions. 

The source attribute specifies the path to the IAM module (../../modules/iam). 

The lambda_role_name defines the name of the IAM role created for the Lambda function. You can customize this if you want a different name. 

 

# Call the ECR module for creating an ECR repository 
 

module "ecr_repository" { 
  source = "../../modules/ecr"  # Path to the ECR module 
 
  ecr_repository_name = "hello-world-repo"   

} 

Explanation:  

This block uses the module feature again to create an Amazon ECR (Elastic Container Registry) repository to store the Docker image for the Lambda function. 

The ecr_repository_name is the name of the ECR repository being created, in this case, "hello-world-repo". You can customize this name as needed. 

 

# Call the Lambda module for creating a Lambda function 
 

module "lambda_function" { 
  source = "../../modules/lambda"  # Path to the Lambda module 
 
  lambda_function_name = "hello_world3"  # Lambda function name 
  lambda_image_uri     = "677276078111.dkr.ecr.us-east-1.amazonaws.com/lambda-hello-world:latest"  # ECR image URI for Lambda 
  lambda_role_arn      = module.iam_lambda.lambda_role_arn  # IAM role ARN for Lambda 
} 
  

Explanation:  

This block creates the Lambda function using the lambda module located at ../../modules/lambda. 

The lambda_function_name defines the name of the Lambda function ("hello_world3"). 

The lambda_image_uri specifies the URI of the Docker image stored in ECR that the Lambda function will use. This URI points to a specific Docker image in your ECR repository. 

The lambda_role_arn connects the Lambda function to the IAM role that was created earlier (module.iam_lambda.lambda_role_arn). 

 

 

# Call the API Gateway module for creating an API Gateway 
 

module "api_gateway" { 
  source = "../../modules/api"  # Path to the API Gateway module 
 
  api_name        = "serverless_lambda_gw"  # API Gateway name 
  route_key       = "GET /health"           # HTTP route for the API 
  lambda_invoke_arn = module.lambda_function.lambda_function_arn  # Lambda function ARN to be invoked by API 
  lambda_function_name = module.lambda_function.lambda_function_name  # Lambda function name for reference 
  log_group_name  = "/aws/api_gw/hello-world2"  # CloudWatch log group for API Gateway logs 
  retention_days  = 30  # Retention period for CloudWatch logs 
  stage_name      = "prod"  # Deployment stage for API Gateway 
} 
  

Explanation:  

This block creates an API Gateway resource that triggers the Lambda function. The api_gateway module is defined at ../../modules/api. 

The api_name specifies the name of the API Gateway ("serverless_lambda_gw"). 

The route_key defines the route of the API endpoint (GET /health), which will call the Lambda function when accessed via a browser or API client. 

The lambda_invoke_arn and lambda_function_name connect the API Gateway to the Lambda function. 

The log_group_name specifies the CloudWatch log group to store the logs generated by the API Gateway. 

The retention_days defines how long the logs will be kept in CloudWatch (30 days in this case). 

The stage_name defines the deployment stage for the API (in this case, "prod"). 

 

 

outputs.tf - Output Variables 

Defines the output variables that will be displayed after Terraform provisioning. 

output "function_name" { 
  description = "Name of the Lambda function." 
  value       = module.lambda_function.lambda_function_name 
} 
  

Explanation:  

This output variable function_name returns the name of the Lambda function that was created (module.lambda_function.lambda_function_name). 

output "lambda_function_arn" { 
  description = "ARN of the Lambda function." 
  value       = module.lambda_function.lambda_function_arn 
} 
  

Explanation:  

The lambda_function_arn output provides the ARN (Amazon Resource Name) of the Lambda function, which uniquely identifies the function in AWS. 

output "lambda_function_image_uri" { 
  description = "The ECR URI for the Lambda function image." 
  value       = module.lambda_function.lambda_image_uri 
} 
  

Explanation:  

This output returns the URI of the Docker image stored in ECR that is used by the Lambda function (module.lambda_function.lambda_image_uri). 

output "base_url" { 
  description = "Base URL for API Gateway stage." 
  value       = module.api_gateway.api_gateway_url 
} 
  

Explanation:  

This output returns the base URL of the API Gateway, which can be used to access the API endpoint (GET /health). 

 

providers.tf - AWS Provider Configuration 

Configures the AWS provider for Terraform, which specifies the region and any required authentication credentials. 

provider "aws" { 
  region  = "us-east-1"  
} 
  

Explanation:  

The AWS provider block specifies the AWS region (us-east-1) where the resources will be created. You can change this region to any other AWS region as required. 

 

versions.tf - Terraform Version Configuration 

Specifies the required Terraform version for the project. 

# This file is not provided in full, but typically it would look like: 
terraform { 
  required_version = ">= 1.0.0" 
} 
  

Explanation:  

This block specifies the version of Terraform that the code is compatible with. It ensures that the Terraform provider and modules work with the correct version of Terraform. 

 

Backend.tf 

 

terraform { 
  backend "s3" { 
    bucket         = "nsh-terraform-demo-bucket"   
    key            = "lambda-hello-world/Dev/terraform.tfstate" 
    region         = "us-east-1"             
    encrypt        = true 

   dynamodb_table = "my-terraform-lock-table" 
  } 
} 
  

terraform {: This starts the terraform block, which contains configuration for how Terraform will manage its state, among other things. 

backend "s3" {: Specifies that Terraform will use the S3 backend to store its state files. The S3 backend stores the state file in an Amazon S3 bucket. 

bucket = "nsh-terraform-demo-bucket": Defines the name of the S3 bucket where the Terraform state file will be stored. In this case, it's "nsh-terraform-demo-bucket". 

key = "lambda-hello-world/Dev/terraform.tfstate": Specifies the path (or "key") inside the S3 bucket where the Terraform state file will be saved. This is a relative path inside the S3 bucket. 

region = "us-east-1": Specifies the AWS region where the S3 bucket is located, in this case, "us-east-1". 

encrypt = true: Ensures that the Terraform state file is encrypted at rest when stored in the S3 bucket, providing additional security for sensitive information in the state file. 

dynamodb_table: This configuration tells Terraform to use a specific DynamoDB table for state locking. 

"my-terraform-lock-table": This is the name of the DynamoDB table where Terraform will create a lock to prevent concurrent changes to the state file. 

 

This configuration sets up remote state management using an S3 bucket, ensuring safe, secure, and centralized storage of the Terraform state file. 

 

 

 

Summary of Key Components 

IAM Role: Provides the necessary permissions for the Lambda function to execute. 

ECR: Stores the Docker image used by Lambda for execution. 

Lambda Function: The core compute service that runs the containerized Node.js application. 

API Gateway: Exposes the Lambda function as an HTTP endpoint, making it accessible via the web. 

Outputs: Provide critical information (Lambda name, ARN, image URI, API Gateway URL) for future use. 

AWS Provider: Specifies the region and other settings for provisioning resources. 

S3 with DynamoDB: Specify the s3 and DynamoDB table for state locking. 

 

Infra/modules 

main.tf - Lambda and CloudWatch Resources 

Defines the Lambda function and associated CloudWatch log group. 

Lambda Function Resource 

resource "aws_lambda_function" "hello_world3" { 
  function_name = var.lambda_function_name 
 
  package_type = "Image" 
  image_uri    = var.lambda_image_uri 
 
  role = var.lambda_role_arn 
} 
  

 

Explanation:  

resource "aws_lambda_function" "hello_world3": This line defines the resource type and name for the Lambda function (hello_world3). The aws_lambda_function is a built-in Terraform resource for creating AWS Lambda functions. 

function_name = var.lambda_function_name: This sets the name of the Lambda function using a variable (lambda_function_name) from the variables.tf file. By default, this will be "hello_world3", but it can be customized by changing the value in the Terraform configuration or environment. 

package_type = "Image": This specifies that the Lambda function will be deployed using a Docker image. In this case, it uses an image instead of the default zip file format for Lambda deployments. 

image_uri = var.lambda_image_uri: The image_uri is the location of the Docker image stored in Amazon ECR (Elastic Container Registry). The value comes from the lambda_image_uri variable, which points to the image ("677276078111.dkr.ecr.us-east-1.amazonaws.com/lambda-hello-world:latest" by default). 

role = var.lambda_role_arn: The role attribute specifies the ARN of the IAM role that the Lambda function will use to execute. This IAM role is defined elsewhere (likely in the IAM module) and is passed into this module as the lambda_role_arn variable. 

CloudWatch Log Group Resource 

resource "aws_cloudwatch_log_group" "hello_world3" { 
  name              = "/aws/lambda/${aws_lambda_function.hello_world3.function_name}-v2" 
  retention_in_days = var.log_group_retention_days 
} 
  

Explanation:  

resource "aws_cloudwatch_log_group" "hello_world3": This defines a CloudWatch Log Group for storing logs related to the Lambda function (hello_world3). 

name = "/aws/lambda/${aws_lambda_function.hello_world3.function_name}-v2": The name attribute defines the name of the log group. It uses the function_name of the Lambda function (aws_lambda_function.hello_world3.function_name) and appends -v2 to distinguish the version of the function logs. The log group name will be something like /aws/lambda/hello_world3-v2. 

retention_in_days = var.log_group_retention_days: This sets the retention period for the CloudWatch log group. The value is retrieved from the log_group_retention_days variable, which defaults to 30 days but can be adjusted as needed. 

 

variables.tf - Input Variables for Lambda and CloudWatch Resources 

This file defines the input variables that will be used in the main.tf file. 

variable "lambda_function_name" { 
  description = "The name of the Lambda function." 
  type        = string 
  default     = "hello_world3" 
} 
  

Explanation:  

This variable, lambda_function_name, defines the name of the Lambda function. It is a string type, and the default value is "hello_world3". This value can be customized when applying the Terraform plan. 

 

variable "lambda_image_uri" { 
  description = "The URI of the Lambda function's image stored in Amazon ECR." 
  type        = string 
  default     = "677276078111.dkr.ecr.us-east-1.amazonaws.com/lambda-hello-world:latest" 
} 
  

Explanation:  

The lambda_image_uri variable defines the URI of the Docker image used for the Lambda function. The default value points to an image stored in an ECR repository (lambda-hello-world:latest). This URI will be used in the main.tf file for the image_uri attribute in the Lambda resource. 

variable "log_group_retention_days" { 
  description = "Retention period (in days) for the CloudWatch Log Group." 
  type        = number 
  default     = 30 
} 
  

Explanation:  

The log_group_retention_days variable defines how many days CloudWatch will retain the logs for the Lambda function. The default value is set to 30 days, but it can be customized. 

variable "lambda_role_arn" { 
  description = "The ARN of the IAM role for Lambda execution." 
  type        = string 
} 
  

Explanation:  

The lambda_role_arn variable defines the ARN (Amazon Resource Name) of the IAM role that will be assigned to the Lambda function to enable it to execute. This is a required variable, so there is no default value. 

 

outputs.tf - Output Variables for Lambda and CloudWatch Resources 

This file defines the output variables that will display key information after the Terraform plan is applied. 

output "lambda_function_name" { 
  description = "The name of the Lambda function." 
  value       = aws_lambda_function.hello_world3.function_name 
} 
  

Explanation:  

This output variable provides the name of the Lambda function (aws_lambda_function.hello_world3.function_name). It allows users to easily reference the Lambda function name after Terraform has been applied. 

output "lambda_function_arn" { 
  description = "The ARN of the Lambda function." 
  value       = aws_lambda_function.hello_world3.arn 
} 
  

Explanation:  

This output variable provides the ARN of the Lambda function (aws_lambda_function.hello_world3.arn). The ARN is a unique identifier for the Lambda function that can be used for other AWS resources or monitoring purposes. 

output "log_group_name" { 
  description = "The name of the CloudWatch Log Group for the Lambda function." 
  value       = aws_cloudwatch_log_group.hello_world3.name 
} 
  

Explanation:  

This output variable provides the name of the CloudWatch Log Group associated with the Lambda function (aws_cloudwatch_log_group.hello_world3.name). This is useful for locating the logs for the Lambda function in CloudWatch. 

output "log_group_arn" { 
  description = "The ARN of the CloudWatch Log Group for the Lambda function." 
  value       = aws_cloudwatch_log_group.hello_world3.arn 
} 
  

Explanation:  

This output variable provides the ARN of the CloudWatch Log Group (aws_cloudwatch_log_group.hello_world3.arn). The ARN uniquely identifies the CloudWatch Log Group and can be used in other AWS resources or for monitoring. 

output "lambda_image_uri" { 
  description = "The URI of the Lambda function image stored in Amazon ECR." 
  value       = aws_lambda_function.hello_world3.image_uri 
} 
  

Explanation:  

This output variable provides the URI of the Docker image used for the Lambda function (aws_lambda_function.hello_world3.image_uri). This is useful for tracking the exact image version that the Lambda function is using. 

 

Summary of Key Components 

Lambda Function Resource (aws_lambda_function): 

Deploys a serverless Lambda function using a Docker image stored in ECR. 

Associates the Lambda function with an IAM role for execution. 

CloudWatch Log Group Resource (aws_cloudwatch_log_group): 

Creates a CloudWatch log group to store logs for the Lambda function. 

Defines log retention policies for CloudWatch logs. 

Input Variables: 

lambda_function_name: Lambda function name. 

lambda_image_uri: URI of the Lambda Docker image in ECR. 

log_group_retention_days: Log retention period in days for CloudWatch logs. 

lambda_role_arn: IAM role ARN for Lambda execution. 

Output Variables: 

Provides the Lambda function name, ARN, ECR image URI, and CloudWatch log group details (name and ARN). 

 

modules/api/main.tf - API Gateway Setup for Lambda Integration 

This Terraform configuration defines resources related to setting up an API Gateway and integrating it with a Lambda function. It handles the creation of the API Gateway, its stage, the integration with Lambda, routing, logging, and necessary permissions. 

 

API Gateway Setup 

resource "aws_apigatewayv2_api" "lambda" { 
  name          = var.api_name 
  protocol_type = "HTTP" 
} 
  

Explanation:  

resource "aws_apigatewayv2_api" "lambda": This defines an API Gateway resource of type aws_apigatewayv2_api. It's used to create an HTTP API Gateway that will handle HTTP requests and forward them to the Lambda function. 

name = var.api_name: The name of the API Gateway is provided by the variable api_name (passed from the calling module or environment). This allows customization of the API name. 

protocol_type = "HTTP": The protocol used by the API Gateway is HTTP, which is suitable for lightweight, low-latency applications like REST APIs. 

API Gateway Stage with Logging 

resource "aws_apigatewayv2_stage" "lambda" { 
  api_id     = aws_apigatewayv2_api.lambda.id 
  name       = var.stage_name 
  auto_deploy = true 
 
  access_log_settings { 
    destination_arn = aws_cloudwatch_log_group.api_gw.arn 
 
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
  

Explanation:  

resource "aws_apigatewayv2_stage" "lambda": This defines the stage resource for the API Gateway. A stage in API Gateway is a deployment environment (e.g., prod, dev, etc.). 

api_id = aws_apigatewayv2_api.lambda.id: This associates the API stage with the API Gateway defined in the previous resource. 

name = var.stage_name: The stage name is provided by the stage_name variable (defaulting to "prod" if not specified). This determines the environment for the API (e.g., prod, dev). 

auto_deploy = true: This setting automatically deploys the API when changes are made to the configuration, streamlining the deployment process. 

access_log_settings: This block configures the CloudWatch Logs settings for the API Gateway. It sends access logs to a CloudWatch Log Group. The jsonencode function is used to define the log format, capturing various API request/response details, such as requestId, sourceIp, httpMethod, status, etc. 

Lambda Integration with API Gateway 

resource "aws_apigatewayv2_integration" "hello_world3" { 
  api_id             = aws_apigatewayv2_api.lambda.id 
  integration_uri    = var.lambda_invoke_arn 
  integration_type   = "AWS_PROXY" 
  integration_method = "POST" 
} 
  

 

Explanation:  

resource "aws_apigatewayv2_integration" "hello_world3": This defines the integration between the API Gateway and the Lambda function. The API Gateway will proxy HTTP requests to the Lambda function. 

api_id = aws_apigatewayv2_api.lambda.id: This associates the integration with the previously defined API Gateway. 

integration_uri = var.lambda_invoke_arn: The URI for invoking the Lambda function is provided by the lambda_invoke_arn variable. This URI links the API Gateway to the Lambda function’s execution. 

integration_type = "AWS_PROXY": The integration type is set to AWS_PROXY, which allows the API Gateway to proxy requests directly to Lambda. With AWS_PROXY, the full request (including headers, body, etc.) is passed to the Lambda function. 

integration_method = "POST": The HTTP method used for the integration is POST, meaning the API Gateway will send HTTP POST requests to the Lambda function. 

API Gateway Route for Lambda Trigger 

resource "aws_apigatewayv2_route" "hello_world3" { 
  api_id   = aws_apigatewayv2_api.lambda.id 
  route_key = var.route_key 
  target   = "integrations/${aws_apigatewayv2_integration.hello_world3.id}" 
} 
  

Explanation:  

resource "aws_apigatewayv2_route" "hello_world3": This defines a route for the API Gateway, which specifies how incoming HTTP requests will be routed to the Lambda function. 

api_id = aws_apigatewayv2_api.lambda.id: This associates the route with the previously defined API Gateway. 

route_key = var.route_key: The route_key variable defines the HTTP method and the path for the route. For example, it could be GET /health. 

target = "integrations/${aws_apigatewayv2_integration.hello_world3.id}": This associates the route with the Lambda integration defined earlier. When the route is triggered, it will invoke the Lambda function. 

CloudWatch Log Group for API Gateway 

resource "aws_cloudwatch_log_group" "api_gw" { 
  name              = var.log_group_name 
  retention_in_days = var.retention_days 
} 
  

Explanation:  

resource "aws_cloudwatch_log_group" "api_gw": This defines a CloudWatch Log Group where API Gateway logs will be stored. 

name = var.log_group_name: The name of the log group is provided by the log_group_name variable. 

retention_in_days = var.retention_days: The retention period for the log group is provided by the retention_days variable. This determines how long the logs will be kept in CloudWatch. 

Lambda Permission to Allow API Gateway Invocation 

resource "aws_lambda_permission" "api_gw" { 
  statement_id  = "AllowExecutionFromAPIGateway" 
  action        = "lambda:InvokeFunction" 
  function_name = "hello_world3"  # Update Lambda function name here 
  principal     = "apigateway.amazonaws.com" 
  source_arn    = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*" 
} 
  

Explanation:  

resource "aws_lambda_permission" "api_gw": This resource grants API Gateway permission to invoke the Lambda function. 

statement_id = "AllowExecutionFromAPIGateway": The statement ID provides a unique name for this permission statement. 

action = "lambda:InvokeFunction": The action is to allow the invocation of the Lambda function. 

function_name = "hello_world3": This specifies the name of the Lambda function (hello_world3) that API Gateway will invoke. 

principal = "apigateway.amazonaws.com": The principal is API Gateway, which needs permission to invoke the Lambda function. 

source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*": This defines the source ARN for the permission. It allows API Gateway (specified by its execution ARN) to invoke the Lambda function for any route and method in the API. 

 

Outputs 

The outputs section defines the information to be displayed after the infrastructure is deployed. 

output "api_gateway_id" { 
  description = "The ID of the API Gateway." 
  value       = aws_apigatewayv2_api.lambda.id 
} 
 
output "api_gateway_url" { 
  description = "The URL of the deployed API Gateway." 
  value       = aws_apigatewayv2_api.lambda.api_endpoint 
} 
 
output "stage_name" { 
  description = "The name of the API Gateway stage." 
  value       = aws_apigatewayv2_stage.lambda.name 
} 
 
output "log_group_arn" { 
  description = "The ARN of the CloudWatch Log Group." 
  value       = aws_cloudwatch_log_group.api_gw.arn 
} 
 
output "lambda_permission_id" { 
  description = "The ID of the Lambda Permission allowing API Gateway to invoke the Lambda function." 
  value       = aws_lambda_permission.api_gw.id 
} 
  

Explanation:  

api_gateway_id: Outputs the ID of the API Gateway resource. 

api_gateway_url: Outputs the URL endpoint of the deployed API Gateway. 

stage_name: Outputs the name of the API Gateway stage (e.g., prod). 

log_group_arn: Outputs the ARN of the CloudWatch Log Group for API Gateway logs. 

lambda_permission_id: Outputs the ID of the Lambda permission resource that allows API Gateway to invoke the Lambda function. 

 

modules/variables.tf 

This file defines all the variables used in main.tf. 

 

Key Variables 

api_name: Name of the API Gateway. 

route_key: Route key for API Gateway (e.g., GET /health). 

lambda_function_name: Name of the Lambda function to integrate with API Gateway. 

lambda_invoke_arn: ARN used to invoke the Lambda function. 

log_group_name: Name of the CloudWatch Log Group for API Gateway logs. 

retention_days: Retention period for the logs in CloudWatch (default is 30 days). 

stage_name: Name of the deployment stage (default is "prod"). 

 

This concludes the explanation of the API Gateway integration module for the Lambda function in the modules/api/main.tf configuration file. It involves the creation of an HTTP API Gateway, routing requests to Lambda, enabling logging with CloudWatch, and configuring the necessary permissions for Lambda invocation. 

modules/iam/main.tf - IAM Role for Lambda Execution 

This Terraform configuration file defines the resources required to create an IAM Role that can be assumed by AWS Lambda. The role allows Lambda to execute and interact with other AWS services, as per the policies attached to it. 

 

IAM Role for Lambda Execution 

resource "aws_iam_role" "lambda_exec" { 
  name = var.lambda_role_name 
 
  assume_role_policy = jsonencode({ 
    Version = "2012-10-17" 
    Statement = [ 
      { 
        Action    = "sts:AssumeRole" 
        Effect    = "Allow" 
        Principal = { 
          Service = "lambda.amazonaws.com" 
        } 
      } 
    ] 
  }) 
} 
  

Explanation:  

resource "aws_iam_role" "lambda_exec": This resource defines an IAM role, lambda_exec, which will be used by AWS Lambda functions to gain the necessary permissions to execute. 

name = var.lambda_role_name: The name of the IAM role is provided by the lambda_role_name variable (passed from the calling module or environment). This allows customization of the role's name. 

assume_role_policy: This defines the trust policy for the role, allowing the service lambda.amazonaws.com (AWS Lambda) to assume the role. This policy specifies that only AWS Lambda can assume this role, which is necessary for Lambda functions to execute. 

The policy is encoded using jsonencode to create the appropriate JSON structure: 

Version: "2012-10-17": Specifies the version of the policy language. 

Statement: A list of policy statements that grant permission to assume the role. 

Action: "sts:AssumeRole" allows the Lambda service to assume this role. 

Effect: "Allow" grants permission. 

Principal: The principal entity (AWS service) that is allowed to assume this role. In this case, the principal is the lambda.amazonaws.com service. 

 

Outputs 

The outputs.tf file defines the outputs of the IAM resources, which allow the ARN and name of the IAM role to be accessed elsewhere in the Terraform configuration. 

output "lambda_role_arn" { 
  description = "The ARN of the Lambda execution IAM role." 
  value       = aws_iam_role.lambda_exec.arn 
} 
 
output "lambda_role_name" { 
  description = "The name of the Lambda execution IAM role." 
  value       = aws_iam_role.lambda_exec.name 
} 
  

Explanation:  

lambda_role_arn: This output returns the ARN of the IAM role created for Lambda execution. This ARN is often used when associating the role with Lambda functions. 

lambda_role_name: This output returns the name of the IAM role. It is useful when you want to refer to the name of the role for management or debugging purposes. 

 

Variables 

The variables.tf file defines the variables used in main.tf, allowing you to customize the configuration. 

variable "lambda_role_name" { 
  description = "The name of the IAM role for Lambda execution." 
  type        = string 
} 
  

Explanation:  

lambda_role_name: This variable defines the name of the IAM role for Lambda execution. It is a string type and is passed into the resource block to customize the role name. 

variable "lambda_policy_arn" { 
  description = "The ARN of the IAM policy to attach to the Lambda execution role." 
  type        = string 
  default     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" 
} 
  

Explanation:  

lambda_policy_arn: This variable specifies the ARN of the IAM policy to be attached to the Lambda execution role. By default, it is set to AWSLambdaBasicExecutionRole, which is a managed policy that provides basic Lambda execution permissions, such as writing logs to CloudWatch. 

The type = string specifies that this is a string value. You can override this default with a custom policy ARN if needed. 

 

Summary 

This module creates an IAM Role (aws_iam_role.lambda_exec) for Lambda execution with the necessary trust policy, allowing Lambda to assume the role. The role can have policies attached to it for further permissions, and outputs are provided for the role’s ARN and name. Variables are used for customizable values like the role name and policy ARN, with a default managed policy for basic Lambda execution permissions. 

 

modules/ecr/main.tf - ECR Repository for Lambda Container Image 

This Terraform configuration file defines the resources required to create an Amazon Elastic Container Registry (ECR) repository. ECR is used for storing Docker container images, which will be deployed by AWS Lambda. 

 

ECR Repository for Lambda 

resource "aws_ecr_repository" "hello_world_repo" { 
  name = var.ecr_repository_name 
} 
  

Explanation:  

resource "aws_ecr_repository" "hello_world_repo": This resource creates an ECR repository called hello_world_repo. The aws_ecr_repository resource type is used to define the repository. 

name = var.ecr_repository_name: The name of the ECR repository is provided by the ecr_repository_name variable (passed from the calling module or environment). This allows customization of the repository's name. 

 

Outputs 

The outputs.tf file defines the outputs of the ECR repository, which allow the repository URI to be accessed elsewhere in the Terraform configuration. 

output "ecr_repository_uri" { 
  description = "The URI of the ECR repository." 
  value       = aws_ecr_repository.hello_world_repo.repository_url 
} 
  

Explanation:  

ecr_repository_uri: This output returns the URI (Uniform Resource Identifier) of the created ECR repository. This URI is used to reference the repository when pushing Docker images (e.g., for Lambda) and pulling images for Lambda deployment. 

 

Variables 

The variables.tf file defines the variables used in main.tf, allowing you to customize the configuration. 

variable "ecr_repository_name" { 
  description = "The name of the ECR repository." 
  type        = string 
  default     = "ecr-lambda-repo" 
} 
  

Explanation:  

ecr_repository_name: This variable defines the name of the ECR repository. It is a string type and is passed into the resource block to customize the repository name. 

The default value is set to "ecr-lambda-repo", meaning if no custom name is provided, the default name will be used for the repository. 

 

Summary 

This module creates an ECR repository (aws_ecr_repository.hello_world_repo) that will store container images for Lambda functions. The name of the repository can be customized using the ecr_repository_name variable. The module outputs the URI of the repository, which is necessary for pushing and pulling container images. This configuration simplifies the process of storing and managing Lambda container images with ECR. 

 

 

CI/CD Setup with GitHub Actions 

Set up GitHub Actions workflows by configuring the .github/workflows directory. Ensure that your GitHub repository has the necessary secrets for AWS access. 

The pipelines will automatically trigger on PRs or merges to the main branch. 

The pipeline will perform terraform plan, create docs for review upon pull request, and apply on pr merge. 

Pefrorm tflints, checkov. 

1. terraform validate: 

Validates the syntax and structure of Terraform configuration files, ensuring they are correct and ready for use. It checks for issues such as missing variables, invalid resource definitions, and incorrect dependencies. 

2. tflint: 

TFLint is a linter for Terraform configuration files that helps identify common mistakes, misconfigurations, and best practice violations. It ensures the quality and consistency of the code before applying it. 

3. checkov: 

Checkov is a security scanner for Terraform code that analyzes infrastructure code for vulnerabilities and compliance issues. It helps identify security risks in your configurations, such as overly permissive IAM policies or insecure resource configurations. 

4. terraform plan: 

The terraform plan command creates an execution plan, outlining what actions Terraform will take to align the infrastructure with the desired state. It shows any changes, additions, or deletions to resources before applying them. 

5. Terraform Docs Generation: 

Terraform Docs generates markdown documentation for your Terraform configurations, describing variables, outputs, and resources. It helps maintain up-to-date, readable documentation directly from the codebase. 

6. PR (Pull Request): 

A PR (Pull Request) is a GitHub feature that allows proposed changes to be reviewed and merged into a target branch. It enables collaboration and approval workflows before changes are applied to production environments. 

7. terraform apply: 

The terraform apply command applies the changes described in the Terraform configuration files to the infrastructure. It provisions or updates the resources in the target environment and confirms the desired state is achieved. 

 

CI/CD Pipeline for Lambda Deployment with Terraform 

This GitHub Actions workflow automates the deployment process for a Lambda function using Terraform. It covers infrastructure provisioning, code validation, security checks, documentation generation, and applying changes to the environment.  

 

1. Triggering the Workflow 

on: 
  workflow_dispatch: 
    inputs: 
      environment: 
        description: "Choose Environments to Deploy" 
        required: true 
        default: "dev" 
        type: choice 
        options: 
          - dev 
          - staging 
          - prod 
  push: 
    branches: 
       - main 
       - master 
  pull_request: 
     branches: 
       - main 
       - master 
  

workflow_dispatch: This allows the workflow to be triggered manually from the GitHub Actions UI, where the user can choose which environment (dev, staging, or prod) to deploy to. 

push: This triggers the workflow whenever code is pushed to main or master branches. 

pull_request: This triggers the workflow when a pull request is created or updated with the target branches being main or master. 

2. Permissions 

permissions: 
  contents: read 
  pull-requests: write 
  

permissions: Defines the permissions the workflow has, specifically read access to repository contents and write access to pull requests. 

3. Terraform Job Setup 

jobs: 
  terraform: 
    name: Terraform-infra 
    runs-on: ubuntu-latest 
    env: 
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }} 
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }} 
  

terraform: This is the name of the job. 

runs-on: Specifies that the job runs on an ubuntu-latest runner. 

env: The environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are set using GitHub secrets to authenticate with AWS. 

4. Checkout the Code 

- name: Checkout Code 
  uses: actions/checkout@v3 
  

actions/checkout@v3: Checks out the code from the repository to make it available for the workflow to run. 

5. Setting up Terraform 

- name: Set up Terraform 
  uses: hashicorp/setup-terraform@v2 
  with: 
    terraform_version: 1.5.5 
  

hashicorp/setup-terraform@v2: Installs the specified version (1.5.5) of Terraform on the runner. 

6. Installing and Running TFLint (Terraform Linter) 

- name: Install TFLint 
  run: | 
    TFLINT_VERSION="v0.55.0" 
    curl -sL "https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip" -o tflint.zip 
    unzip tflint.zip 
    chmod +x tflint 
    sudo mv tflint /usr/local/bin/ 
    rm tflint.zip 
  

Installs TFLint: Downloads and installs the TFLint linter tool that helps in identifying issues in Terraform configurations. 

- name: Run TFLint 
  run: | 
    cd ./infra/environments/${{ github.event.inputs.environment || 'dev' }} 
    tflint --init 
    tflint --config .tflint.hcl 
  

tflint --init: Initializes TFLint configuration. 

tflint: Runs TFLint to check for issues in Terraform configuration files. 

7. Install and Run Checkov (Security Scanner) 

- name: Install Checkov 
  run: | 
    pip install checkov 
    checkov --version 
  

Install Checkov: Installs Checkov, a security tool to scan the Terraform configuration for potential security issues. 

- name: Run Checkov 
  run: | 
    cd ./infra/environments/${{ github.event.inputs.environment || 'dev' }} 
    checkov --directory . --skip-check CKV_AWS_*,CKV2_AWS_* 
  

Run Checkov: Scans the Terraform code for security risks while skipping some AWS-specific checks. 

8. Terraform Initialization and Validation 

- name: Terraform Init 
  run: |  
    cd ./infra/environments/${{ github.event.inputs.environment || 'dev' }} 
    terraform init 
  

terraform init: Initializes Terraform, setting up the working directory for usage, including plugins and backend configuration. 

- name: Terraform Validate 
  run: | 
    cd ./infra/environments/${{ github.event.inputs.environment || 'dev' }} 
    terraform validate 
  

terraform validate: Validates the Terraform configuration files to ensure they are syntactically correct. 

9. Terraform Plan 

- name: Terraform Plan 
  run: | 
    cd ./infra/environments/${{ github.event.inputs.environment || 'dev' }} 
    terraform plan 
  

terraform plan: Previews the changes that will be made to the infrastructure by Terraform, allowing you to review them before applying. 

10. Generating Documentation and Comments for PRs 

- name: Generate Markdown with Terraform Docs 
  uses: terraform-docs/gh-actions@v1.3.0 
  with: 
    working-dir: ./infra/environments/${{ github.event.inputs.environment || 'dev' }} 
    output-file: README.md 
    output-method: inject 
    git-push: true 
    config-file: .terraform-docs.yml 
  

terraform-docs: Generates markdown documentation for the Terraform configuration and injects it into the README.md file. It then pushes the changes to the repository. 

- name: Post README.md as PR Comment 
  uses: marocchino/sticky-pull-request-comment@v2.9.0 
  with: 
    github_token: ${{ secrets.GITHUB_TOKEN }} 
    header: "Terraform Documentation " 
    path: "./infra/environments/${{ github.event.inputs.environment || 'dev' }}/README.md" 
  

Post the README.md: Adds the generated Terraform documentation as a comment to the pull request for easy reference. 

11. Apply Terraform Changes on Merge 

- name: Apply Terraform on Merge the PR 
  run: | 
    cd ./infra/environments/${{ github.event.inputs.environment || 'dev' }} 
    terraform init 
    terraform apply -auto-approve 
  

terraform apply: If the pull request is merged, this step applies the changes to the infrastructure automatically, provisioning the resources as described in the Terraform configuration. 

 

Summary of the Workflow: 

Code Checkout: Retrieves the latest code from the repository. 

Install Dependencies: Installs tools like Terraform, TFLint, and Checkov for linting and security checks. 

Run Terraform Commands: Validates, plans, and applies the infrastructure changes. 

Generate and Post Documentation: Generates markdown documentation for Terraform resources and posts it as a PR comment. 

Apply Terraform Changes: Deploys the infrastructure changes if the PR is merged to the main branch. 

This CI/CD pipeline automates the infrastructure provisioning process, ensuring proper checks, security scans, and up-to-date documentation before changes are applied to AWS. 

 

 

 

 

 

 

 

 

 

Infrastructure Destruction: destroy.yml 
name: Destroy Lambda Infra With Terraform. 

on: workflow_dispatch: # Manually trigger the workflow inputs: environment: description: " Select Environment to Destroy (e.g., dev, staging, prod)" required: true default: "dev" type: choice options: - dev - staging - prod 

jobs: destroy: name: Destroy Terraform Resources runs-on: ubuntu-latest 

# Define environment variables once for the whole job 
env: 
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }} 
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }} 
 
steps: 
  - name: Checkout Repository 
    uses: actions/checkout@v3 
 
  - name: Set up Terraform 
    uses: hashicorp/setup-terraform@v2 
    with: 
      terraform_version: 1.5.5 
 
  - name: Terraform Init 
    run: |  
      cd infra/environments/${{ github.event.inputs.environment || 'dev' }} 
      terraform init 
 
  - name: Destroy Resources 
    run: | 
      cd infra/environments/${{ github.event.inputs.environment || 'dev' }} 
      terraform destroy -auto-approve 
 

 

Destroy Lambda Infra With Terraform GitHub Actions workflow: 

1. Workflow Trigger (on): 

workflow_dispatch: This section allows the workflow to be manually triggered via GitHub's UI. It defines an input called environment, where users can select which environment to target for destroying the infrastructure. The options are:  

dev 

staging 

prod 

The default value is set to dev, and it's marked as required, meaning the user has to select an option before running the workflow. 

2. Job Definition (jobs): 

destroy job: This is the main job responsible for destroying the resources created by Terraform. It runs on the ubuntu-latest virtual machine. 

Environment Variables: 

AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are set as environment variables for the job using GitHub Secrets. This allows Terraform to authenticate and interact with AWS resources securely during the process. 

3. Steps within the Job: 

The following steps are defined to carry out the infrastructure destruction using Terraform: 

Step 1: Checkout Repository: 

uses: actions/checkout@v3: This step checks out the code from the repository to the virtual machine, ensuring the workflow has access to the Terraform configuration files in the repository. 

Step 2: Set up Terraform: 

uses: hashicorp/setup-terraform@v2: This step sets up the specified version (1.5.5) of Terraform on the runner. This is needed so that the subsequent Terraform commands can be executed. 

Step 3: Terraform Init: 

run: terraform init: This step initializes Terraform by running terraform init. It configures the backend (where the state is stored), installs the necessary provider plugins, and sets up the environment for executing Terraform commands. The cd command changes the working directory to the infra/environments/${{ github.event.inputs.environment || 'dev' }} folder based on the selected environment (dev by default). 

Step 4: Destroy Resources: 

run: terraform destroy -auto-approve: This step runs terraform destroy, which will destroy the infrastructure defined in the Terraform configuration. The -auto-approve flag is used to skip the interactive approval step, so it automatically proceeds with resource destruction without needing manual confirmation. Again, the cd command ensures it targets the correct environment directory. 

Summary: 

This workflow is used to destroy Terraform-managed infrastructure in a specified environment (dev, staging, or prod). It includes steps for checking out the code, setting up Terraform, initializing it, and finally running the destroy command to clean up the resources. 

 

 

 

 

 

Implementation outputs: Lambda Function Creation 

 

 

Implementation outputs: Lambda Function Execution 

 

 

Implementation: Application Output using API GatewayImplementation: API Gateway 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

Implementation: CloudWatch Log Group 

 

 

 

 

 

 

 

 

 

 

 

 
