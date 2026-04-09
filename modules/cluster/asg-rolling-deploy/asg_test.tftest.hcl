mock_provider "aws" {
  alias = "mock"
}

variables {
  cluster_name       = "test-cluster"
  instance_type      = "t3.micro"
  min_size           = 1
  max_size           = 2
  enable_autoscaling = false
  subnet_ids         = ["subnet-12345"]
}

run "validate_cluster_name" {
  command = plan

  assert {
    condition     = aws_autoscaling_group.example.name == "test-cluster"
    error_message = "ASG name must match the cluster_name variable"
  }
}

run "validate_min_size" {
  command = plan

  assert {
    condition     = aws_autoscaling_group.example.min_size == 1
    error_message = "ASG min_size must match the min_size variable"
  }
}