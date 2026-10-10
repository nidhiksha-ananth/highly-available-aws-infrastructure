variable "project_name" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "The environment for the deployment."
  type        = string
}

variable "private_db_subnet_ids" {
  description = "List of private subnet IDs for the RDS instances"
  type        = list(string)
}

variable "db_security_group_id" {
  description = "Security group ID for the RDS instances"
  type        = string
}