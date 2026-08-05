resource "snowflake_schema" "bronze_dev" {
  name     = "BRONZE_DEV"
  database = snowflake_database.ambergrid_dev_db.name
  comment  = "Raw landed data from the data source"
}

resource "snowflake_schema" "silver_dev" {
  name     = "SILVER_DEV"
  database = snowflake_database.ambergrid_dev_db.name
  comment  = "Cleaned and conformed data built by dbt dev"
}

resource "snowflake_schema" "gold_dev" {
  name     = "GOLD_DEV"
  database = snowflake_database.ambergrid_dev_db.name
  comment  = "Business-ready facts and dimensions built by dbt dev"
}