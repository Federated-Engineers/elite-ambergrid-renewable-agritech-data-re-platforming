resource "snowflake_stage_external_s3" "scada_telemetry_stage" {
  name                = "SCADA_TELEMETRY_STAGE"
  database            = snowflake_database.ambergrid_prod_db.name
  schema              = snowflake_schema.bronze.name
  url                 = var.scada_telemetry_s3_uri
  storage_integration = snowflake_storage_integration_aws.scada_telemetry_integration.name
  comment             = "Raw SCADA telemetry, partitioned by plant then reading date"

  file_format {
    format_name = snowflake_file_format_json.scada_telemetry_json_format.fully_qualified_name
  }
}