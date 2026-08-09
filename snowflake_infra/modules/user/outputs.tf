output "name" {
  value       = snowflake_user.user.name
  description = "Name of the created Snowflake user"
}

output "login_name" {
  value       = snowflake_user.user.login_name
  description = "Login name of the created Snowflake user"
  sensitive   = true
}