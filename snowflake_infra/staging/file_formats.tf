resource "snowflake_file_format_json" "scada_telemetry_json_format" {
  name     = "SCADA_TELEMETRY_JSON_FORMAT"
  database = snowflake_database.ambergrid_dev_db.name
  schema   = snowflake_schema.bronze.name
  comment  = "Parses hourly SCADA bioreactor telemetry JSON landed in S3 by Airflow"
}
