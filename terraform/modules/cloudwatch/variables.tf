variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "The environment for the deployment."
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the autoscaling group."
  type        = string
}