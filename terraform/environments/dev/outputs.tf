output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = module.vpc.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "Private application subnet IDs."
  value       = module.vpc.private_app_subnet_ids
}

output "private_db_subnet_ids" {
  description = "Private database subnet IDs."
  value       = module.vpc.private_db_subnet_ids
}

output "alb_security_group_id" {
  description = "ALB security group ID."
  value       = module.security_groups.alb_security_group_id
}

output "app_security_group_id" {
  description = "Application security group ID."
  value       = module.security_groups.app_security_group_id
}

output "db_security_group_id" {
  description = "Database security group ID."
  value       = module.security_groups.db_security_group_id
}

output "ec2_instance_profile_name" {
  description = "IAM instance profile name for EC2."
  value       = module.iam.ec2_instance_profile_name
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = module.alb.alb_dns_name
}

output "db_instance_identifier" {
  description = "RDS database identifiers."
  value       = module.rds.db_instance_identifier
}

output "db_instance_endpoint" {
  description = "RDS database endpoints."
  value       = module.rds.db_endpoint
}

output "target_group_arn" {
  description = "ARN of the application target group."
  value       = module.alb.target_group_arn
}