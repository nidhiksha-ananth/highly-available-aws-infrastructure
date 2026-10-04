variable "project_name" {
    description = "Project name used for resource naming and tagging"
    type = string
}

variable "environment" {
    description = "The environment for the deployment (e.g., dev, staging, prod)"
    type = string
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}

variable "availability_zones" {
    description = "List of availability zones to use for subnets"
    type = list(string)
}

variable "public_subnet_cidrs" {
    description = "List of CIDR blocks for public subnets"
    type = list(string)
}

variable "private_app_subnet_cidrs" {
    description = "List of CIDR blocks for private application subnets"
    type = list(string)
}

variable "private_db_subnet_cidrs" {
    description = "List of CIDR blocks for private database subnets"
    type = list(string)
}