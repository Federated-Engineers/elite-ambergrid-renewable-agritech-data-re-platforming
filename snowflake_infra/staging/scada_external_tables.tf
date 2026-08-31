resource "snowflake_external_table" "scada_telemetry" {
  name        = "SCADA_TELEMETRY"
  database    = snowflake_database.ambergrid_dev_db.name
  schema      = snowflake_schema.bronze.name
  location    = "@${snowflake_stage_external_s3.scada_telemetry_stage.fully_qualified_name}"
  file_format = "FORMAT_NAME = ${snowflake_file_format_json.scada_telemetry_json_format.fully_qualified_name}"
  comment     = "Bronze: hourly SCADA bioreactor telemetry read in place from S3, partitioned by plant then reading date"

  column {
    name = "RAW_RECORD"
    type = "VARIANT"
    as   = "VALUE"
  }

  column {
    name = "PLANT_ID"
    type = "VARCHAR"
    as   = "split_part(metadata$filename, '/', 3)"
  }

  column {
    name = "READING_DATE"
    type = "DATE"
    as   = "to_date(split_part(metadata$filename, '/', 4), 'YYYY-MM-DD')"
  }

  column {
    name = "SOURCE_FILE_NAME"
    type = "VARCHAR"
    as   = "metadata$filename"
  }

  partition_by = ["PLANT_ID", "READING_DATE"]
}
