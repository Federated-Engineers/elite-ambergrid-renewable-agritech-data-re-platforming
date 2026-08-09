variable "name" {
  type        = string
  description = "Snowflake user name"
}

variable "login_name" {
  type        = string
  description = "Login name used to authenticate"
}

variable "password" {
  type        = string
  description = "Password for password-based login auth"
  sensitive   = true
}

variable "email" {
  type        = string
  description = "User email address"
  default     = null
}

variable "display_name" {
  type        = string
  description = "Display name shown in Snowflake"
  default     = null
}

variable "comment" {
  type        = string
  description = "User description"
  default     = "Managed by Terraform"
}

variable "disabled" {
  type        = string
  description = "Whether the user is disabled"
  default     = "false"
}

variable "default_warehouse" {
  type        = string
  description = "Default warehouse for the user"
  default     = null
}

variable "default_role" {
  type        = string
  description = "Default role for the user"
  default     = null
}

variable "must_change_password" {
  type        = string
  description = "Force password change on next login"
  default     = "false"
}

variable "disable_mfa" {
  type        = string
  description = "Disable MFA"
  default     = "true"
}