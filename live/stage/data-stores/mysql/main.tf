terraform {

  required_version = ">=1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"

    }
  }

  backend "s3" {
    bucket         = "terraform-state-mzokhulayo-us-east-1"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}


provider "aws" {
  region = "us-east-1"

}

data "aws_secretsmanager_secret" "db_credentials" {
  name = "prod/stage/db/credentials"
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}


module "mysql_Stage_db" {
  source = "../../../../modules/data-stores/mysql"

  db_name = "stage_db"
  db_username = local.db_credentials.username
  db_password = local.db_credentials.password

  backup_retention_period = 0
}

locals {
  db_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.db_credentials.secret_string
  )
}