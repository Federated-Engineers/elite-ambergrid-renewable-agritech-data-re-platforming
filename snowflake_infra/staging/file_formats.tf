resource "snowflake_file_format_json" "scada_telemetry_json_format" {
  name     = "SCADA_TELEMETRY_JSON_FORMAT"
  database = snowflake_database.ambergrid_dev_db.name
  schema   = snowflake_schema.bronze.name
  comment  = "Parses hourly SCADA bioreactor telemetry JSON landed in S3 by Airflow"
}

resource "snowflake_file_format_json" "gsheet_json_array_format" {
  name              = "GSHEET_JSON_ARRAY_FORMAT"
  database          = snowflake_database.ambergrid_dev_db.name
  schema            = snowflake_schema.bronze.name
  strip_outer_array = "true"
  comment           = "Parses JSON array payloads from the AmberGrid Lab Ledger snapshots"
}

resource "snowflake_file_format_json" "postgres_json_format" {
  name              = "POSTGRES_JSON_FORMAT"
  database          = snowflake_database.ambergrid_dev_db.name
  schema            = snowflake_schema.bronze.name
  strip_outer_array = "true"
  comment           = "Parses JSON array payloads extracted from the AmberGrid operational Postgres"
}
