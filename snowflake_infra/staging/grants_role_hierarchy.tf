resource "snowflake_grant_account_role" "dbt_core_to_sysadmin" {
  role_name        = snowflake_account_role.dbt_dev_role.name
  parent_role_name = "SYSADMIN"
}

resource "snowflake_grant_account_role" "airflow_dev_to_sysadmin" {
  role_name        = snowflake_account_role.airflow_dev_role.name
  parent_role_name = "SYSADMIN"
}
