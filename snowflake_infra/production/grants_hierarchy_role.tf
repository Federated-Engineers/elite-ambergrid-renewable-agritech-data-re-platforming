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

resource "snowflake_grant_account_role" "system_to_atlantis" {
  role_name        = snowflake_account_role.system_prod_role.name
  parent_role_name = "AMBERGRID_ATLANTIS_ROLE"
}

resource "snowflake_grant_account_role" "platform_eng_to_atlantis" {
  role_name        = snowflake_account_role.platform_eng_prod_role.name
  parent_role_name = "AMBERGRID_ATLANTIS_ROLE"
}
