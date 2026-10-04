module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_app_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  private_db_subnet_cidrs = [
    "10.0.21.0/24",
    "10.0.22.0/24"
  ]
}

module "security_groups" {
  source = "../../modules/security_groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

module "ec2" {
  source = "../../modules/ec2"

  project_name = var.project_name
  environment  = var.environment

  ami_id        = var.ami_id
  instance_type = var.instance_type

  app_security_group_id     = module.security_groups.app_security_group_id
  iam_instance_profile_name = module.iam.ec2_instance_profile_name
}

module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids

  alb_security_group_id = module.security_groups.alb_security_group_id
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name = var.project_name
  environment  = var.environment

  private_app_subnet_ids = module.vpc.private_app_subnet_ids
  launch_template_id     = module.ec2.launch_template_id

  min_size         = 2
  desired_capacity = 2
  max_size         = 4

  target_group_arn = module.alb.target_group_arn

  target_cpu_utilization = 50
}

module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  db_security_group_id  = module.security_groups.db_security_group_id
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  project_name = var.project_name
  environment  = var.environment

  autoscaling_group_name = module.autoscaling.autoscaling_group_name
}