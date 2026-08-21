data "aws_ssm_parameter" "dbt_cloud_service_token" {
  name = "/production/elite/dbt_cloud/ambergrid/service_token"
}
