resource "aws_launch_template" "app" {
  name = "${var.project_name}-${var.environment}-app"

  image_id      = var.ami_id
  instance_type = var.instance_type

  update_default_version = true

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  vpc_security_group_ids = [
    var.app_security_group_id
  ]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp3"
      encrypted = true
    }
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf install -y nginx

    systemctl enable nginx
    systemctl start nginx

    echo "<h1>Highly Available AWS Application</h1>" > /usr/share/nginx/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-${var.environment}-app"
    }
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-app"
  }
}