output "db_instance_identifier" {
  value = aws_db_instance.this.identifier
}

output "db_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "db_port" {
  value = aws_db_instance.this.port
}