resource "snowflake_storage_integration_aws" "scada" {
  name                      = "AMBERGRID_S3_INT_PROD"
  enabled                   = true
  storage_provider          = "S3"
  storage_aws_role_arn      = "arn:aws:iam::049417293525:role/elite-snowflake-role"
  storage_allowed_locations = ["s3://ambergrid-iot-telemetry-lake/raw/scada-telemetry/"]
  comment                   = "Delegates read access to the raw SCADA telemetry prefix in S3"
}
