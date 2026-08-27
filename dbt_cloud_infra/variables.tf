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

variable "snowflake_dbt_cloud_user" {
  type        = string
  description = "Snowflake service user the scheduled production job authenticates as"
  default     = "AMBERGRID_DBT_CLOUD_USR"
}

variable "snowflake_dbt_ci_user" {
  type        = string
  description = "Snowflake service user the Slim CI job authenticates as"
  default     = "AMBERGRID_DBT_CI_USR"
}

variable "snowflake_ci_role" {
  type        = string
  description = "Snowflake role the CI job assumes; reads production, writes only to pull request schemas"
  default     = "AMBERGRID_DBT_CI_ROLE"
}

variable "dbt_prod_schema" {
  type        = string
  description = "Fallback schema for production models that declare no custom schema"
  default     = "SILVER"
}

variable "dbt_ci_schema" {
  type        = string
  description = "Placeholder schema for CI. dbt Cloud overrides this per pull request"
  default     = "DBT_CLOUD_CI"
}

variable "dbt_threads" {
  type        = number
  description = "Threads used by the dbt Cloud jobs"
  default     = 8
}
