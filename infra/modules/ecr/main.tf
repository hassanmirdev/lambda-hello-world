resource "aws_ecr_repository" "hello_world_repo" {
  name = var.ecr_repository_name
}

output "ecr_repository_uri" {
  description = "The URI of the ECR repository."
  value       = aws_ecr_repository.hello_world_repo.repository_url
}
