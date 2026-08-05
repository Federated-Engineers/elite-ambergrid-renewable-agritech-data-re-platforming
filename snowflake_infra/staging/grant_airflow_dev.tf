resource "snowflake_grant_privileges_to_account_role" "airflow_dev_warehouse" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_dev_role.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.ag_dev_wh.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_dev_database" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_dev_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ambergrid_dev_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_dev_bronze" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_dev_role.name
  on_schema {
    schema_name = snowflake_schema.bronze_dev.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_stage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_dev_role.name
  on_schema_object {
    object_type = "STAGE"
    object_name = snowflake_stage_external_s3.bronze_s3_stage.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_file_format" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_dev_role.name
  on_schema_object {
    object_type = "FILE FORMAT"
    object_name = snowflake_file_format.bronze_json_format.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_raw_daily_load" {
  privileges        = ["INSERT", "SELECT"]
  account_role_name = snowflake_account_role.airflow_dev_role.name
  on_schema_object {
    object_type = "TABLE"
    object_name = snowflake_table.bronze_raw_daily_load.fully_qualified_name
  }
}