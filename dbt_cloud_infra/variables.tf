variable "dbt_cloud_host_url" {
  type        = string
  description = "API endpoint for the dbt Cloud cell this account lives on"
  default     = "https://tr911.us1.dbt.com/api"
}

variable "dbt_cloud_account_id" {
  type        = number
  description = "dbt Cloud account identifier"
  default     = 70506183157566
}

variable "github_installation_id" {
  type        = number
  description = "Installation id of the dbt Cloud GitHub App on github repository"
  default     = 150067907
}

variable "github_remote_url" {
  type        = string
  description = "SSH remote for the github repository"
  default     = "git@github.com:Federated-Engineers/elite-ambergrid-renewable-agritech-data-re-platforming.git"
}

variable "snowflake_account" {
  type        = string
  description = "Snowflake account identifier, organization-account"
  default     = "MGUBPDR-MY23767"
}

variable "snowflake_prod_database" {
  type        = string
  description = "Snowflake database the production jobs build into"
  default     = "AMBERGRID_PROD_DB"
}

variable "snowflake_prod_warehouse" {
  type        = string
  description = "Snowflake warehouse the production jobs run on"
  default     = "AMBERGRID_SERVICE_COMPUTE_PROD"
}

variable "snowflake_prod_role" {
  type        = string
  description = "Snowflake role the production jobs assume"
  default     = "AMBERGRID_DBT_CLOUD_ROLE"
}

variable "dbt_version" {
  type        = string
  description = "dbt release track used by the deployment environments"
  default     = "fusion-stable"
}
