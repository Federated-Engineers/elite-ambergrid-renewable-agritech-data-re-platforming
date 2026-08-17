resource "snowflake_grant_privileges_to_account_role" "data_eng_prod_warehouse" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.data_eng_prod_role.name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = module.data_eng_compute.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "data_eng_prod_database" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.data_eng_prod_role.name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.ambergrid_prod_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "data_eng_prod_bronze" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.data_eng_prod_role.name
  on_schema {
    schema_name = snowflake_schema.bronze.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "data_eng_prod_schemas" {
  for_each = {
    silver = snowflake_schema.silver.fully_qualified_name
    gold   = snowflake_schema.gold.fully_qualified_name
  }

  account_role_name = snowflake_account_role.data_eng_prod_role.name
  on_schema {
    schema_name = each.value
  }
  all_privileges = true
}

resource "snowflake_grant_privileges_to_account_role" "data_eng_prod_objects" {
  for_each = {
    bronze_tables          = { schema = snowflake_schema.bronze.fully_qualified_name, type = "TABLES" }
    bronze_external_tables = { schema = snowflake_schema.bronze.fully_qualified_name, type = "EXTERNAL TABLES" }
    silver_tables          = { schema = snowflake_schema.silver.fully_qualified_name, type = "TABLES" }
    silver_views           = { schema = snowflake_schema.silver.fully_qualified_name, type = "VIEWS" }
    gold_tables            = { schema = snowflake_schema.gold.fully_qualified_name, type = "TABLES" }
    gold_views             = { schema = snowflake_schema.gold.fully_qualified_name, type = "VIEWS" }
  }

  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.data_eng_prod_role.name
  on_schema_object {
    all {
      object_type_plural = each.value.type
      in_schema          = each.value.schema
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "data_eng_prod_future_objects" {
  for_each = {
    bronze_tables          = { schema = snowflake_schema.bronze.fully_qualified_name, type = "TABLES" }
    bronze_external_tables = { schema = snowflake_schema.bronze.fully_qualified_name, type = "EXTERNAL TABLES" }
    silver_tables          = { schema = snowflake_schema.silver.fully_qualified_name, type = "TABLES" }
    silver_views           = { schema = snowflake_schema.silver.fully_qualified_name, type = "VIEWS" }
    gold_tables            = { schema = snowflake_schema.gold.fully_qualified_name, type = "TABLES" }
    gold_views             = { schema = snowflake_schema.gold.fully_qualified_name, type = "VIEWS" }
  }

  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.data_eng_prod_role.name
  on_schema_object {
    future {
      object_type_plural = each.value.type
      in_schema          = each.value.schema
    }
  }
}
