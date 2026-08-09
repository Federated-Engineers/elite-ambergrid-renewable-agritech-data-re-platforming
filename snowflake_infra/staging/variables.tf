variable "snowflake_organization_name" {
  type        = string
  description = "Snowflake organization name"
  default     = "MGUBPDR"
}

variable "snowflake_account_name" {
  type        = string
  description = "Snowflake account name within the organization"
  default     = "MY23767"
}

variable "snowflake_user" {
  type      = string
  sensitive = true
  default   = "AMBERGRID_ATLANTIS"
}