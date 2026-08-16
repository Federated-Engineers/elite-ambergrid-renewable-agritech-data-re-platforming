resource "snowflake_grant_privileges_to_account_role" "airflow_prod_warehouse" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_prod_role.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.service_compute.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_prod_database" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_prod_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ambergrid_prod_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_prod_bronze" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_prod_role.name
  on_schema {
    schema_name = snowflake_schema.bronze.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_prod_stage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_prod_role.name
  on_schema_object {
    object_type = "STAGE"
    object_name = snowflake_stage_external_s3.scada_telemetry_stage.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_prod_file_format" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.airflow_prod_role.name
  on_schema_object {
    object_type = "FILE FORMAT"
    object_name = snowflake_file_format_json.scada_telemetry_json_format.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_prod_bronze_tables" {
  privileges        = ["INSERT", "SELECT"]
  account_role_name = snowflake_account_role.airflow_prod_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "airflow_prod_bronze_future_tables" {
  privileges        = ["INSERT", "SELECT"]
  account_role_name = snowflake_account_role.airflow_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}
