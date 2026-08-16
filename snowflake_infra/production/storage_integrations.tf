resource "snowflake_storage_integration_aws" "scada_telemetry_integration" {
  name                      = "AMBERGRID_SCADA_TELEMETRY_INTEGRATION_PROD"
  enabled                   = true
  storage_provider          = "S3"
  storage_aws_role_arn      = var.snowflake_s3_role_arn
  storage_allowed_locations = [var.scada_telemetry_s3_uri]
  comment                   = "Delegates read access to the raw SCADA telemetry prefix in S3"
}
