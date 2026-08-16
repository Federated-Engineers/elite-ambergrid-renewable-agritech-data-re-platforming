resource "snowflake_grant_privileges_to_account_role" "dbt_prod_warehouse" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.service_compute.name
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

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_schemas" {
  for_each = {
    silver = snowflake_schema.silver.fully_qualified_name
    gold   = snowflake_schema.gold.fully_qualified_name
  }

  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema {
    schema_name = each.value
  }
  all_privileges = true
  always_apply   = true
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_bronze_objects" {
  for_each = toset(["TABLES", "EXTERNAL TABLES"])

  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema_object {
    all {
      object_type_plural = each.value
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_prod_bronze_future_objects" {
  for_each = toset(["TABLES", "EXTERNAL TABLES"])

  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_prod_role.name
  on_schema_object {
    future {
      object_type_plural = each.value
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}
