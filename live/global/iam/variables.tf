variable "user_names" {
  description = "Create Iam Users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}