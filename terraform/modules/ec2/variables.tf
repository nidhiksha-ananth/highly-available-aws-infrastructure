variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "ami_id" {
  description = "AMI ID used for application EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used for application instances."
  type        = string
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile attached to EC2 instances."
  type        = string
}

variable "app_security_group_id" {
  description = "Security group ID for application EC2 instances."
  type        = string
}