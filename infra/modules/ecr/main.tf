# ECR Repository for the Lambda function image
resource "aws_ecr_repository" "hello_world_repo" {
  name = var.ecr_repository_name
}
