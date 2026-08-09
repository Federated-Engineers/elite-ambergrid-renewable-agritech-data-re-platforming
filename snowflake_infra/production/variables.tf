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
  type        = string
  description = "Snowflake user that Terraform authenticates as"
  default     = "AMBERGRID_ATLANTIS"
}

variable "snowflake_role" {
  type        = string
  description = "Snowflake role that Terraform assumes; owns every object it creates and is the parent of the functional role hierarchy"
  default     = "AMBERGRID_ATLANTIS_ROLE"
}
