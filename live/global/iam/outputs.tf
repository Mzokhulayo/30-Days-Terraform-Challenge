# output "first_arn" {
#   value = aws_iam_user.example[0].arn
#   description = "The ARN for the first user"
# }

# output "all_iam_arns" {
#   value = aws_iam_user.example[*].arn
#   description = "The ARNs for all users"
# }

output "all_users" {
  value = aws_iam_user.example
}

output "all_arns" {
  value = values(aws_iam_user.example)[*].arn

}

output "name" {
  value = [for name in var.user_names : upper(name)]
}

################ multiple providers ###########################

output "aws_region_1" {
  value       = data.aws_region.region_1.name
  description = "The name of the first region"
}

output "aws_region_2" {
  value       = data.aws_region.region_2.name
  description = "The name of the second region"
}

output "instance_region_1_az" {
  value       = aws_instance.region_1.availability_zone
  description = "The AZ where the instance in the 1st region id deployed"
}

output "instance_region_2_az" {
  value       = aws_instance.aws_region_2.availability_zone
  description = "The AZ where the instance in the 2nd region id deployed"
}