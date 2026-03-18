provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "my_book_instance" {
    ami             = "ami-0c02fb55956c7d316"
    instance_type   =  "t3.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]

user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup python3 -m http.server 8080 &
              EOF

user_data_replace_on_change = true

tags = {
  Name = "my_book_instance"
}
}

#To allow the EC2 Instance to receive traffic on port 8080

resource "aws_security_group" "instance" {
    name = "my_book_instance"

    ingress  {
        from_port   =8080
        to_port     =8080
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