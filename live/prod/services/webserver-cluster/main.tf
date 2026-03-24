provider "aws" {
  region = "us-east-1"

}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"
  cluster_name = "webserver-prod"
  db_remote_state_bucket = "terraform-state-mzokhulayo"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t3.micro"  # can be set larger for production (eg M4.large) **free tier restrictions
  min_size = 2
  max_size = 10
  enable_autoscaling = true

  custom_tags = {
    Owner = "team-foo"
    ManagedBy = "terraform"

  }
}
