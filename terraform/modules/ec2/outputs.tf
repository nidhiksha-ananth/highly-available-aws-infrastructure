output "launch_template_id" {
  description = "ID of the application launch template."
  value       = aws_launch_template.app.id
}