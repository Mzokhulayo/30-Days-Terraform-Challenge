terraform {
backend "s3" {
bucket = "terraform-state-mzokhulayo-us-east-1"
key = "stage/data-stores/mysql/terraform.tfstate"
region = "us-east-1"
dynamodb_table = "terraform-up-and-running-locks"
encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_secretsmanager_secret" "db_credentials" {
  name = "prod/stage/db/credentials"
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = "prod/stage/db/credentials"
}

locals {
  db_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.db_credentials.secret_string
  )
}

resource "aws_db_instance" "example" {
  identifier_prefix = "terraform-up-and-running"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t3.micro"
  skip_final_snapshot = true
  db_name = var.db_name

  username = local.db_credentials.username
  password = local.db_credentials.password
}