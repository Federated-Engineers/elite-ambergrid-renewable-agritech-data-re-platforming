resource "dbtcloud_global_connection" "snowflake_connection" {
  name = "AmberGrid Snowflake connection"

  snowflake = {
    account   = var.snowflake_account
    database  = var.snowflake_prod_database
    warehouse = var.snowflake_prod_warehouse
  }
}
