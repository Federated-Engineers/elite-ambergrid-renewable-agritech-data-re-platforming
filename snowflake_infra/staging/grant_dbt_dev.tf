resource "snowflake_grant_privileges_to_account_role" "dbt_dev_warehouse" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_dev_role.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.ag_dev_wh.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_dev_database" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_dev_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ambergrid_dev_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_dev_bronze" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_dev_role.name
  on_schema {
    schema_name = snowflake_schema.bronze.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_dev_silver" {
  account_role_name = snowflake_account_role.dbt_dev_role.name
  on_schema {
    schema_name = snowflake_schema.silver.fully_qualified_name
  }
  all_privileges = true
  always_apply   = true
}

resource "snowflake_grant_privileges_to_account_role" "dbt_dev_gold" {
  account_role_name = snowflake_account_role.dbt_dev_role.name
  on_schema {
    schema_name = snowflake_schema.gold.fully_qualified_name
  }
  all_privileges = true
  always_apply   = true
}

resource "snowflake_grant_privileges_to_account_role" "dbt_bronze_dev_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_dev_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_bronze_dev_future_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_dev_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_bronze_dev_external_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_dev_role.name
  on_schema_object {
    all {
      object_type_plural = "EXTERNAL TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_bronze_dev_external_future_table" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_dev_role.name

  on_schema_object {
    future {
      object_type_plural = "EXTERNAL TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}
