resource "dbtcloud_project" "ambergrid_project" {
  name                     = "ambergrid_dbt"
  description              = "AmberGrid analytics, dbt models on snowflake"
  dbt_project_subdirectory = "ambergrid_dbt"
}
