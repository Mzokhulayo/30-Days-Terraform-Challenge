# resource "aws_launch_configuration" "example" {
#     image_id = var.ami_id
#     instance_type = var.instance_type
#     security_groups = [aws_security_group.instance.id]

#     user_data = <<-EOF
#                 #!/bin/bash
#                 echo "Hello, World" > index.html
#                 nohup busybox httpd -f -p ${var.server_port} &
#                 EOF
    
#     # Required when using a launch configuration with an auto scaling group.
#     lifecycle {
#       create_before_destroy = true
#     }
# }

resource "aws_launch_template" "example" {
  name_prefix   = "terraform-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup python3 -m http.server ${var.server_port} &
              EOF
  )

# Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_template {
    id = aws_launch_template.example.id
    version = "$Latest"
  }

  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 5

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true
  }
}