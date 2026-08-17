resource "snowflake_grant_privileges_to_account_role" "platform_eng_prod_warehouse" {
  privileges        = ["MODIFY", "MONITOR", "OPERATE", "USAGE"]
  account_role_name = snowflake_account_role.platform_eng_prod_role.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.service_compute.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "platform_eng_prod_database" {
  privileges        = ["CREATE SCHEMA", "MODIFY", "MONITOR", "USAGE"]
  account_role_name = snowflake_account_role.platform_eng_prod_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ambergrid_prod_db.name
  }
}