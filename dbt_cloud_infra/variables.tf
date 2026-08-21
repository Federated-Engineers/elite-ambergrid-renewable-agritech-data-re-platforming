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