variable "aws_region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "highly-available-aws"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "ami_id" {
  description = "AMI ID used for application EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used for application instances."
  type        = string
  default     = "t3.micro"
}

variable "target_cpu_utilization" {
  description = "Target CPU utilization percentage for the autoscaling group."
  type        = number
}