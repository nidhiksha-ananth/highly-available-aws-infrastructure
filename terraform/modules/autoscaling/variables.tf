variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "private_app_subnet_ids" {
  description = "Private application subnet IDs."
  type        = list(string)
}

variable "launch_template_id" {
  description = "ID of the application launch template."
  type        = string
}

variable "min_size" {
  description = "Minimum number of EC2 instances."
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances."
  type        = number
}

variable "max_size" {
  description = "Maximum number of EC2 instances."
  type        = number
}

variable "target_group_arn" {
  description = "ARN of the application target group."
  type        = string
}

variable "target_cpu_utilization" {
  description = "Target CPU utilization percentage for the autoscaling group."
  type        = number
}