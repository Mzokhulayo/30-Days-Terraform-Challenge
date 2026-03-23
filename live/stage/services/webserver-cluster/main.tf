terraform {
  backend "s3" {
    bucket         = "terraform-state-mzokhulayo"
    key            = "stage/data-stores/webserver-cluster/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "github.com/Mzokhulayo/terraform-aws-webserver-cluster//services/webserver-cluster?ref=v0.0.2"

  cluster_name = "webserver-stage"
  db_remote_state_bucket = "terraform-state-mzokhulayo"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t3.micro"
  min_size = 2
  max_size = 2
}