resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "${var.project_name}-${var.environment}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier        = "${var.project_name}-${var.environment}-db-instance"
  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true
  engine            = "postgres"
  engine_version    = "16"
  instance_class    = "db.t3.micro"
  db_name           = "appdb"
  username          = "appuser"

  manage_master_user_password = true

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [var.db_security_group_id]

  publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name = "${var.project_name}-${var.environment}-db-instance"
  }
}