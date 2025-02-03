# Outputs file to expose resource information

# Output the ECR repository URI
output "ecr_repository_uri" {
  description = "The URI of the ECR repository."
  value       = aws_ecr_repository.hello_world_repo.repository_url
}
