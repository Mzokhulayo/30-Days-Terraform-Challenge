# terraform-aws-webserver-cluster

A reusable Terraform module that deploys a highly available web server cluster on AWS using an Auto Scaling Group behind an Application Load Balancer.

## Usage
```hcl
module "webserver_cluster" {
  source = "github.com/Mzokhulayo/terraform-aws-webserver-cluster//services/webserver-cluster?ref=v0.0.2"

  cluster_name           = "webservers-dev"
  instance_type          = "t3.micro"
  min_size               = 2
  max_size               = 4
  db_remote_state_bucket = "your-state-bucket"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
}
```

## Inputs

| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| cluster_name | string | none | yes | Name for all cluster resources |
| instance_type | string | none | yes | EC2 instance type |
| min_size | number | none | yes | Minimum ASG instances |
| max_size | number | none | yes | Maximum ASG instances |
| db_remote_state_bucket | string | none | yes | S3 bucket for DB remote state |
| db_remote_state_key | string | none | yes | S3 key for DB remote state |
| server_port | number | 8080 | no | Port the server listens on |
| ami_id | string | ami-0c02fb55956c7d316 | no | AMI ID for EC2 instances |

## Outputs

| Name | Description |
|------|-------------|
| alb_dns_name | DNS name of the load balancer |
| asg_name | Name of the Auto Scaling Group |
| alb_security_group_id | Security group ID of the ALB |
| instance_type | Instance type used in the cluster |

## Known Limitations

- AMI ID default is only valid in us-east-1. Override ami_id when deploying to other regions.
- Requires an existing RDS instance with outputs exposed via remote state.
- Uses the default VPC and subnets. For custom VPCs pass subnet IDs as a variable.