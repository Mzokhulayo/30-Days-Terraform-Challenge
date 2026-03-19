provider "aws" {
    region = var.aws_region
}

# resource "aws_instance" "my_book_instance" {
#     ami             = var.ami_id
#     instance_type   = var.instance_type
#     vpc_security_group_ids = [aws_security_group.instance.id]

# user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, World" > index.html
#               nohup python3 -m http.server ${var.server_port} &
#               EOF

# user_data_replace_on_change = true

# tags = {
#   Name = var.app_name
# }
# }

#To allow the EC2 Instance to receive traffic on port 8080

resource "aws_security_group" "instance" {
    name = var.app_name

    ingress  {
        from_port   =var.server_port
        to_port     =var.server_port
        protocol    ="tcp"
        cidr_blocks  =["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.default.id]
    }
}