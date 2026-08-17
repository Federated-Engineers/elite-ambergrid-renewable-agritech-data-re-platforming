resource "snowflake_schema" "bronze" {
  name     = "BRONZE"
  database = snowflake_database.ambergrid_dev_db.name
  comment  = "Raw landed data from the data source"
}

resource "snowflake_schema" "silver" {
  name     = "SILVER"
  database = snowflake_database.ambergrid_dev_db.name
  comment  = "Cleaned and conformed data built by dbt"
}

resource "snowflake_schema" "gold" {
  name     = "GOLD"
  database = snowflake_database.ambergrid_dev_db.name
  comment  = "Business-ready facts and dimensions built by dbt"
}
