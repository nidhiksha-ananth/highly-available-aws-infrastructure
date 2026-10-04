output "cpu_alarm_name" {
  description = "CloudWatch alarm name for high CPU utilization."
  value       = aws_cloudwatch_metric_alarm.app_cpu_high.alarm_name
}