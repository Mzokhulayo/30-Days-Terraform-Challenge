terraform {

  required_version = ">=1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "region_1"
}

###################### Multiple provider work ##############################

provider "aws" {
  region = "us-east-2"
  alias  = "region_2"
}

data "aws_region" "region_1" {
  provider = aws.region_1

}

data "aws_region" "region_2" {
  provider = aws.region_2

}

data "aws_ami" "ubuntu_region_1" {
  provider = aws.region_1

  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_region_2" {
  provider = aws.region_2

  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "region_1" {
  provider = aws.region_1

  ami           = data.aws_ami.ubuntu_region_1.id
  instance_type = "t3.micro"
}

resource "aws_instance" "aws_region_2" {
  provider = aws.region_2

  ami           = data.aws_ami.ubuntu_region_2.id
  instance_type = "t3.micro"
}


###################### Multiple provider work ##############################



resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}