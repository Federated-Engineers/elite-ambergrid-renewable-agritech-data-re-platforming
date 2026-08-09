resource "snowflake_grant_privileges_to_account_role" "dev_read_prod_database" {
  privileges        = ["USAGE"]
  account_role_name = "AG_DBT_DEV_ROLE"
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ambergrid_prod_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dev_read_prod_bronze" {
  privileges        = ["USAGE"]
  account_role_name = "AG_DBT_DEV_ROLE"
  on_schema {
    schema_name = snowflake_schema.bronze.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dev_read_prod_bronze_tables" {
  privileges        = ["SELECT"]
  account_role_name = "AG_DBT_DEV_ROLE"
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dev_read_prod_bronze_future_tables" {
  privileges        = ["SELECT"]
  account_role_name = "AG_DBT_DEV_ROLE"
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dev_read_prod_bronze_external_tables" {
  privileges        = ["SELECT"]
  account_role_name = "AG_DBT_DEV_ROLE"
  on_schema_object {
    all {
      object_type_plural = "EXTERNAL TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dev_read_prod_bronze_external_future_tables" {
  privileges        = ["SELECT"]
  account_role_name = "AG_DBT_DEV_ROLE"
  on_schema_object {
    future {
      object_type_plural = "EXTERNAL TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}
