variable "project_name" {
    description = "Name of the project."
    type = string
}

variable "environment" {
    description = "The environment for the deployment (e.g., dev, staging, prod)."
    type = string
}

variable "ami_id" {
    description = "The ID of the AMI to use for the EC2 instance."
    type = string
}

variable "instance_type" {
    description = "The type of instance to use for the EC2 instance."
    type = string
}

variable "app_security_group_id" {
    description = "The ID of the security group to associate with the EC2 instance."
    type = string
}

variable "iam_instance_profile_name" {
    description = "The name of the IAM instance profile to associate with the EC2 instance."
    type = string
}