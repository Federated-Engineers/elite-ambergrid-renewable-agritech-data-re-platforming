resource "snowflake_grant_account_role" "dbt_to_system" {
  role_name        = snowflake_account_role.dbt_prod_role.name
  parent_role_name = snowflake_account_role.system_prod_role.name
}

resource "snowflake_grant_account_role" "airflow_to_system" {
  role_name        = snowflake_account_role.airflow_prod_role.name
  parent_role_name = snowflake_account_role.system_prod_role.name
}

resource "snowflake_grant_account_role" "data_eng_to_platform_eng" {
  role_name        = snowflake_account_role.data_eng_prod_role.name
  parent_role_name = snowflake_account_role.platform_eng_prod_role.name
}

resource "snowflake_grant_account_role" "dbt_ci_to_system" {
  role_name        = snowflake_account_role.dbt_ci_role.name
  parent_role_name = snowflake_account_role.system_prod_role.name
}

resource "snowflake_grant_account_role" "system_to_sysadmin" {
  role_name        = snowflake_account_role.system_prod_role.name
  parent_role_name = "SYSADMIN"
}

resource "snowflake_grant_account_role" "platform_eng_to_sysadmin" {
  role_name        = snowflake_account_role.platform_eng_prod_role.name
  parent_role_name = "SYSADMIN"
}
