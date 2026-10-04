variable "project_name" {
    description = "Project name used for IAM resource naming."
    type = string
}

variable "environment" {
    description = "The environment for the deployment (e.g., dev, staging, prod)."
    type = string
}