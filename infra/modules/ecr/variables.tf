# Variables file for defining configurable parameters

# ECR repository name
variable "ecr_repository_name" {
  description = "The name of the ECR repository."
  type        = string
  default     = "hello-world-repo"
}
