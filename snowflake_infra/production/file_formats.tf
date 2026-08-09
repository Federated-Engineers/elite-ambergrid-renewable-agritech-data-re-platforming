resource "snowflake_file_format_json" "bronze_json_format" {
  name     = "SCADA_JSON"
  database = snowflake_database.ambergrid_prod_db.name
  schema   = snowflake_schema.bronze.name
  comment  = "Parses hourly SCADA bioreactor telemetry JSON landed in S3 by Airflow"
}
