provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      project     = var.project_name
      environment = var.environment
      managed_by  = "Terraform"
    }
  }
}