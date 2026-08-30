resource "snowflake_grant_account_role" "dbt_core_to_atlantis" {
  role_name        = snowflake_account_role.dbt_dev_role.name
  parent_role_name = var.snowflake_role
}

resource "snowflake_grant_account_role" "airflow_dev_to_atlantis" {
  role_name        = snowflake_account_role.airflow_dev_role.name
  parent_role_name = var.snowflake_role
}
