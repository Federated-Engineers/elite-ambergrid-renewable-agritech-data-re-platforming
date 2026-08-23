resource "snowflake_grant_privileges_to_account_role" "dbt_ci_warehouse" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_ci_role.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.service_compute.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_ci_database" {
  privileges        = ["USAGE", "CREATE SCHEMA"]
  account_role_name = snowflake_account_role.dbt_ci_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ambergrid_prod_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_ci_bronze" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_ci_role.name
  on_schema {
    schema_name = snowflake_schema.bronze.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_ci_schemas" {
  for_each = {
    silver = snowflake_schema.silver.fully_qualified_name
    gold   = snowflake_schema.gold.fully_qualified_name
  }

  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_ci_role.name
  on_schema {
    schema_name = each.value
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_ci_bronze_objects" {
  for_each = toset(["TABLES", "EXTERNAL TABLES"])

  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_ci_role.name
  on_schema_object {
    all {
      object_type_plural = each.value
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_ci_bronze_future_objects" {
  for_each = toset(["TABLES", "EXTERNAL TABLES"])

  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_ci_role.name
  on_schema_object {
    future {
      object_type_plural = each.value
      in_schema          = snowflake_schema.bronze.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_ci_mart_objects" {
  for_each = {
    silver_tables = { schema = snowflake_schema.silver.fully_qualified_name, type = "TABLES" }
    silver_views  = { schema = snowflake_schema.silver.fully_qualified_name, type = "VIEWS" }
    gold_tables   = { schema = snowflake_schema.gold.fully_qualified_name, type = "TABLES" }
    gold_views    = { schema = snowflake_schema.gold.fully_qualified_name, type = "VIEWS" }
  }

  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_ci_role.name
  on_schema_object {
    all {
      object_type_plural = each.value.type
      in_schema          = each.value.schema
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_ci_mart_future_objects" {
  for_each = {
    silver_tables = { schema = snowflake_schema.silver.fully_qualified_name, type = "TABLES" }
    silver_views  = { schema = snowflake_schema.silver.fully_qualified_name, type = "VIEWS" }
    gold_tables   = { schema = snowflake_schema.gold.fully_qualified_name, type = "TABLES" }
    gold_views    = { schema = snowflake_schema.gold.fully_qualified_name, type = "VIEWS" }
  }

  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_ci_role.name
  on_schema_object {
    future {
      object_type_plural = each.value.type
      in_schema          = each.value.schema
    }
  }
}
