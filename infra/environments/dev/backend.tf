terraform {
  backend "s3" {
    bucket         = "nsh-terraform-demo-bucket"  
    key            = "lambda-hello-world/Dev/terraform.tfstate"
    region         = "us-east-1"            
    encrypt        = true
  }
}
