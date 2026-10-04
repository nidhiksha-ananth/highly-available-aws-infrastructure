resource "aws_launch_template" "app" {
  name = "${var.project_name}-${var.environment}-app"

  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  vpc_security_group_ids = [
    var.app_security_group_id
  ]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx

    systemctl enable nginx
    systemctl start nginx

    echo "<h1>Highly Available AWS Application</h1>" > /usr/share/nginx/html/index.html
  EOF
  )

  tags = {
    Name = "${var.project_name}-${var.environment}-app"
  }
}