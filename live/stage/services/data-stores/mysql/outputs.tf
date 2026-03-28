output "address" {
value = aws_db_instance.example.address
description = "Connect to the database at this endpoint"
}

output "port" {
value = aws_db_instance.example.port
description = "The port the database is listening on"
}

output "db_connection_string" {
  value = "mysql://${aws_db_instance.example.username}@${aws_db_instance.example.endpoint}"
  sensitive = true
}