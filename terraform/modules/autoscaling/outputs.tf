output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group."
  value       = aws_autoscaling_group.app.name
}