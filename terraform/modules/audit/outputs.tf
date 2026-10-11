output "log_bucket_name" {
  description = "Name of the S3 bucket that holds the CloudTrail logs."
  value       = aws_s3_bucket.logs.id
}

output "cloudtrail_arn" {
  description = "ARN of the CloudTrail trail."
  value       = aws_cloudtrail.this.arn
}