provider "aws" {
  region = "us-east-1"

}

module "webserver_cluster" {
  source = "github.com/Mzokhulayo/terraform-aws-webserver-cluster//services/webserver-cluster?ref=v0.0.1"
  cluster_name = "webserver-prod"
  db_remote_state_bucket = "terraform-state-mzokhulayo"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t3.micro"  # can be set larger for production (eg M4.large) **free tier restrictions
  min_size = 2
  max_size = 10
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scaleout-during-business-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
  
  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size  =2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
  
  autoscaling_group_name = module.webserver_cluster.asg_name

}