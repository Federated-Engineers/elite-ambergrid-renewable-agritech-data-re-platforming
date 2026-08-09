resource "snowflake_database" "ambergrid_prod_db" {
  name    = "AMBERGRID_PROD_DB"
  comment = "Ambergrid production data platform"
}