output "alb_dns_name" {
  value       = module.Hello_world_app.alb_dns_name
  description = "The domain name of the load balancer"
}

output "instance_security_group_id" {
  value       = module.Hello_world_app.instance_security_group_id
  description = "The ID of the EC2 Instance Security Group"
}