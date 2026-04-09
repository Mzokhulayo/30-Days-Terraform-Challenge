output "alb_dns_name" {
  value       = module.Hello_world_app.alb_dns_name
  description = "The domain name of the load balancer"
}