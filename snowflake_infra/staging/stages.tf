resource "snowflake_stage_external_s3" "bronze_s3_stage" {
  name                = "SCADA_S3"
  database            = snowflake_database.ambergrid_dev_db.name
  schema              = snowflake_schema.bronze.name
  url                 = "s3://ambergrid-iot-telemetry-lake/raw/scada-telemetry/"
  storage_integration = snowflake_storage_integration_aws.scada.name
  comment             = "Raw SCADA telemetry, partitioned by plant then reading date"

  file_format {
    format_name = snowflake_file_format_json.bronze_json_format.fully_qualified_name
  }
}
