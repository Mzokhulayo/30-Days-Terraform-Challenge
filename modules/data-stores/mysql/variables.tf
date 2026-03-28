
variable "backup_retention_period" {
  description = "Days to retain backups. Must be > 0 to enable replication"
  type = number
  default = null
}

variable "replicate_source_db" {
  description = "if specified, replicate the rds database at the given ARN"
  type = string
  default = null
}

variable "db_name" {
description = "Name for the DB."
type = string
default = null
}
variable "db_username" {
description = "Username for the DB."
type = string
sensitive = true
default = null
}
variable "db_password" {
description = "Password for the DB."
type = string
sensitive = true
default = null
}

output "arn" {
  value = aws_db_instance.example.arn
  description = "The ARN of the database"
}