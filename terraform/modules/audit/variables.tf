variable "project_name" {
  description = "Project name used in resource names."
  type        = string
}

variable "environment" {
  description = "Environment name, for example dev."
  type        = string
}

variable "log_retention_days" {
  description = "Days to keep CloudTrail log files before S3 deletes them."
  type        = number
  default     = 30
}