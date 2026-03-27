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
  # region = "us-east-1"
  region  ="us-east-1"
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  ami ="ami-0c02fb55956c7d316"
  server_text = "Hello World v-1"

  cluster_name = "webserver-stage"
  db_remote_state_bucket = "terraform-state-mzokhulayo"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"

  instance_type = "t3.micro"
  min_size = 2
  max_size = 2
  enable_autoscaling = false
}