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
    key            = "prod/data-stores/mysql/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}


provider "aws" {
  region = "us-east-1"
  alias = "primary"
}

provider "aws" {
  region = "us-west-1"
  alias = "replica"
}

data "aws_secretsmanager_secret" "db_credentials" {
  provider = aws.primary
  name = "prod/stage/db/credentials"
}

data "aws_secretsmanager_secret_version" "db_credentials" {
  provider = aws.primary
  # secret_id = "prod/stage/db/credentials"
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}


module "mysql_primary" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.primary
  }

  db_name = "prod_db"
  db_username = local.db_credentials.username
  db_password = local.db_credentials.password

  # must be enabled to support replication
  backup_retention_period = 1
}

module "mysql_replica" {
  source = "../../../../modules/data-stores/mysql"

  providers = {
    aws = aws.replica
  }

  # make this a replica of the primary
  replicate_source_db = module.mysql_primary.arn
}


locals {
  db_credentials = jsondecode(
    data.aws_secretsmanager_secret_version.db_credentials.secret_string
  )
}