output "alb_dns_name" {
  value       = aws_alb.example.dns_name
  description = "The domain name of the load balancer"
}

output "asg_name" {
  value       = aws_autoscaling_group.example.name
  description = "The Name of the Auto scaling Group"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The Id of the security Group attached to the load balancer"
}

output "instance_type" {
  value       = var.instance_type
  description = "The instance type used in the cluster"
}

