
output "stage_db_address" {
  value       = module.mysql_Stage_db.address
  description = "Connect to the stage database"
}
output "stage_db_port" {
value = module.mysql_Stage_db.port
description = "The port the primary database is listening on"
}
output "db_arn" {
value = module.mysql_Stage_db.arn
description = "The ARN of the primary database"
}
