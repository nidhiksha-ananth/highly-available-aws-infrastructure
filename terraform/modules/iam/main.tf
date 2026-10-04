resource "aws_iam_role" "ec2" {
    name = "${var.project_name}-${var.environment}-ec2-role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"

        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })

    tags = {
        Name        = "${var.project_name}-${var.environment}-ec2-role"
    }
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
    role       = aws_iam_role.ec2.name
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2" {
    name = "${var.project_name}-${var.environment}-ec2-profile"
    role = aws_iam_role.ec2.name
}