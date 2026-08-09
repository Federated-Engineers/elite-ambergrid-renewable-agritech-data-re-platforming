resource "snowflake_grant_privileges_to_account_role" "dbt_prod_warehouse" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.etl_wh.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_database" {
  privileges        = ["USAGE", "CREATE SCHEMA"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ambergrid_prod_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_bronze" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = snowflake_schema.bronze.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_silver" {
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = snowflake_schema.silver.fully_qualified_name
  }
  all_privileges = true
  always_apply   = true
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_gold" {
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = snowflake_schema.gold.fully_qualified_name
  }
  all_privileges = true
  always_apply   = true
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_bronze_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_bronze_future_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_bronze_external_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema_object {
    all {
      object_type_plural = "EXTERNAL TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_bronze_external_future_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema_object {
    future {
      object_type_plural = "EXTERNAL TABLES"
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}
