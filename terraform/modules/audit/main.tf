data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  # Bucket names are global across all AWS accounts, so the account ID keeps this one unique.
  bucket_name = "${var.project_name}-${var.environment}-audit-logs-${data.aws_caller_identity.current.account_id}"
  trail_name  = "${var.project_name}-${var.environment}-trail"

  # Built as a string (not read from the trail resource) so the bucket policy
  # and the trail do not depend on each other in a circle.
  trail_arn = "arn:aws:cloudtrail:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:trail/${local.trail_name}"
}

# ---------------------------------------------------------------------------
# S3 bucket that stores the CloudTrail log files
# ---------------------------------------------------------------------------

resource "aws_s3_bucket" "logs" {
  bucket = local.bucket_name

  # Dev only: lets "terraform destroy" delete the bucket even when it contains log files.
  # Without this, a non-empty bucket blocks the destroy.
  force_destroy = true

  tags = {
    Name = local.bucket_name
  }
}

# Nothing in this bucket may ever be public.
resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Cost control: old log files are deleted automatically.
resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    filter {}

    expiration {
      days = var.log_retention_days
    }

    noncurrent_version_expiration {
      noncurrent_days = 1
    }
  }

  depends_on = [aws_s3_bucket_versioning.logs]
}

# ---------------------------------------------------------------------------
# Bucket policy: lets CloudTrail write logs, and refuses unencrypted (HTTP) access
# ---------------------------------------------------------------------------

data "aws_iam_policy_document" "logs" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.logs.arn]

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [local.trail_arn]
    }
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.logs.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [local.trail_arn]
    }
  }

  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.logs.arn,
      "${aws_s3_bucket.logs.arn}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.id
  policy = data.aws_iam_policy_document.logs.json

  depends_on = [aws_s3_bucket_public_access_block.logs]
}

# ---------------------------------------------------------------------------
# CloudTrail: records who did what in the account (API calls) for auditing
# ---------------------------------------------------------------------------

resource "aws_cloudtrail" "this" {
  name           = local.trail_name
  s3_bucket_name = aws_s3_bucket.logs.id

  include_global_service_events = true
  is_multi_region_trail         = true

  # Detects tampering: CloudTrail signs the log files so changes can be noticed.
  enable_log_file_validation = true

  depends_on = [aws_s3_bucket_policy.logs]
}